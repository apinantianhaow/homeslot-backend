import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../util/clock.dart';
import '../util/errors.dart';
import '../util/palette.dart';
import '../util/time_zones.dart';
import 'booking_service.dart';
import 'membership.dart';
import 'notifier.dart';
import 'realtime.dart';
import 'users.dart';

/// Households, invitations and membership changes (SRS 2.1).
abstract final class HouseholdService {
  static const inviteLifetime = Duration(hours: 48);
  static const maxFailedAttempts = 5;
  static const attemptWindow = Duration(minutes: 15);

  static final _random = Random.secure();

  static Future<MeInfo> me(Session session) async {
    final user = await Users.current(session);
    final member = await Membership.memberOf(session, user.id!);
    final household = member == null
        ? null
        : await Household.db.findById(session, member.householdId);
    return MeInfo(user: user, household: household, role: member?.role);
  }

  static Future<MeInfo> create(
    Session session, {
    required String name,
    required String timezone,
  }) async {
    final user = await Users.current(session);
    if (await Membership.memberOf(session, user.id!) != null) {
      fail(AppErrorCode.alreadyMember, 'You already belong to a household.');
    }
    final cleanName = cleanRequired(name, max: 60, field: 'Household name');
    final zone = timezone.trim().isEmpty ? TimeZones.defaultZone : timezone;
    if (!TimeZones.isValid(zone)) {
      fail(AppErrorCode.validation, 'Unknown time zone "$zone".');
    }
    await session.db.transaction((transaction) async {
      final household = await Household.db.insertRow(
        session,
        Household(name: cleanName, timezone: zone),
        transaction: transaction,
      );
      await HouseholdMember.db.insertRow(
        session,
        HouseholdMember(
          householdId: household.id!,
          userId: user.id!,
          role: MemberRole.owner,
        ),
        transaction: transaction,
      );
    });
    return me(session);
  }

