import 'package:timezone/timezone.dart' as tz;

import '../generated/protocol.dart';
import '../util/time_zones.dart';

/// A rule violation found while validating a booking.
class RuleViolation {
  const RuleViolation(this.code, [this.detail]);

  final BookingErrorCode code;

  /// Extra context for the message, e.g. the closure reason.
  final String? detail;

  @override
  String toString() =>
      'RuleViolation($code${detail == null ? '' : ', $detail'})';
}

/// Everything the rules need to know about a room at validation time.
class RuleContext {
  RuleContext({
    required this.room,
    required this.hours,
    required this.closures,
    required this.location,
    required this.now,
  });

  final Room room;
  final List<RoomHours> hours;
  final List<RoomClosure> closures;
  final tz.Location location;
  final DateTime now;

  late final Map<int, RoomHours> _hoursByWeekday = {
    for (final h in hours) h.weekday: h,
  };
}

/// The per-room booking rules from SRS 2.3 ("กฎการจองที่ตั้งได้ต่อห้อง").
///
/// Pure functions without database access so every rule is unit tested.
/// Overlap and quota need other bookings and are checked by the caller
/// ([overlaps], [checkQuota]); the database exclusion constraint is the
/// final guard against overlaps.
abstract final class BookingRules {
  /// Checks the time rules for a booking from [start] to [end].
  ///
  /// When [enforceAdvanceLimit] is false the "book at most N days ahead" rule
  /// is skipped. It is used for later occurrences of a recurring series,
  /// which may extend to 12 weeks (SRS 2.3.5).
  static RuleViolation? check(
    RuleContext ctx,
    DateTime start,
    DateTime end, {
    bool enforceAdvanceLimit = true,
  }) {
    final room = ctx.room;
    if (!end.isAfter(start)) {
      return const RuleViolation(BookingErrorCode.invalidRange);
    }

    final localStart = TimeZones.local(start, ctx.location);
    final localEnd = TimeZones.local(end, ctx.location);
    if (!_isAligned(localStart, room.slotMinutes) ||
        !_isAligned(localEnd, room.slotMinutes)) {
      return const RuleViolation(BookingErrorCode.notAligned);
    }

    final minutes = end.difference(start).inMinutes;
    if (minutes < room.minMinutes) {
      return const RuleViolation(BookingErrorCode.tooShort);
    }
    if (minutes > room.maxMinutes) {
      return const RuleViolation(BookingErrorCode.tooLong);
    }

    // No booking in the past (SRS 4.1). Starting in the current slot is
    // allowed so a member can book a free room "right now".
    final nowLocal = TimeZones.local(ctx.now, ctx.location);
    final currentSlotStart = floorToSlot(nowLocal, room.slotMinutes);
    if (start.isBefore(currentSlotStart) || !end.isAfter(ctx.now)) {
      return const RuleViolation(BookingErrorCode.inPast);
    }

    if (enforceAdvanceLimit) {
      final lastDay = TimeZones.addDays(
        TimeZones.startOfDay(nowLocal),
        room.advanceDays + 1,
      );
      if (!start.isBefore(lastDay)) {
        return const RuleViolation(BookingErrorCode.tooFarAhead);
      }
    }

    if (!isWithinHours(ctx, start, end)) {
      return const RuleViolation(BookingErrorCode.outsideHours);
    }

    for (final closure in ctx.closures) {
      if (closure.roomId == room.id &&
          overlaps(start, end, closure.startAt, closure.endAt)) {
        return RuleViolation(BookingErrorCode.roomClosed, closure.reason);
      }
    }
    return null;
  }

  /// Whether every part of [start, end) lies within the opening hours of the
  /// weekday it falls on. Multi-day bookings (e.g. a guest room overnight)
  /// are checked day by day.
  static bool isWithinHours(RuleContext ctx, DateTime start, DateTime end) {
    var day = TimeZones.startOfDay(TimeZones.local(start, ctx.location));
    while (day.isBefore(end)) {
      final nextDay = TimeZones.addDays(day, 1);
      final segStart = start.isAfter(day) ? start : day;
      final segEnd = end.isBefore(nextDay) ? end : nextDay;
      if (segEnd.isAfter(segStart)) {
        final hours = ctx._hoursByWeekday[day.weekday];
        if (hours == null) return false;
        final fromMinute = segStart.difference(day).inMinutes;
        final dayLength = nextDay.difference(day).inMinutes;
        var toMinute = segEnd.difference(day).inMinutes;
        // Treat the end of a 23h/25h DST day as 24:00.
        if (toMinute == dayLength) toMinute = 1440;
        if (fromMinute < hours.openMinute || toMinute > hours.closeMinute) {
          return false;
        }
      }
      day = nextDay;
    }
    return true;
  }

