import 'package:homeslot_server/src/generated/protocol.dart';
import 'package:homeslot_server/src/util/clock.dart';
import 'package:homeslot_server/src/util/time_zones.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:timezone/timezone.dart' as tz;

import 'test_tools/serverpod_test_tools.dart';

export 'test_tools/serverpod_test_tools.dart';

/// Monday 7 January 2030, 08:00 in Bangkok. All integration tests run with
/// this fixed "now" so dates and weekdays are predictable.
final testNow = bkk(2030, 1, 7, 8);

/// Bangkok wall-clock time as UTC.
DateTime bkk(int y, int m, int d, [int h = 0, int min = 0]) {
  TimeZones.init();
  return TimeZones.utc(
    tz.TZDateTime(TimeZones.location('Asia/Bangkok'), y, m, d, h, min),
  );
}

/// Sets up the clock and auth services shared by every integration test.
void setUpHomeSlot() {
  TimeZones.init();
  clock = FixedClock(testNow);
  try {
    AuthServices.instance;
  } catch (_) {
    AuthServices.set(tokenManagerBuilders: [JwtConfigFromPasswords()]);
  }
}

void moveClockTo(DateTime utc) => clock = FixedClock(utc);

/// A signed-in test user with their own session.
class TestUser {
  TestUser(TestSessionBuilder base, {String? authUserId})
    : authUserId = authUserId ?? const Uuid().v4(),
      session = base;

  final String authUserId;
  TestSessionBuilder session;

  TestSessionBuilder get s => session;

  static TestUser create(TestSessionBuilder base, {String? authUserId}) {
    final id = authUserId ?? const Uuid().v4();
    return TestUser(
      base.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(id, {}),
      ),
      authUserId: id,
    );
  }
}

/// An owner with a household, one member and one room.
class Household3 {
  Household3(this.owner, this.member, this.room);

  final TestUser owner;
  final TestUser member;
  final Room room;
}

Future<Household3> createHousehold(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints, {
  Room? room,
  List<RoomHours> hours = const [],
}) async {
  final owner = TestUser.create(sessionBuilder);
  final member = TestUser.create(sessionBuilder);
  await endpoints.household.create(owner.s, 'Test home', 'Asia/Bangkok');
  await endpoints.account.updateProfile(owner.s, 'Owner', '#E57373', null);
  final invite = await endpoints.household.createInvite(owner.s);
  await endpoints.household.join(member.s, invite.code);
  await endpoints.account.updateProfile(member.s, 'Member', '#4FC3F7', null);
  final created = await endpoints.room.create(
    owner.s,
    room ?? Room(householdId: 0, name: 'Office', type: RoomType.office),
    hours,
  );
  return Household3(owner, member, created.room);
}

BookingRequest request(
  Room room,
  DateTime start,
  DateTime end, {
  String? purpose,
}) => BookingRequest(
  roomId: room.id!,
  startAt: start,
  endAt: end,
  purpose: purpose,
);
