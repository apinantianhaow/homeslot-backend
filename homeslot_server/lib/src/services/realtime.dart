import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/clock.dart';

/// Channels used to push changes to connected apps (SRS 2.3.8).
abstract final class Realtime {
  static String householdChannel(int householdId) => 'household:$householdId';
  static String userChannel(int userId) => 'user:$userId';

  static Future<void> household(
    Session session,
    int householdId,
    HouseholdEventType type, {
    int? roomId,
    int? bookingId,
  }) async {
    await session.messages.postMessage(
      householdChannel(householdId),
      HouseholdEvent(
        type: type,
        roomId: roomId,
        bookingId: bookingId,
        at: clock.now(),
      ),
    );
  }

  static Future<void> user(
    Session session,
    int userId,
    HouseholdEventType type, {
    int? bookingId,
  }) async {
    await session.messages.postMessage(
      userChannel(userId),
      HouseholdEvent(type: type, bookingId: bookingId, at: clock.now()),
    );
  }
}
