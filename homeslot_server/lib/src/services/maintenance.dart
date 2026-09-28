import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/clock.dart';
import 'notifier.dart';
import 'realtime.dart';

/// Housekeeping that runs every minute from a Serverpod future call.
///
/// * Pending requests not decided before they start become `expired` and
///   free their slot (SRS 2.4.3).
/// * Confirmed bookings that have ended become `completed`.
/// * Reminders are sent before a booking starts (SRS 2.5.1).
/// * Notifications older than 30 days are removed (SRS 2.5.4).
abstract final class Maintenance {
  static const maxReminderMinutes = 60;
  static const notificationRetention = Duration(days: 30);

  static Future<MaintenanceResult> run(Session session) async {
    final now = clock.now();
    final expired = await _expirePending(session, now);
    final completed = await _completeEnded(session, now);
    final reminded = await _sendReminders(session, now);
    await _purge(session, now);
    return MaintenanceResult(
      expired: expired,
      completed: completed,
      reminded: reminded,
    );
  }

  static Future<int> _expirePending(Session session, DateTime now) async {
    final rows = await Booking.db.find(
      session,
      where: (t) => t.status.equals(BookingStatus.pending) & (t.startAt <= now),
    );
    if (rows.isEmpty) return 0;
    final saved = await Booking.db.update(session, [
      for (final b in rows)
        b.copyWith(status: BookingStatus.expired, updatedAt: now),
    ]);
    final rooms = {
      for (final r in await Room.db.find(
        session,
        where: (t) => t.id.inSet(saved.map((b) => b.roomId).toSet()),
      ))
        r.id!: r,
    };
    final households = {
      for (final h in await Household.db.find(
        session,
        where: (t) => t.id.inSet(saved.map((b) => b.householdId).toSet()),
      ))
        h.id!: h,
    };
    for (final b in saved) {
      final room = rooms[b.roomId];
      final household = households[b.householdId];
      if (room == null || household == null) continue;
      await Notifier.aboutBooking(
        session,
        userId: b.userId,
        type: NotificationType.bookingExpired,
        booking: b,
        room: room,
        household: household,
      );
    }
    for (final householdId in households.keys) {
      await Realtime.household(
        session,
        householdId,
        HouseholdEventType.bookingsChanged,
      );
    }
    return saved.length;
  }

  static Future<int> _completeEnded(Session session, DateTime now) async {
    final rows = await Booking.db.updateWhere(
      session,
      columnValues: (t) => [
        t.status(BookingStatus.completed),
        t.updatedAt(now),
      ],
      where: (t) => t.status.equals(BookingStatus.confirmed) & (t.endAt <= now),
    );
    for (final householdId in rows.map((b) => b.householdId).toSet()) {
      await Realtime.household(
        session,
        householdId,
        HouseholdEventType.bookingsChanged,
      );
    }
    return rows.length;
  }

  static Future<int> _sendReminders(Session session, DateTime now) async {
    final candidates = await Booking.db.find(
      session,
      where: (t) =>
          t.status.equals(BookingStatus.confirmed) &
          t.reminderSentAt.equals(null) &
          (t.startAt > now) &
          (t.startAt <= now.add(const Duration(minutes: maxReminderMinutes))),
    );
    if (candidates.isEmpty) return 0;
    final users = {
      for (final u in await AppUser.db.find(
        session,
        where: (t) => t.id.inSet(candidates.map((b) => b.userId).toSet()),
      ))
        u.id!: u,
    };
    var sent = 0;
    for (final b in candidates) {
      final user = users[b.userId];
      if (user == null || !user.reminderEnabled || user.deletedAt != null) {
        continue;
      }
      final minutesLeft = b.startAt.difference(now).inMinutes;
      if (minutesLeft > user.reminderMinutes) continue;
      final room = await Room.db.findById(session, b.roomId);
      final household = await Household.db.findById(session, b.householdId);
      if (room == null || household == null) continue;
      await Booking.db.updateRow(session, b.copyWith(reminderSentAt: now));
      await Notifier.aboutBooking(
        session,
        userId: b.userId,
        type: NotificationType.bookingReminder,
        booking: b,
        room: room,
        household: household,
        extra: {'minutes': '${minutesLeft < 1 ? 1 : minutesLeft}'},
      );
      sent++;
    }
    return sent;
  }

  static Future<void> _purge(Session session, DateTime now) async {
    await AppNotification.db.deleteWhere(
      session,
      where: (t) => t.createdAt < now.subtract(notificationRetention),
    );
    await InviteAttempt.db.deleteWhere(
      session,
      where: (t) => t.attemptedAt < now.subtract(const Duration(days: 1)),
    );
    await Invitation.db.deleteWhere(
      session,
      where: (t) => t.expiresAt < now.subtract(const Duration(days: 7)),
    );
  }
}

/// Counts of what one maintenance run changed (used by tests and logs).
class MaintenanceResult {
  const MaintenanceResult({
    required this.expired,
    required this.completed,
    required this.reminded,
  });

  final int expired;
  final int completed;
  final int reminded;
}
