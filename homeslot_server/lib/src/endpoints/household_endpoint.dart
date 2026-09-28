import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/household_service.dart';
import '../services/membership.dart';

/// Household, invitations and members (SRS 2.1.3 - 2.1.7).
class HouseholdEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<MeInfo> create(Session session, String name, String timezone) =>
      HouseholdService.create(session, name: name, timezone: timezone);

  Future<Household> update(
    Session session,
    String name,
    String timezone,
  ) async => HouseholdService.update(
    session,
    await Membership.requireOwner(session),
    name: name,
    timezone: timezone,
  );

  Future<List<MemberInfo>> members(Session session) async =>
      HouseholdService.members(
        session,
        await Membership.requireMember(session),
      );

  Future<Invitation> createInvite(Session session) async =>
      HouseholdService.createInvite(
        session,
        await Membership.requireOwner(session),
      );

  Future<List<Invitation>> activeInvites(Session session) async =>
      HouseholdService.activeInvites(
        session,
        await Membership.requireOwner(session),
      );

  Future<void> revokeInvite(Session session, int invitationId) async =>
      HouseholdService.revokeInvite(
        session,
        await Membership.requireOwner(session),
        invitationId,
      );

  Future<MeInfo> join(Session session, String code) =>
      HouseholdService.join(session, code);

  Future<MemberInfo> changeRole(
    Session session,
    int userId,
    MemberRole role,
  ) async => HouseholdService.changeRole(
    session,
    await Membership.requireOwner(session),
    userId: userId,
    role: role,
  );

  Future<void> removeMember(Session session, int userId) async =>
      HouseholdService.removeMember(
        session,
        await Membership.requireOwner(session),
        userId,
      );

  Future<void> leave(Session session) async =>
      HouseholdService.leave(session, await Membership.requireMember(session));
}