  static Future<Household> update(
    Session session,
    Actor actor, {
    required String name,
    required String timezone,
  }) async {
    if (!TimeZones.isValid(timezone)) {
      fail(AppErrorCode.validation, 'Unknown time zone "$timezone".');
    }
    final saved = await Household.db.updateRow(
      session,
      actor.household.copyWith(
        name: cleanRequired(name, max: 60, field: 'Household name'),
        timezone: timezone,
      ),
    );
    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.householdChanged,
    );
    return saved;
  }

  static Future<List<MemberInfo>> members(Session session, Actor actor) async {
    final members = await Membership.members(session, actor.householdId);
    final users = await Users.byIds(session, members.map((m) => m.userId));
    return [
      for (final m in members)
        if (users[m.userId] != null)
          MemberInfo(
            userId: m.userId,
            displayName: users[m.userId]!.displayName,
            color: users[m.userId]!.color,
            avatarUrl: users[m.userId]!.avatarUrl,
            // Emails are personal data (PDPA): only owners, who manage
            // the household, and the member themself can see them.
            email: actor.isOwner || m.userId == actor.userId
                ? users[m.userId]!.email
                : null,
            role: m.role,
            joinedAt: m.joinedAt,
          ),
    ];
  }

  // ---------------------------------------------------------------------------
  // Invitations (SRS 2.1.4, 2.1.5, 4.1)
  // ---------------------------------------------------------------------------

  static Future<Invitation> createInvite(Session session, Actor actor) async {
    final now = clock.now();
    for (var attempt = 0; attempt < 20; attempt++) {
      final code = _random.nextInt(1000000).toString().padLeft(6, '0');
      final taken = await Invitation.db.count(
        session,
        where: (t) => t.code.equals(code),
      );
      if (taken > 0) continue;
      try {
        return await Invitation.db.insertRow(
          session,
          Invitation(
            code: code,
            householdId: actor.householdId,
            createdById: actor.userId,
            expiresAt: now.add(inviteLifetime),
            createdAt: now,
          ),
        );
      } on DatabaseQueryException {
        continue; // Another request took the same code; draw again.
      }
    }
    throw StateError('Could not generate a unique invite code.');
  }

  static Future<List<Invitation>> activeInvites(
    Session session,
    Actor actor,
  ) => Invitation.db.find(
    session,
    where: (t) =>
        t.householdId.equals(actor.householdId) &
        t.revokedAt.equals(null) &
        (t.expiresAt > clock.now()),
    orderBy: (t) => t.createdAt.desc(),
  );

  static Future<void> revokeInvite(
    Session session,
    Actor actor,
    int invitationId,
  ) async {
    final invite = await Invitation.db.findById(session, invitationId);
    if (invite == null || invite.householdId != actor.householdId) {
      fail(AppErrorCode.notFound, 'Invitation not found.');
    }
    await Invitation.db.updateRow(
      session,
      invite.copyWith(revokedAt: clock.now()),
    );
  }

  static Future<MeInfo> join(Session session, String code) async {
    final user = await Users.current(session);
    final now = clock.now();
    final failures = await InviteAttempt.db.count(
      session,
      where: (t) =>
          t.userId.equals(user.id) &
          t.success.equals(false) &
          (t.attemptedAt > now.subtract(attemptWindow)),
    );
    if (failures >= maxFailedAttempts) {
      fail(
        AppErrorCode.inviteLocked,
        user.locale == 'en'
            ? 'Too many wrong codes. Try again in 15 minutes.'
            : 'กรอกรหัสผิดหลายครั้งเกินไป ลองใหม่อีกครั้งใน 15 นาที',
      );
    }
    if (await Membership.memberOf(session, user.id!) != null) {
      fail(AppErrorCode.alreadyMember, 'You already belong to a household.');
    }

    final clean = code.replaceAll(RegExp(r'\D'), '');
    final invite = clean.length != 6
        ? null
        : await Invitation.db.findFirstRow(
            session,
            where: (t) =>
                t.code.equals(clean) &
                t.revokedAt.equals(null) &
                (t.expiresAt > now),
          );
    if (invite == null) {
      await InviteAttempt.db.insertRow(
        session,
        InviteAttempt(userId: user.id!, success: false, attemptedAt: now),
      );
      final left = maxFailedAttempts - failures - 1;
      fail(
        AppErrorCode.invalidInvite,
        user.locale == 'en'
            ? 'Invalid or expired code. $left attempts left.'
            : 'รหัสไม่ถูกต้องหรือหมดอายุแล้ว เหลืออีก $left ครั้ง',
      );
    }

    final count = await HouseholdMember.db.count(
      session,
      where: (t) => t.householdId.equals(invite.householdId),
    );
    if (count >= Membership.maxMembers) {
      fail(
        AppErrorCode.limitReached,
        'This household already has ${Membership.maxMembers} members.',
      );
    }
    await HouseholdMember.db.insertRow(
      session,
      HouseholdMember(
        householdId: invite.householdId,
        userId: user.id!,
        role: MemberRole.member,
      ),
    );
    await InviteAttempt.db.insertRow(
      session,
      InviteAttempt(userId: user.id!, success: true, attemptedAt: now),
    );
    await Realtime.household(
      session,
      invite.householdId,
      HouseholdEventType.membersChanged,
    );
    return me(session);
  }

  // ---------------------------------------------------------------------------
  // Roles and removal (SRS 2.1.6, 2.1.7)
  // ---------------------------------------------------------------------------

  static Future<MemberInfo> changeRole(
    Session session,
    Actor actor, {
    required int userId,
    required MemberRole role,
  }) async {
    final target = await _memberInHousehold(session, actor, userId);
    if (target.role == role) {
      return (await members(session, actor)).firstWhere(
        (m) => m.userId == userId,
      );
    }
    if (target.role == MemberRole.owner) {
      await _requireAnotherOwner(session, actor.householdId, userId);
    }
    await HouseholdMember.db.updateRow(session, target.copyWith(role: role));
    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.membersChanged,
    );
    if (userId != actor.userId) {
      await Notifier.send(
        session,
        userId: userId,
        type: NotificationType.roleChanged,
        householdId: actor.householdId,
        params: {'role': role.name, 'household': actor.household.name},
      );
    }
    return (await members(session, actor)).firstWhere(
      (m) => m.userId == userId,
    );
  }

  static Future<void> removeMember(
    Session session,
    Actor actor,
    int userId,
  ) async {
    if (userId == actor.userId) {
      fail(
        AppErrorCode.validation,
        'Use "leave household" to remove yourself.',
      );
    }
    final target = await _memberInHousehold(session, actor, userId);
    await session.db.transaction((transaction) async {
      await BookingService.endFutureBookingsOfUser(
        session,
        householdId: actor.householdId,
        userId: userId,
        byUserId: actor.userId,
        transaction: transaction,
      );
      await HouseholdMember.db.deleteRow(
        session,
        target,
        transaction: transaction,
      );
    });
    await _broadcastMembershipChange(session, actor.householdId);
    await Notifier.send(
      session,
      userId: userId,
      type: NotificationType.memberRemoved,
      params: {'household': actor.household.name},
    );
  }

  /// Leaves the household and cancels the member's upcoming bookings. The
  /// household is deleted when its last member leaves.
  static Future<void> leave(Session session, Actor actor) async {
    final others = (await Membership.members(
      session,
      actor.householdId,
    )).where((m) => m.userId != actor.userId).toList();
    if (actor.isOwner &&
        others.isNotEmpty &&
        !others.any((m) => m.role == MemberRole.owner)) {
      fail(
        AppErrorCode.lastOwner,
        actor.user.locale == 'en'
            ? 'Make another member an owner before you leave.'
            : 'ตั้งสมาชิกคนอื่นเป็นผู้ดูแลบ้านก่อนออกจากบ้าน',
      );
    }
    await session.db.transaction((transaction) async {
      await BookingService.endFutureBookingsOfUser(
        session,
        householdId: actor.householdId,
        userId: actor.userId,
        transaction: transaction,
      );
      await HouseholdMember.db.deleteRow(
        session,
        actor.member,
        transaction: transaction,
      );
      if (others.isEmpty) {
        await Household.db.deleteRow(
          session,
          actor.household,
          transaction: transaction,
        );
      }
    });
    if (others.isNotEmpty) {
      await _broadcastMembershipChange(session, actor.householdId);
    }
  }

  /// Deletes the account (PDPA): personal data is erased and past bookings
  /// show "former member".
  static Future<void> deleteAccount(Session session) async {
    final user = await Users.current(session);
    final member = await Membership.memberOf(session, user.id!);
    if (member != null) {
      final household = await Household.db.findById(
        session,
        member.householdId,
      );
      if (household != null) {
        await leave(
          session,
          Actor(user: user, member: member, household: household),
        );
      }
    }
    final authUserId = user.authUserId;
    await session.db.transaction((transaction) async {
      await DeviceToken.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(user.id),
        transaction: transaction,
      );
      await AppNotification.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(user.id),
        transaction: transaction,
      );
      await InviteAttempt.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(user.id),
        transaction: transaction,
      );
      await AppUser.db.updateRow(
        session,
        user.copyWith(
          authUserId: null,
          email: null,
          displayName: 'อดีตสมาชิก',
          avatarUrl: null,
          color: formerMemberColor,
          deletedAt: clock.now(),
        ),
        transaction: transaction,
      );
      if (authUserId != null) {
        await AuthServices.instance.authUsers.delete(
          session,
          authUserId: authUserId,
          transaction: transaction,
        );
      }
    });
    if (authUserId != null) {
      await session.messages.authenticationRevoked(
        authUserId.uuid,
        RevokedAuthenticationUser(),
      );
    }
  }

  static Future<HouseholdMember> _memberInHousehold(
    Session session,
    Actor actor,
    int userId,
  ) async {
    final target = await Membership.memberOf(session, userId);
    if (target == null || target.householdId != actor.householdId) {
      fail(AppErrorCode.notFound, 'Member not found.');
    }
    return target;
  }

  static Future<void> _requireAnotherOwner(
    Session session,
    int householdId,
    int exceptUserId,
  ) async {
    final owners = await Membership.ownerIds(session, householdId);
    if (!owners.any((id) => id != exceptUserId)) {
      fail(
        AppErrorCode.lastOwner,
        'A household needs at least one owner.',
      );
    }
  }

  static Future<void> _broadcastMembershipChange(
    Session session,
    int householdId,
  ) async {
    await Realtime.household(
      session,
      householdId,
      HouseholdEventType.membersChanged,
    );
    await Realtime.household(
      session,
      householdId,
      HouseholdEventType.bookingsChanged,
    );
  }
}
