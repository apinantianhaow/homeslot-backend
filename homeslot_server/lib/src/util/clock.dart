/// Source of the current time. Tests replace [clock] to control "now".
class Clock {
  const Clock();

  DateTime now() => DateTime.now().toUtc();
}

/// The clock used by all services. Tests may swap it for a fixed clock.
Clock clock = const Clock();

/// A clock that always returns [fixed], for tests.
class FixedClock extends Clock {
  FixedClock(this.fixed);

  DateTime fixed;

  @override
  DateTime now() => fixed.toUtc();
}
