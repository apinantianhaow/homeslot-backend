import 'package:serverpod/serverpod.dart';
import 'package:timezone/timezone.dart' as tz;

import '../generated/protocol.dart';
import '../util/clock.dart';
import '../util/time_zones.dart';
import 'booking_rules.dart';
import 'membership.dart';
import 'users.dart';

/// Usage statistics for owners (SRS 2.6).
abstract final class StatsService {
  static const _counted = {BookingStatus.confirmed, BookingStatus.completed};

  static Future<UsageStats> usage(
    Session session,
    Actor actor, {
    required StatsPeriod period,
    required DateTime anchor,
  }) async {
    final location = actor.location;
    final local = TimeZones.local(anchor, location);
    final from = period == StatsPeriod.week
        ? TimeZones.startOfWeek(local)
        : TimeZones.startOfMonth(local);
    final to = period == StatsPeriod.week
        ? TimeZones.addDays(from, 7)
        : tz.TZDateTime(location, from.year, from.month + 1);

    final rooms = await Room.db.find(
      session,
      where: (t) => t.householdId.equals(actor.householdId),
      orderByList: (t) => [t.sortOrder, t.name],
    );
    final members = await Membership.members(session, actor.householdId);
    final bookings = await _bookings(session, actor, from, to);
    final users = await Users.byIds(session, {
      ...members.map((m) => m.userId),
      ...bookings.map((b) => b.userId),
    });

    final roomMinutes = <int, int>{};
    final roomCount = <int, int>{};
    final userMinutes = <int, int>{};
    final userCount = <int, int>{};
    final days = <tz.TZDateTime>[];
    for (var d = from; d.isBefore(to); d = TimeZones.addDays(d, 1)) {
      days.add(d);
    }
    final dayMinutes = List<int>.filled(days.length, 0);
    var total = 0;

    for (final b in bookings) {
      final minutes = BookingRules.overlapMinutes(b.startAt, b.endAt, from, to);
      if (minutes == 0) continue;
      total += minutes;
      roomMinutes.update(b.roomId, (v) => v + minutes, ifAbsent: () => minutes);
      roomCount.update(b.roomId, (v) => v + 1, ifAbsent: () => 1);
      userMinutes.update(b.userId, (v) => v + minutes, ifAbsent: () => minutes);
      userCount.update(b.userId, (v) => v + 1, ifAbsent: () => 1);
      for (var i = 0; i < days.length; i++) {
        final dayEnd = i + 1 < days.length ? days[i + 1] : to;
        dayMinutes[i] += BookingRules.overlapMinutes(
          b.startAt,
          b.endAt,
          days[i],
          dayEnd,
        );
      }
    }

    final memberIds = {
      ...members.map((m) => m.userId),
      ...userMinutes.keys,
    };
    final byMember = [
      for (final id in memberIds)
        UsageEntry(
          id: id,
          label: users[id] == null || users[id]!.deletedAt != null
              ? actor.messages.formerMember
              : users[id]!.displayName,
          color: users[id]?.color,
          minutes: userMinutes[id] ?? 0,
          bookings: userCount[id] ?? 0,
        ),
    ]..sort((a, b) => b.minutes.compareTo(a.minutes));

    return UsageStats(
      period: period,
      from: TimeZones.utc(from),
      to: TimeZones.utc(to),
      totalMinutes: total,
      byRoom: [
        for (final r in rooms)
          UsageEntry(
            id: r.id!,
            label: r.name,
            minutes: roomMinutes[r.id] ?? 0,
            bookings: roomCount[r.id] ?? 0,
          ),
      ],
      byMember: byMember,
      byDay: [
        for (var i = 0; i < days.length; i++)
          DailyUsage(date: TimeZones.utc(days[i]), minutes: dayMinutes[i]),
      ],
    );
  }

  /// Booked minutes per local hour of day and per weekday x hour over the
  /// last [days] days (SRS 2.6.3).
  static Future<PeakHours> peakHours(
    Session session,
    Actor actor, {
    int? roomId,
    int days = 30,
  }) async {
    final location = actor.location;
    final now = TimeZones.local(clock.now(), location);
    final to = TimeZones.addDays(TimeZones.startOfDay(now), 1);
    final from = TimeZones.addDays(to, -days.clamp(1, 366));
    var bookings = await _bookings(session, actor, from, to);
    if (roomId != null) {
      bookings = bookings.where((b) => b.roomId == roomId).toList();
    }

    final hourly = List<int>.filled(24, 0);
    final heatmap = List<int>.filled(7 * 24, 0);
    for (final b in bookings) {
      var cursor = TimeZones.local(
        b.startAt.isBefore(from) ? from : b.startAt,
        location,
      );
      final end = b.endAt.isAfter(to) ? to : b.endAt;
      while (cursor.isBefore(end)) {
        // Truncate to the local hour by subtracting minutes, so the slice
        // always moves forward, even when clocks fall back.
        final hourStart = cursor.subtract(
          Duration(
            minutes: cursor.minute,
            seconds: cursor.second,
            milliseconds: cursor.millisecond,
            microseconds: cursor.microsecond,
          ),
        );
        final hourEnd = hourStart.add(const Duration(hours: 1));
        final sliceEnd = hourEnd.isBefore(end) ? hourEnd : end;
        final minutes = sliceEnd.difference(cursor).inMinutes;
        hourly[cursor.hour] += minutes;
        heatmap[(cursor.weekday - 1) * 24 + cursor.hour] += minutes;
        cursor = TimeZones.local(sliceEnd, location);
      }
    }
    return PeakHours(
      roomId: roomId,
      from: TimeZones.utc(from),
      to: TimeZones.utc(to),
      hourly: hourly,
      heatmap: heatmap,
    );
  }

  static Future<List<Booking>> _bookings(
    Session session,
    Actor actor,
    DateTime from,
    DateTime to,
  ) => Booking.db.find(
    session,
    where: (t) =>
        t.householdId.equals(actor.householdId) &
        t.status.inSet(_counted) &
        (t.startAt < TimeZones.utc(to)) &
        (t.endAt > TimeZones.utc(from)),
  );
}
