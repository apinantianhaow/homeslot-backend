import 'package:homeslot_server/src/generated/protocol.dart';
import 'package:homeslot_server/src/services/booking_rules.dart';
import 'package:homeslot_server/src/services/booking_service.dart';
import 'package:homeslot_server/src/services/slot_finder.dart';
import 'package:homeslot_server/src/util/time_zones.dart';
import 'package:test/test.dart';
import 'package:timezone/timezone.dart' as tz;

/// Unit tests for every booking rule in SRS 2.3 (required by SRS 4.6).
void main() {
  TimeZones.init();
  final bangkok = TimeZones.location('Asia/Bangkok');

  /// Bangkok wall-clock time as UTC.
  DateTime bkk(int y, int m, int d, [int h = 0, int min = 0]) =>
      TimeZones.utc(tz.TZDateTime(bangkok, y, m, d, h, min));

  // Monday 5 Jan 2032, 08:05 in Bangkok.
  final now = bkk(2032, 1, 5, 8, 5);

  Room room({
    int slot = 15,
    int min = 30,
    int max = 240,
    int advance = 30,
    int? quota,
  }) => Room(
    id: 1,
    householdId: 1,
    name: 'Office',
    type: RoomType.office,
    slotMinutes: slot,
    minMinutes: min,
    maxMinutes: max,
    advanceDays: advance,
    weeklyQuotaMinutes: quota,
  );

  List<RoomHours> hours({int open = 0, int close = 1440, Set<int>? days}) => [
    for (final d in days ?? {1, 2, 3, 4, 5, 6, 7})
      RoomHours(roomId: 1, weekday: d, openMinute: open, closeMinute: close),
  ];

  RuleContext ctx({
    Room? r,
    List<RoomHours>? h,
    List<RoomClosure> closures = const [],
    DateTime? at,
    tz.Location? location,
  }) => RuleContext(
    room: r ?? room(),
    hours: h ?? hours(),
    closures: closures,
    location: location ?? bangkok,
    now: at ?? now,
  );

  BookingErrorCode? check(RuleContext c, DateTime s, DateTime e) =>
      BookingRules.check(c, s, e)?.code;

  group('Basic range', () {
    test('a valid booking passes every rule', () {
      expect(check(ctx(), bkk(2032, 1, 5, 10), bkk(2032, 1, 5, 11)), isNull);
    });

    test('end must be after start', () {
      expect(
        check(ctx(), bkk(2032, 1, 5, 10), bkk(2032, 1, 5, 10)),
        BookingErrorCode.invalidRange,
      );
      expect(
        check(ctx(), bkk(2032, 1, 5, 11), bkk(2032, 1, 5, 10)),
        BookingErrorCode.invalidRange,
      );
    });
  });

  group('Time resolution (slot, default 15 minutes)', () {
    test('start and end must fall on the slot grid', () {
      expect(
        check(ctx(), bkk(2032, 1, 5, 10, 10), bkk(2032, 1, 5, 11)),
        BookingErrorCode.notAligned,
      );
      expect(
        check(ctx(), bkk(2032, 1, 5, 10), bkk(2032, 1, 5, 11, 5)),
        BookingErrorCode.notAligned,
      );
      expect(
        check(ctx(), bkk(2032, 1, 5, 10, 15), bkk(2032, 1, 5, 10, 45)),
        isNull,
      );
    });

    test('seconds are not allowed', () {
      expect(
        check(
          ctx(),
          bkk(2032, 1, 5, 10).add(const Duration(seconds: 1)),
          bkk(2032, 1, 5, 11),
        ),
        BookingErrorCode.notAligned,
      );
    });

    test('alignment is evaluated in local time (Nepal +05:45)', () {
      final kathmandu = TimeZones.location('Asia/Kathmandu');
      final start = TimeZones.utc(tz.TZDateTime(kathmandu, 2032, 1, 5, 10));
      final c = ctx(
        location: kathmandu,
        at: start.subtract(Duration(hours: 1)),
      );
      expect(check(c, start, start.add(const Duration(hours: 1))), isNull);
    });
  });

  group('Minimum and maximum length', () {
    test('shorter than the minimum is rejected', () {
      expect(
        check(ctx(), bkk(2032, 1, 5, 10), bkk(2032, 1, 5, 10, 15)),
        BookingErrorCode.tooShort,
      );
      expect(
        check(ctx(), bkk(2032, 1, 5, 10), bkk(2032, 1, 5, 10, 30)),
        isNull,
      );
    });

    test('longer than the maximum is rejected', () {
      expect(
        check(ctx(), bkk(2032, 1, 5, 10), bkk(2032, 1, 5, 14, 15)),
        BookingErrorCode.tooLong,
      );
      expect(check(ctx(), bkk(2032, 1, 5, 10), bkk(2032, 1, 5, 14)), isNull);
    });

    test('a guest room may allow multi-day stays', () {
      final guest = ctx(r: room(max: 3 * 1440));
      expect(check(guest, bkk(2032, 1, 9, 14), bkk(2032, 1, 11, 12)), isNull);
    });
  });

  group('No booking in the past', () {
    test('a start before the current slot is rejected', () {
      expect(
        check(ctx(), bkk(2032, 1, 5, 7, 45), bkk(2032, 1, 5, 9)),
        BookingErrorCode.inPast,
      );
    });

    test('the current slot may be booked ("use it now")', () {
      // now = 08:05, current slot starts 08:00.
      expect(check(ctx(), bkk(2032, 1, 5, 8), bkk(2032, 1, 5, 9)), isNull);
    });
  });

  group('Advance booking limit (default 30 days)', () {
    test('up to the 30th day is allowed', () {
      expect(
        check(ctx(), bkk(2032, 2, 4, 22), bkk(2032, 2, 4, 23)),
        isNull,
      );
    });

    test('the 31st day is rejected', () {
      expect(
        check(ctx(), bkk(2032, 2, 5, 0), bkk(2032, 2, 5, 1)),
        BookingErrorCode.tooFarAhead,
      );
    });

    test('can be skipped for later occurrences of a series', () {
      final c = ctx();
      expect(
        BookingRules.check(
          c,
          bkk(2032, 3, 1, 10),
          bkk(2032, 3, 1, 11),
          enforceAdvanceLimit: false,
        ),
        isNull,
      );
    });
  });

  group('Opening hours per weekday', () {
    final officeHours = hours(
      open: 8 * 60,
      close: 20 * 60,
      days: {1, 2, 3, 4, 5},
    );

    test('inside opening hours passes', () {
      expect(
        check(ctx(h: officeHours), bkk(2032, 1, 5, 8, 15), bkk(2032, 1, 5, 10)),
        isNull,
      );
      expect(
        check(ctx(h: officeHours), bkk(2032, 1, 5, 18), bkk(2032, 1, 5, 20)),
        isNull,
      );
    });

    test('starting before opening is rejected', () {
      expect(
        check(
          ctx(h: officeHours, at: bkk(2032, 1, 4)),
          bkk(2032, 1, 5, 7, 30),
          bkk(2032, 1, 5, 9),
        ),
        BookingErrorCode.outsideHours,
      );
    });

    test('ending after closing is rejected', () {
      expect(
        check(
          ctx(h: officeHours),
          bkk(2032, 1, 5, 19),
          bkk(2032, 1, 5, 20, 30),
        ),
        BookingErrorCode.outsideHours,
      );
    });

    test('a weekday without hours is closed', () {
      // 10 Jan 2032 is a Saturday.
      expect(
        check(ctx(h: officeHours), bkk(2032, 1, 10, 10), bkk(2032, 1, 10, 11)),
        BookingErrorCode.outsideHours,
      );
    });

    test('overnight stays need every covered day to be open', () {
      final guest = ctx(r: room(max: 3 * 1440));
      expect(
        check(guest, bkk(2032, 1, 9, 14), bkk(2032, 1, 11, 12)),
        isNull,
      );
      final noSaturday = ctx(
        r: room(max: 3 * 1440),
        h: hours(days: {1, 2, 3, 4, 5, 7}),
      );
      expect(
        check(noSaturday, bkk(2032, 1, 9, 14), bkk(2032, 1, 11, 12)),
        BookingErrorCode.outsideHours,
      );
    });

    test('ending exactly at midnight counts as 24:00 of that day', () {
      expect(check(ctx(), bkk(2032, 1, 5, 22), bkk(2032, 1, 6)), isNull);
    });
  });

  group('Temporary closures', () {
    final closure = RoomClosure(
      roomId: 1,
      startAt: bkk(2032, 1, 6, 9),
      endAt: bkk(2032, 1, 6, 12),
      reason: 'Air conditioner repair',
      createdById: 1,
    );

    test('overlapping a closure is rejected with the reason', () {
      final v = BookingRules.check(
        ctx(closures: [closure]),
        bkk(2032, 1, 6, 11),
        bkk(2032, 1, 6, 13),
      );
      expect(v?.code, BookingErrorCode.roomClosed);
      expect(v?.detail, 'Air conditioner repair');
    });

    test('touching a closure boundary is allowed', () {
      expect(
        check(
          ctx(closures: [closure]),
          bkk(2032, 1, 6, 12),
          bkk(2032, 1, 6, 13),
        ),
        isNull,
      );
    });
  });

  group('Weekly quota', () {
    final quotaRoom = ctx(r: room(quota: 120));

    test('unlimited when not set', () {
      expect(
        BookingRules.checkQuota(
          ctx(),
          bkk(2032, 1, 5, 10),
          bkk(2032, 1, 5, 14),
          (_) => 10000,
        ),
        isNull,
      );
    });

    test('within the quota passes', () {
      expect(
        BookingRules.checkQuota(
          quotaRoom,
          bkk(2032, 1, 5, 10),
          bkk(2032, 1, 5, 11),
          (_) => 60,
        ),
        isNull,
      );
    });

    test('exceeding the quota is rejected with the used minutes', () {
      final v = BookingRules.checkQuota(
        quotaRoom,
        bkk(2032, 1, 5, 10),
        bkk(2032, 1, 5, 11),
        (_) => 90,
      );
      expect(v?.code, BookingErrorCode.quotaExceeded);
      expect(v?.detail, '90');
    });

    test('weeks start on Monday 00:00 local time', () {
      final weeks = BookingRules.splitByWeek(
        bkk(2032, 1, 11, 22),
        bkk(2032, 1, 12, 2),
        bangkok,
      );
      expect(weeks, hasLength(2));
      expect(weeks[0].minutes, 120);
      expect(weeks[1].minutes, 120);
      expect(weeks[1].weekStart.weekday, DateTime.monday);
      expect(weeks[1].weekStart.hour, 0);
    });
  });

  group('Overlap semantics [start, end)', () {
    test('back-to-back bookings do not overlap', () {
      expect(
        BookingRules.overlaps(
          bkk(2032, 1, 5, 10),
          bkk(2032, 1, 5, 11),
          bkk(2032, 1, 5, 11),
          bkk(2032, 1, 5, 12),
        ),
        isFalse,
      );
    });

    test('any shared minute overlaps', () {
      expect(
        BookingRules.overlaps(
          bkk(2032, 1, 5, 10),
          bkk(2032, 1, 5, 11, 15),
          bkk(2032, 1, 5, 11),
          bkk(2032, 1, 5, 12),
        ),
        isTrue,
      );
    });
  });

  group('Suggestions (nearest free slots)', () {
    test('returns the closest free slots of the same length', () {
      final busy = [(start: bkk(2032, 1, 5, 10), end: bkk(2032, 1, 5, 12))];
      final slots = SlotFinder.suggest(
        ctx: ctx(),
        desiredStart: bkk(2032, 1, 5, 10, 30),
        durationMinutes: 60,
        busy: busy,
      );
      expect(slots, hasLength(3));
      // 09:00 and 12:00 are equally close; the later one comes first.
      expect(slots.map((s) => s.startAt), [
        bkk(2032, 1, 5, 12),
        bkk(2032, 1, 5, 9),
        bkk(2032, 1, 5, 12, 15),
      ]);
      for (final s in slots) {
        expect(s.endAt.difference(s.startAt).inMinutes, 60);
        expect(
          BookingRules.overlaps(s.startAt, s.endAt, busy[0].start, busy[0].end),
          isFalse,
        );
      }
    });

    test('never suggests closed hours or the past', () {
      final slots = SlotFinder.suggest(
        ctx: ctx(
          h: hours(open: 9 * 60, close: 10 * 60, days: {1}),
        ),
        desiredStart: bkk(2032, 1, 5, 9),
        durationMinutes: 60,
        busy: [(start: bkk(2032, 1, 5, 9), end: bkk(2032, 1, 5, 10))],
      );
      // The only other Monday 09:00-10:00 slots are in later weeks.
      expect(slots.first.startAt, bkk(2032, 1, 12, 9));
      for (final s in slots) {
        expect(s.startAt.isAfter(now), isTrue);
      }
    });
  });

  group('Recurring series', () {
    test('keeps the same local time across daylight saving changes', () {
      final berlin = TimeZones.location('Europe/Berlin');
      final start = TimeZones.utc(tz.TZDateTime(berlin, 2032, 3, 22, 19));
      final end = TimeZones.utc(tz.TZDateTime(berlin, 2032, 3, 22, 21));
      final occ = BookingService.occurrences(berlin, start, end, 3);
      expect(occ, hasLength(3));
      for (final o in occ) {
        final local = TimeZones.local(o.start, berlin);
        expect(local.hour, 19);
        expect(local.weekday, DateTime.monday);
        expect(o.end.difference(o.start), const Duration(hours: 2));
      }
      // Clocks move forward on 28 March 2032, so UTC shifts by one hour.
      expect(
        occ[1].start.difference(occ[0].start),
        const Duration(days: 7, hours: -1),
      );
    });
  });

  group('Room settings validation', () {
    test('accepts the defaults from the SRS', () {
      expect(BookingRules.validateRoomSettings(room(), hours()), isNull);
    });

    test('rejects inconsistent rules', () {
      expect(
        BookingRules.validateRoomSettings(room(slot: 7), hours()),
        isNotNull,
      );
      expect(
        BookingRules.validateRoomSettings(room(min: 20), hours()),
        isNotNull,
      );
      expect(
        BookingRules.validateRoomSettings(room(max: 15), hours()),
        isNotNull,
      );
      expect(
        BookingRules.validateRoomSettings(room(advance: 0), hours()),
        isNotNull,
      );
      expect(
        BookingRules.validateRoomSettings(room(quota: 10), hours()),
        isNotNull,
      );
      expect(
        BookingRules.validateRoomSettings(room(), hours(open: 600, close: 540)),
        isNotNull,
      );
      expect(
        BookingRules.validateRoomSettings(room(), [
          RoomHours(weekday: 1, openMinute: 0, closeMinute: 600),
          RoomHours(weekday: 1, openMinute: 700, closeMinute: 800),
        ]),
        isNotNull,
      );
    });
  });
}
