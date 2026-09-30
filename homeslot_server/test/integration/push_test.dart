import 'dart:async';
import 'dart:convert';

import 'package:homeslot_server/src/generated/protocol.dart';
import 'package:homeslot_server/src/services/push_sender.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'helpers.dart';

/// Push notifications (SRS 2.5) are delivered in the background: booking
/// actions never wait for Firebase Cloud Messaging and never fail because of
/// it.
void main() {
  final real = PushSender.instance;

  withServerpod('Push delivery', (sessionBuilder, endpoints) {
    setUp(setUpHomeSlot);
    tearDown(() => PushSender.instance = real);

    /// A household whose room needs approval, with a phone for each member.
    Future<Household3> homeWithPhones() async {
      final h = await createHousehold(
        sessionBuilder,
        endpoints,
        room: Room(
          householdId: 0,
          name: 'Guest room',
          type: RoomType.guest,
          requiresApproval: true,
        ),
      );
      await endpoints.account.registerDevice(h.owner.s, 'owner-phone', 'ios');
      await endpoints.account.registerDevice(
        h.member.s,
        'member-phone',
        'android',
      );
      return h;
    }

    test('a slow push service does not hold up booking actions', () async {
      final h = await homeWithPhones();
      final fcm = _Fcm();
      PushSender.instance = PushSender.withClient(fcm);

      // FCM has not answered any of these when they return.
      const limit = Duration(seconds: 5);
      final pending = await endpoints.booking
          .create(
            h.member.s,
            request(h.room, bkk(2030, 1, 8, 10), bkk(2030, 1, 8, 11)),
          )
          .timeout(limit);
      final approved = await endpoints.booking
          .approve(h.owner.s, pending.booking.id!, EditScope.single)
          .timeout(limit);

      expect(approved.single.booking.status, BookingStatus.confirmed);
      expect(fcm.sentTo, ['owner-phone', 'member-phone']);
      fcm.answer();
      await _settle();
    });

    test('a failing push service never fails the action', () async {
      final h = await homeWithPhones();
      final fcm = _Fcm(error: StateError('OAuth token refresh failed'));
      PushSender.instance = PushSender.withClient(fcm..answer());

      final pending = await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 8, 10), bkk(2030, 1, 8, 11)),
      );
      final approved = await endpoints.booking.approve(
        h.owner.s,
        pending.booking.id!,
        EditScope.single,
      );

      expect(approved.single.booking.status, BookingStatus.confirmed);
      // The notification is still in the app.
      final notes = await endpoints.notification.list(h.member.s);
      expect(notes.first.type, NotificationType.bookingApproved);
      await _settle();
    });
  });

  withServerpod(
    'Push token cleanup',
    // The cleanup runs in its own session after the request, so it must see
    // committed rows.
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUp(setUpHomeSlot);
      tearDown(() => PushSender.instance = real);

      test('a phone without the app any more stops getting pushes', () async {
        final session = sessionBuilder.build();
        final user = await AppUser.db.insertRow(
          session,
          AppUser(displayName: 'Old phone', color: '#90A4AE'),
        );
        addTearDown(() => AppUser.db.deleteRow(session, user));
        await DeviceToken.db.insertRow(
          session,
          DeviceToken(userId: user.id!, token: 'uninstalled', platform: 'ios'),
        );
        Future<int> tokens() => DeviceToken.db.count(
          session,
          where: (t) => t.userId.equals(user.id),
        );

        await PushSender.withClient(
          _Fcm(status: 404)..answer(),
        ).send(session, userId: user.id!, title: 'Reminder', body: 'Office');

        for (var i = 0; i < 50 && await tokens() > 0; i++) {
          await Future<void>.delayed(const Duration(milliseconds: 20));
        }
        expect(await tokens(), 0);
      });
    },
  );
}

/// Lets background delivery and its logging finish before the test ends.
Future<void> _settle() =>
    Future<void>.delayed(const Duration(milliseconds: 200));

/// A stand-in for FCM that answers only when the test calls [answer].
class _Fcm extends http.BaseClient {
  _Fcm({this.status = 200, this.error});

  final int status;
  final Object? error;
  final _answered = Completer<void>();

  /// The device tokens pushed to, in order.
  final sentTo = <String>[];

  void answer() => _answered.complete();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Recorded before the first await, so it is there when the action returns.
    final body = jsonDecode((request as http.Request).body);
    sentTo.add(body['message']['token'] as String);
    await _answered.future;
    if (error case final error?) throw error;
    return http.StreamedResponse(Stream.value(utf8.encode('{}')), status);
  }
}
