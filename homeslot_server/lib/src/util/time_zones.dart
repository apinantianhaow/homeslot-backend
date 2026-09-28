import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Helpers for working in the household time zone (SRS 4.3).
///
/// All timestamps are stored in UTC. Rules such as opening hours, slot
/// alignment and weekly quotas are evaluated in the household's local time.
abstract final class TimeZones {
  static const defaultZone = 'Asia/Bangkok';
  static bool _initialized = false;

  static void init() {
    if (_initialized) return;
    tzdata.initializeTimeZones();
    _initialized = true;
  }

  static bool isValid(String name) {
    init();
    return tz.timeZoneDatabase.locations.containsKey(name);
  }

  static tz.Location location(String name) {
    init();
    return tz.timeZoneDatabase.locations[name] ?? tz.getLocation(defaultZone);
  }

  static tz.TZDateTime local(DateTime instant, tz.Location location) =>
      tz.TZDateTime.from(instant, location);

  static tz.TZDateTime startOfDay(tz.TZDateTime t) =>
      tz.TZDateTime(t.location, t.year, t.month, t.day);

  static tz.TZDateTime addDays(tz.TZDateTime day, int days) =>
      tz.TZDateTime(day.location, day.year, day.month, day.day + days);

  /// Monday 00:00 of the week containing [t].
  static tz.TZDateTime startOfWeek(tz.TZDateTime t) =>
      tz.TZDateTime(t.location, t.year, t.month, t.day - (t.weekday - 1));

  static tz.TZDateTime startOfMonth(tz.TZDateTime t) =>
      tz.TZDateTime(t.location, t.year, t.month);

  /// Minutes since local midnight of the day [t] belongs to.
  static int minuteOfDay(tz.TZDateTime t) =>
      t.difference(startOfDay(t)).inMinutes;

  /// Converts any [DateTime] (including `TZDateTime`) to a plain UTC
  /// [DateTime], as expected by the database layer and serialization.
  static DateTime utc(DateTime t) => DateTime.fromMicrosecondsSinceEpoch(
    t.microsecondsSinceEpoch,
    isUtc: true,
  );

  /// Wall-clock time [minute] minutes after midnight on the day of [day].
  static tz.TZDateTime atMinute(tz.TZDateTime day, int minute) =>
      tz.TZDateTime(day.location, day.year, day.month, day.day, 0, minute);
}
