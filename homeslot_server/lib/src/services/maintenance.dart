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
    // One statement, so a request approved or cancelled at the same moment
    // is never overwritten with an older copy of the row.
    final saved = await Booking.db.updateWhere(
      session,
      columnValues: (t) => [
        t.status(BookingStatus.expired),
        t.updatedAt(now),
      ],
      where: (t) => t.status.equals(BookingStatus.pending) & (t.startAt <= now),
    );
    if (saved.isEmpty) return 0;
    // Refresh the apps first: the slots are already free, whatever happens
    // while notifying.
    for (final householdId in saved.map((b) => b.householdId).toSet()) {
      await Realtime.household(
        session,
        householdId,
        HouseholdEventType.bookingsChanged,
      );
    }
    final rooms = await _roomsById(session, saved);
    final households = await _householdsById(session, saved);
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
    final due = [
      for (final b in candidates)
        if (users[b.userId] case final user?
            when user.reminderEnabled &&
                user.deletedAt == null &&
                b.startAt.difference(now).inMinutes <= user.reminderMinutes)
          b,
    ];
    if (due.isEmpty) return 0;
    final rooms = await _roomsById(session, due);
    final households = await _householdsById(session, due);
    var sent = 0;
    for (final b in due) {
      final room = rooms[b.roomId];
      final household = households[b.householdId];
      if (room == null || household == null) continue;
      // Set only this column, and only while the booking is still the one
      // that was read, so a cancel or edit made meanwhile is kept.
      final marked = await Booking.db.updateWhere(
        session,
        columnValues: (t) => [t.reminderSentAt(now)],
        where: (t) =>
            t.id.equals(b.id) &
            t.status.equals(BookingStatus.confirmed) &
            t.reminderSentAt.equals(null) &
            t.startAt.equals(b.startAt),
      );
      if (marked.isEmpty) continue;
      final minutesLeft = b.startAt.difference(now).inMinutes;
      await Notifier.aboutBooking(
        session,
        userId: b.userId,
        type: NotificationType.bookingReminder,
        booking: marked.single,
        room: room,
        household: household,
        user: users[b.userId],
        extra: {'minutes': '${minutesLeft < 1 ? 1 : minutesLeft}'},
      );
      sent++;
    }
    return sent;
  }

  static Future<Map<int, Room>> _roomsById(
    Session session,
    List<Booking> bookings,
  ) async => {
    for (final r in await Room.db.find(
      session,
      where: (t) => t.id.inSet(bookings.map((b) => b.roomId).toSet()),
    ))
      r.id!: r,
  };

  static Future<Map<int, Household>> _householdsById(
    Session session,
    List<Booking> bookings,
  ) async => {
    for (final h in await Household.db.find(
      session,
      where: (t) => t.id.inSet(bookings.map((b) => b.householdId).toSet()),
    ))
      h.id!: h,
  };

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
