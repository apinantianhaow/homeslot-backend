import 'package:serverpod/serverpod.dart';
import 'package:timezone/timezone.dart' as tz;

import '../generated/protocol.dart';
import '../util/errors.dart';
import '../util/messages.dart';
import '../util/time_zones.dart';
import 'users.dart';

/// The signed-in user acting inside their household.
class Actor {
  Actor({required this.user, required this.member, required this.household});

  final AppUser user;
  final HouseholdMember member;
  final Household household;

  int get userId => user.id!;
  int get householdId => household.id!;
  bool get isOwner => member.role == MemberRole.owner;
  tz.Location get location => TimeZones.location(household.timezone);
  Messages get messages => Messages.of(user.locale);
}

/// Membership and permission checks. Every household-scoped endpoint goes
/// through here so data of other households is never read or written
/// (SRS 4.1). Owner rights are always checked on the server.
abstract final class Membership {
  static const maxMembers = 20;

  static Future<HouseholdMember?> memberOf(
    Session session,
    int userId, {
    Transaction? transaction,
  }) => HouseholdMember.db.findFirstRow(
    session,
    where: (t) => t.userId.equals(userId),
    transaction: transaction,
  );

  static Future<Actor> requireMember(Session session) async {
    final user = await Users.current(session);
    final member = await memberOf(session, user.id!);
    if (member == null) {
      fail(AppErrorCode.notMember, 'You are not a member of a household.');
    }
    final household = await Household.db.findById(session, member.householdId);
    if (household == null) {
      fail(AppErrorCode.notMember, 'Household not found.');
    }
    return Actor(user: user, member: member, household: household);
  }

  static Future<Actor> requireOwner(Session session) async {
    final actor = await requireMember(session);
    if (!actor.isOwner) {
      fail(AppErrorCode.notOwner, 'Only household owners can do this.');
    }
    return actor;
  }

  static Future<List<HouseholdMember>> members(
    Session session,
    int householdId, {
    Transaction? transaction,
  }) => HouseholdMember.db.find(
    session,
    where: (t) => t.householdId.equals(householdId),
    orderBy: (t) => t.joinedAt,
    transaction: transaction,
  );

  static Future<List<int>> ownerIds(
    Session session,
    int householdId, {
    Transaction? transaction,
  }) async {
    final owners = await HouseholdMember.db.find(
      session,
      where: (t) =>
          t.householdId.equals(householdId) & t.role.equals(MemberRole.owner),
      transaction: transaction,
    );
    return owners.map((m) => m.userId).toList();
  }
}