  /// Weekly quota check (SRS 2.3 "โควตาต่อสมาชิก").
  ///
  /// [usedMinutesInWeek] returns the minutes the member already booked in
  /// this room during the local week starting at the given Monday.
  static RuleViolation? checkQuota(
    RuleContext ctx,
    DateTime start,
    DateTime end,
    int Function(tz.TZDateTime weekStart) usedMinutesInWeek,
  ) {
    final quota = ctx.room.weeklyQuotaMinutes;
    if (quota == null) return null;
    for (final week in splitByWeek(start, end, ctx.location)) {
      final used = usedMinutesInWeek(week.weekStart);
      if (used + week.minutes > quota) {
        return RuleViolation(BookingErrorCode.quotaExceeded, '$used');
      }
    }
    return null;
  }

  /// Splits [start, end) into the local weeks it touches.
  static List<({tz.TZDateTime weekStart, int minutes})> splitByWeek(
    DateTime start,
    DateTime end,
    tz.Location location,
  ) {
    final result = <({tz.TZDateTime weekStart, int minutes})>[];
    var weekStart = TimeZones.startOfWeek(TimeZones.local(start, location));
    while (weekStart.isBefore(end)) {
      final weekEnd = TimeZones.addDays(weekStart, 7);
      final minutes = overlapMinutes(start, end, weekStart, weekEnd);
      if (minutes > 0) {
        result.add((weekStart: weekStart, minutes: minutes));
      }
      weekStart = weekEnd;
    }
    return result;
  }

  static bool overlaps(
    DateTime aStart,
    DateTime aEnd,
    DateTime bStart,
    DateTime bEnd,
  ) => aStart.isBefore(bEnd) && bStart.isBefore(aEnd);

  static int overlapMinutes(
    DateTime aStart,
    DateTime aEnd,
    DateTime bStart,
    DateTime bEnd,
  ) {
    final s = aStart.isAfter(bStart) ? aStart : bStart;
    final e = aEnd.isBefore(bEnd) ? aEnd : bEnd;
    return e.isAfter(s) ? e.difference(s).inMinutes : 0;
  }

  static tz.TZDateTime floorToSlot(tz.TZDateTime t, int slotMinutes) {
    final minute = TimeZones.minuteOfDay(t);
    return TimeZones.atMinute(t, minute - minute % slotMinutes);
  }

  static bool _isAligned(tz.TZDateTime t, int slotMinutes) =>
      t.second == 0 &&
      t.millisecond == 0 &&
      t.microsecond == 0 &&
      TimeZones.minuteOfDay(t) % slotMinutes == 0;

  /// Validates a room's own settings before it is saved.
  static String? validateRoomSettings(Room room, List<RoomHours> hours) {
    const allowedSlots = {5, 10, 15, 20, 30, 60};
    if (!allowedSlots.contains(room.slotMinutes)) {
      return 'Slot size must be one of $allowedSlots minutes.';
    }
    if (room.minMinutes < room.slotMinutes ||
        room.minMinutes % room.slotMinutes != 0) {
      return 'Minimum length must be a multiple of the slot size.';
    }
    if (room.maxMinutes < room.minMinutes ||
        room.maxMinutes % room.slotMinutes != 0 ||
        room.maxMinutes > 14 * 1440) {
      return 'Maximum length must be between the minimum and 14 days, '
          'in slot steps.';
    }
    if (room.advanceDays < 1 || room.advanceDays > 365) {
      return 'Advance booking must be between 1 and 365 days.';
    }
    final quota = room.weeklyQuotaMinutes;
    if (quota != null && (quota < room.minMinutes || quota > 7 * 1440)) {
      return 'Weekly quota must be at least the minimum booking length.';
    }
    if (room.capacity < 1 || room.capacity > 100) {
      return 'Capacity must be between 1 and 100.';
    }
    final seen = <int>{};
    for (final h in hours) {
      if (h.weekday < 1 || h.weekday > 7 || !seen.add(h.weekday)) {
        return 'Each weekday may appear once (1 = Monday ... 7 = Sunday).';
      }
      if (h.openMinute < 0 ||
          h.closeMinute > 1440 ||
          h.openMinute >= h.closeMinute) {
        return 'Opening time must be before closing time.';
      }
      if (h.openMinute % room.slotMinutes != 0 ||
          h.closeMinute % room.slotMinutes != 0) {
        return 'Opening hours must align to the slot size.';
      }
    }
    return null;
  }
}
