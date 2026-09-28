// End-to-end smoke test: the generated client against a real running
// development server, over HTTP and WebSocket.
//
//   cd homeslot_server
//   dart run bin/main.dart --apply-migrations > /tmp/homeslot.log 2>&1 &
//   cd ../e2e && dart run bin/e2e.dart /tmp/homeslot.log
//
// The server log is read to get the email verification codes, which the
// development server prints instead of sending (no SMTP configured).
// Set SERVER_URL to test another server.
import 'dart:async';
import 'dart:io';

import 'package:homeslot_client/homeslot_client.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

final url = Platform.environment['SERVER_URL'] ?? 'http://localhost:8080/';
late final String logFile;
var failures = 0;

void check(bool ok, String what) {
  stdout.writeln('${ok ? 'PASS' : 'FAIL'}  $what');
  if (!ok) failures++;
}

class BearerKey implements ClientAuthKeyProvider {
  String? token;
  @override
  Future<String?> get authHeaderValue async =>
      token == null ? null : wrapAsBearerAuthHeaderValue(token!);
}

Future<String> codeFor(String email) async {
  final pattern = RegExp(
    'Registration code for ${RegExp.escape(email)}: (\\S+)',
  );
  for (var i = 0; i < 50; i++) {
    final match = pattern.firstMatch(await File(logFile).readAsString());
    if (match != null) return match.group(1)!;
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }
  throw StateError('No verification code for $email in the server log');
}

Future<(Client, BearerKey)> register(String email) async {
  final key = BearerKey();
  final client = Client(url)..authKeyProvider = key;
  final requestId = await client.emailIdp.startRegistration(email: email);
  final code = await codeFor(email);
  final token = await client.emailIdp.verifyRegistrationCode(
    accountRequestId: requestId,
    verificationCode: code,
  );
  final success = await client.emailIdp.finishRegistration(
    registrationToken: token,
    password: 'Str0ng!Passw0rd-e2e',
  );
  key.token = success.token;
  return (client, key);
}

Future<void> main(List<String> args) async {
  logFile = args.single;
  tzdata.initializeTimeZones();
  final bkk = tz.getLocation('Asia/Bangkok');
  final stamp = DateTime.now().millisecondsSinceEpoch;
  DateTime at(int dayOffset, int hour, [int minute = 0]) {
    final now = tz.TZDateTime.now(bkk);
    final t = tz.TZDateTime(
      bkk,
      now.year,
      now.month,
      now.day + dayOffset,
      hour,
      minute,
    );
    return DateTime.fromMicrosecondsSinceEpoch(
      t.microsecondsSinceEpoch,
      isUtc: true,
    );
  }

  // Unauthenticated calls are refused (SRS 4.1).
  try {
    await Client(url).account.me();
    check(false, 'unauthenticated call refused');
  } on ServerpodClientUnauthorized {
    check(true, 'unauthenticated call refused (401)');
  }

  // Register two users through the real email flow (SRS 2.1.1).
  final (owner, _) = await register('owner$stamp@example.com');
  final (member, _) = await register('member$stamp@example.com');
  check(true, 'email registration with verification code');

  final me = await owner.household.create('Smoke home', 'Asia/Bangkok');
  check(me.role == MemberRole.owner, 'create household -> owner');
  final room = (await owner.room.create(
    Room(householdId: 0, name: 'Office', type: RoomType.office),
    [],
  )).room;
  final invite = await owner.household.createInvite();
  final joined = await member.household.join(invite.code);
  check(joined.household?.id == me.household?.id, 'join with 6-digit code');

  // Owner-only actions are checked on the server.
  try {
    await member.household.createInvite();
    check(false, 'member cannot create invites');
  } on AppException catch (e) {
    check(e.code == AppErrorCode.notOwner, 'member cannot create invites');
  }

  // Real-time: the member's calendar gets the owner's booking (SRS 2.3.8).
  final events = <HouseholdEvent>[];
  final firstEvent = Completer<Duration>();
  final watch = Stopwatch();
  final sub = member.events.subscribe().listen((e) {
    events.add(e);
    if (e.type == HouseholdEventType.bookingsChanged &&
        !firstEvent.isCompleted) {
      firstEvent.complete(watch.elapsed);
    }
  });
  await Future<void>.delayed(const Duration(seconds: 1));

  watch.start();
  final created = Stopwatch()..start();
  final booked = await owner.booking.create(
    BookingRequest(
      roomId: room.id!,
      startAt: at(1, 10),
      endAt: at(1, 11),
      purpose: 'Standup',
    ),
  );
  created.stop();
  check(booked.booking.status == BookingStatus.confirmed, 'booking confirmed');
  check(
    created.elapsedMilliseconds < 1000,
    'booking created in ${created.elapsedMilliseconds} ms (< 1 s, SRS 4.2)',
  );
  final latency = await firstEvent.future.timeout(
    const Duration(seconds: 5),
    onTimeout: () => const Duration(days: 1),
  );
  check(
    latency < const Duration(seconds: 2),
    'real-time event reached the other member in ${latency.inMilliseconds} ms (< 2 s)',
  );

  // Overlap is rejected with nearby suggestions, over the wire (SRS 2.3.3).
  try {
    await member.booking.create(
      BookingRequest(
        roomId: room.id!,
        startAt: at(1, 10, 30),
        endAt: at(1, 11, 30),
      ),
    );
    check(false, 'overlap rejected');
  } on BookingException catch (e) {
    check(
      e.code == BookingErrorCode.overlap,
      'overlap rejected: "${e.message}"',
    );
    check(
      (e.suggestions ?? []).isNotEmpty,
      'suggestions returned (${e.suggestions!.length})',
    );
  }

  // Concurrent requests for one slot over HTTP: exactly one wins (SRS 4.4).
  final results = await Future.wait([
    for (final c in [owner, member, owner, member])
      c.booking
          .create(
            BookingRequest(
              roomId: room.id!,
              startAt: at(2, 14),
              endAt: at(2, 15),
            ),
          )
          .then<Object>((v) => v, onError: (Object e) => e),
  ]);
  check(
    results.whereType<BookingView>().length == 1,
    'concurrent requests: ${results.whereType<BookingView>().length} of 4 succeeded',
  );

  // Weekly series with a conflict preview (SRS 2.3.5).
  final preview = await member.booking.previewSeries(
    SeriesRequest(
      roomId: room.id!,
      startAt: at(1, 10),
      endAt: at(1, 11),
      weeks: 4,
      skipStarts: [],
    ),
  );
  check(
    preview.length == 4 &&
        !preview.first.ok &&
        preview.skip(1).every((o) => o.ok),
    'series preview marks the conflicting week',
  );

  final status = await member.room.statusNow();
  check(status.single.room.id == room.id, 'home screen room status');
  final mine = await owner.booking.mine(true, 20, 0);
  check(mine.isNotEmpty, 'my upcoming bookings');
  final stats = await owner.stats.usage(
    StatsPeriod.month,
    DateTime.now().toUtc(),
  );
  check(stats.byRoom.isNotEmpty, 'usage statistics');
  final notes = await member.notification.list();
  check(notes.isEmpty || notes.first.title.isNotEmpty, 'notification history');

  await sub.cancel();
  owner.close();
  member.close();
  stdout.writeln(
    failures == 0 ? '\nALL CHECKS PASSED' : '\n$failures CHECK(S) FAILED',
  );
  exit(failures == 0 ? 0 : 1);
}
