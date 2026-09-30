import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/clock.dart';
import '../util/messages.dart';
import '../util/time_zones.dart';
import 'push_sender.dart';
import 'realtime.dart';

/// Stores in-app notifications, pushes them to devices and tells the app to
/// refresh its notification list (SRS 2.5).
abstract final class Notifier {
  static Future<void> send(
    Session session, {
    required int userId,
    required NotificationType type,
    int? householdId,
    int? bookingId,
    Map<String, String> params = const {},

    /// The recipient's row when the caller already loaded it.
    AppUser? user,
  }) async {
    final recipient = user ?? await AppUser.db.findById(session, userId);
    if (recipient == null || recipient.deletedAt != null) return;
    final text = Messages.of(recipient.locale).notification(type, params);
    await AppNotification.db.insertRow(
      session,
      AppNotification(
        userId: userId,
        householdId: householdId,
        type: type,
        title: text.title,
        body: text.body,
        bookingId: bookingId,
        createdAt: clock.now(),
      ),
    );
    await Realtime.user(
      session,
      userId,
      HouseholdEventType.notification,
      bookingId: bookingId,
    );
    await PushSender.instance.send(
      session,
      userId: userId,
      title: text.title,
      body: text.body,
      data: {
        'type': type.name,
        if (bookingId != null) 'bookingId': '$bookingId',
      },
    );
  }

  /// Sends a booking-related notification with the room name and time range
  /// formatted in the recipient's language and the household time zone.
  static Future<void> aboutBooking(
    Session session, {
    required int userId,
    required NotificationType type,
    required Booking booking,
    required Room room,
    required Household household,
    Map<String, String> extra = const {},

    /// The recipient's row when the caller already loaded it.
    AppUser? user,
  }) async {
    final recipient = user ?? await AppUser.db.findById(session, userId);
    if (recipient == null) return;
    final messages = Messages.of(recipient.locale);
    await send(
      session,
      userId: userId,
      type: type,
      householdId: household.id,
      bookingId: booking.id,
      user: recipient,
      params: {
        'room': room.name,
        'time': messages.range(
          booking.startAt,
          booking.endAt,
          TimeZones.location(household.timezone),
        ),
        ...extra,
      },
    );
  }
}
