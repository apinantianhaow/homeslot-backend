import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/household_service.dart';
import '../services/realtime.dart';
import '../services/users.dart';
import '../util/clock.dart';
import '../util/errors.dart';

/// The signed-in user's own profile, settings and devices (SRS 2.1.8, 2.5.1).
class AccountEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<MeInfo> me(Session session) => HouseholdService.me(session);

  Future<AppUser> updateProfile(
    Session session,
    String displayName,
    String color,
    String? avatarUrl,
  ) async {
    final user = await Users.current(session);
    if (!isHexColor(color)) {
      fail(AppErrorCode.validation, 'Color must be #RRGGBB.');
    }
    final saved = await AppUser.db.updateRow(
      session,
      user.copyWith(
        displayName: cleanRequired(displayName, max: 40, field: 'Name'),
        color: color.toUpperCase(),
        avatarUrl: cleanUrl(avatarUrl, field: 'Avatar'),
      ),
    );
    await _broadcast(session, saved.id!);
    return saved;
  }

  Future<AppUser> updateSettings(
    Session session,
    bool reminderEnabled,
    int reminderMinutes,
    String locale,
  ) async {
    if (reminderMinutes < 5 || reminderMinutes > 60) {
      fail(AppErrorCode.validation, 'Reminder must be 5-60 minutes.');
    }
    if (locale != 'th' && locale != 'en') {
      fail(AppErrorCode.validation, 'Locale must be th or en.');
    }
    final user = await Users.current(session);
    return AppUser.db.updateRow(
      session,
      user.copyWith(
        reminderEnabled: reminderEnabled,
        reminderMinutes: reminderMinutes,
        locale: locale,
      ),
    );
  }

  /// Registers this device's FCM token for push notifications.
  Future<void> registerDevice(
    Session session,
    String token,
    String platform,
  ) async {
    final user = await Users.current(session);
    final clean = cleanRequired(token, max: 4096, field: 'Token');
    final existing = await DeviceToken.db.findFirstRow(
      session,
      where: (t) => t.token.equals(clean),
    );
    if (existing != null) {
      await DeviceToken.db.updateRow(
        session,
        existing.copyWith(
          userId: user.id!,
          platform: platform,
          updatedAt: clock.now(),
        ),
      );
    } else {
      await DeviceToken.db.insertRow(
        session,
        DeviceToken(userId: user.id!, token: clean, platform: platform),
      );
    }
  }

  Future<void> unregisterDevice(Session session, String token) async {
    final user = await Users.current(session);
    await DeviceToken.db.deleteWhere(
      session,
      where: (t) => t.token.equals(token) & t.userId.equals(user.id),
    );
  }

  /// Deletes the account and its personal data (PDPA).
  Future<void> deleteAccount(Session session) =>
      HouseholdService.deleteAccount(session);

  Future<void> _broadcast(Session session, int userId) async {
    final member = await HouseholdMember.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
    if (member == null) return;
    await Realtime.household(
      session,
      member.householdId,
      HouseholdEventType.membersChanged,
    );
    await Realtime.household(
      session,
      member.householdId,
      HouseholdEventType.bookingsChanged,
    );
  }
}
