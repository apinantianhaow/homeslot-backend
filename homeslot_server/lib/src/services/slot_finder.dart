import '../generated/protocol.dart';
import '../util/time_zones.dart';
import 'booking_rules.dart';

/// Finds the free slots closest to a requested time (SRS 2.3.3, 4.7).
abstract final class SlotFinder {
  static const maxSearchDays = 60;

  /// Returns up to [count] valid slots of the same length as the request,
  /// ordered by distance from [desiredStart]. [busy] holds the ranges that
  /// are already taken in the room.
  static List<TimeSlot> suggest({
    required RuleContext ctx,
    required DateTime desiredStart,
    required int durationMinutes,
    required List<({DateTime start, DateTime end})> busy,
    int count = 3,
  }) {
    final room = ctx.room;
    final minutes = durationMinutes
        .clamp(room.minMinutes, room.maxMinutes)
        .toInt();
    final step = Duration(minutes: room.slotMinutes);
    final anchor = BookingRules.floorToSlot(
      TimeZones.local(desiredStart, ctx.location),
      room.slotMinutes,
    );
    // Search at most [maxSearchDays] ahead so the search stays fast even for
    // rooms bookable a year in advance with 5-minute steps.
    final searchDays = room.advanceDays < maxSearchDays
        ? room.advanceDays
        : maxSearchDays;
    final horizon = TimeZones.addDays(
      TimeZones.startOfDay(TimeZones.local(ctx.now, ctx.location)),
      searchDays + 1,
    );
    final maxSteps = (searchDays + 2) * 1440 ~/ room.slotMinutes;

    final found = <TimeSlot>[];
    bool tryCandidate(DateTime start) {
      final end = start.add(Duration(minutes: minutes));
      if (BookingRules.check(ctx, start, end) != null) return false;
      for (final b in busy) {
        if (BookingRules.overlaps(start, end, b.start, b.end)) return false;
      }
      found.add(TimeSlot(startAt: start.toUtc(), endAt: end.toUtc()));
      return true;
    }

    var forwardDone = false;
    var backwardDone = false;
    for (var k = 0; k <= maxSteps && found.length < count; k++) {
      if (!forwardDone) {
        final start = anchor.add(step * k);
        if (!start.isBefore(horizon)) {
          forwardDone = true;
        } else {
          tryCandidate(start);
        }
      }
      if (k > 0 && !backwardDone && found.length < count) {
        final start = anchor.subtract(step * k);
        if (start.add(Duration(minutes: minutes)).isBefore(ctx.now)) {
          backwardDone = true;
        } else {
          tryCandidate(start);
        }
      }
      if (forwardDone && backwardDone) break;
    }
    // Nearest first; on a tie prefer the later slot ("next free slot").
    found.sort((a, b) {
      final byDistance = a.startAt
          .difference(desiredStart)
          .abs()
          .compareTo(b.startAt.difference(desiredStart).abs());
      return byDistance != 0 ? byDistance : b.startAt.compareTo(a.startAt);
    });
    return found;
  }
}
