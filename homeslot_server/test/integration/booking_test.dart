import 'package:homeslot_server/src/generated/protocol.dart';
import 'package:homeslot_server/src/services/maintenance.dart';
import 'package:test/test.dart';

import 'helpers.dart';

Matcher throwsBooking(BookingErrorCode code) => throwsA(
  isA<BookingException>().having((e) => e.code, 'code', code),
);

void main() {
  withServerpod('Booking (SRS 2.3)', (sessionBuilder, endpoints) {
    setUp(setUpHomeSlot);

    test('a member books a free slot and it is confirmed', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      final view = await endpoints.booking.create(
        h.member.s,
        request(
          h.room,
          bkk(2030, 1, 7, 19),
          bkk(2030, 1, 7, 21),
          purpose: 'Zoom',
        ),
      );
      expect(view.booking.status, BookingStatus.confirmed);
      expect(view.userName, 'Member');
      expect(view.userColor, '#4FC3F7');
      expect(view.roomName, 'Office');
    });

    test('an overlapping booking is rejected with nearby free slots', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      await endpoints.booking.create(
        h.owner.s,
        request(h.room, bkk(2030, 1, 7, 10), bkk(2030, 1, 7, 12)),
      );
      try {
        await endpoints.booking.create(
          h.member.s,
          request(h.room, bkk(2030, 1, 7, 11), bkk(2030, 1, 7, 12)),
        );
        fail('Expected overlap');
      } on BookingException catch (e) {
        expect(e.code, BookingErrorCode.overlap);
        expect(e.message, contains('มีคนจองแล้ว'));
        expect(e.suggestions, isNotEmpty);
        expect(e.suggestions!.first.startAt, bkk(2030, 1, 7, 12));
      }
    });

    test('back-to-back bookings are allowed ([start, end))', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      await endpoints.booking.create(
        h.owner.s,
        request(h.room, bkk(2030, 1, 7, 10), bkk(2030, 1, 7, 11)),
      );
      final next = await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 7, 11), bkk(2030, 1, 7, 12)),
      );
      expect(next.booking.status, BookingStatus.confirmed);
    });

    test('room rules are checked on create and edit', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      await expectLater(
        endpoints.booking.create(
          h.member.s,
          request(h.room, bkk(2030, 1, 7, 10), bkk(2030, 1, 7, 10, 15)),
        ),
        throwsBooking(BookingErrorCode.tooShort),
      );
      await expectLater(
        endpoints.booking.create(
          h.member.s,
          request(h.room, bkk(2030, 1, 6, 10), bkk(2030, 1, 6, 11)),
        ),
        throwsBooking(BookingErrorCode.inPast),
      );
      await expectLater(
        endpoints.booking.create(
          h.member.s,
          request(h.room, bkk(2030, 3, 1, 10), bkk(2030, 3, 1, 11)),
        ),
        throwsBooking(BookingErrorCode.tooFarAhead),
      );
      final ok = await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 8, 10), bkk(2030, 1, 8, 11)),
      );
      await expectLater(
        endpoints.booking.update(
          h.member.s,
          ok.booking.id!,
          bkk(2030, 1, 8, 10),
          bkk(2030, 1, 8, 15),
          null,
          null,
          EditScope.single,
        ),
        throwsBooking(BookingErrorCode.tooLong),
      );
    });

    test('opening hours are enforced per weekday', () async {
      final h = await createHousehold(
        sessionBuilder,
        endpoints,
        hours: [
          for (var d = 1; d <= 5; d++)
            RoomHours(weekday: d, openMinute: 8 * 60, closeMinute: 20 * 60),
        ],
      );
      await expectLater(
        endpoints.booking.create(
          h.member.s,
          request(h.room, bkk(2030, 1, 12, 10), bkk(2030, 1, 12, 11)),
        ),
        throwsBooking(BookingErrorCode.outsideHours),
      );
    });

    test('members have a weekly quota but owners do not', () async {
      final h = await createHousehold(
        sessionBuilder,
        endpoints,
        room: Room(
          householdId: 0,
          name: 'Living',
          type: RoomType.living,
          weeklyQuotaMinutes: 120,
        ),
      );
      await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 8, 10), bkk(2030, 1, 8, 11, 30)),
      );
      await expectLater(
        endpoints.booking.create(
          h.member.s,
          request(h.room, bkk(2030, 1, 9, 10), bkk(2030, 1, 9, 11)),
        ),
        throwsBooking(BookingErrorCode.quotaExceeded),
      );
      // Next week has a fresh quota.
      await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 14, 10), bkk(2030, 1, 14, 12)),
      );
      // Owners are exempt.
      await endpoints.booking.create(
        h.owner.s,
        request(h.room, bkk(2030, 1, 9, 10), bkk(2030, 1, 9, 14)),
      );
    });

    test('edit and cancel before start; release while in use', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      final b = await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 7, 9), bkk(2030, 1, 7, 11)),
      );
      final moved = await endpoints.booking.update(
        h.member.s,
        b.booking.id!,
        bkk(2030, 1, 7, 9, 30),
        bkk(2030, 1, 7, 11),
        'Study',
        null,
        EditScope.single,
      );
      expect(moved.single.booking.purpose, 'Study');

      // Someone else cannot change it.
      await expectLater(
        endpoints.booking.update(
          h.owner.s,
          b.booking.id!,
          bkk(2030, 1, 7, 10),
          bkk(2030, 1, 7, 11),
          null,
          null,
          EditScope.single,
        ),
        throwsBooking(BookingErrorCode.notAllowed),
      );

      // In use at 10:07: cannot cancel, but can release.
      moveClockTo(bkk(2030, 1, 7, 10, 7));
      await expectLater(
        endpoints.booking.cancel(
          h.member.s,
          b.booking.id!,
          EditScope.single,
          null,
        ),
        throwsBooking(BookingErrorCode.invalidState),
      );
      final released = await endpoints.booking.release(
        h.member.s,
        b.booking.id!,
      );
      expect(released.booking.status, BookingStatus.completed);
      expect(released.booking.endAt, bkk(2030, 1, 7, 10, 7));

      // The rest of the time is free again.
      final next = await endpoints.booking.create(
        h.owner.s,
        request(h.room, bkk(2030, 1, 7, 10, 15), bkk(2030, 1, 7, 11)),
      );
      expect(next.booking.status, BookingStatus.confirmed);
    });

    test('recurring booking: conflicts can be skipped', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      // Owner already has the third Monday.
      await endpoints.booking.create(
        h.owner.s,
        request(h.room, bkk(2030, 1, 21, 19), bkk(2030, 1, 21, 20)),
      );
      final series = SeriesRequest(
        roomId: h.room.id!,
        startAt: bkk(2030, 1, 7, 19),
        endAt: bkk(2030, 1, 7, 21),
        weeks: 12,
        purpose: 'Weekly class',
        skipStarts: [],
      );
      final preview = await endpoints.booking.previewSeries(h.member.s, series);
      expect(preview, hasLength(12));
      expect(preview.where((o) => !o.ok).map((o) => o.startAt), [
        bkk(2030, 1, 21, 19),
      ]);

      await expectLater(
        endpoints.booking.createSeries(h.member.s, series),
        throwsBooking(BookingErrorCode.seriesConflict),
      );
      final created = await endpoints.booking.createSeries(
        h.member.s,
        series.copyWith(skipStarts: [bkk(2030, 1, 21, 19)]),
      );
      expect(created, hasLength(11));
      expect(created.map((v) => v.booking.seriesId).toSet(), hasLength(1));

      // Cancel the whole series from the second occurrence.
      final count = await endpoints.booking.cancel(
        h.member.s,
        created[1].booking.id!,
        EditScope.series,
        null,
      );
      expect(count, 11);
    });

    test('recurring booking: edit all future occurrences', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      final created = await endpoints.booking.createSeries(
        h.member.s,
        SeriesRequest(
          roomId: h.room.id!,
          startAt: bkk(2030, 1, 7, 19),
          endAt: bkk(2030, 1, 7, 21),
          weeks: 4,
          skipStarts: [],
        ),
      );
      final updated = await endpoints.booking.update(
        h.member.s,
        created.first.booking.id!,
        bkk(2030, 1, 8, 18),
        bkk(2030, 1, 8, 19),
        'Moved',
        null,
        EditScope.series,
      );
      expect(updated.map((v) => v.booking.startAt), [
        bkk(2030, 1, 8, 18),
        bkk(2030, 1, 15, 18),
        bkk(2030, 1, 22, 18),
        bkk(2030, 1, 29, 18),
      ]);
    });

    test('calendar lists bookings of all rooms in range', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 8, 10), bkk(2030, 1, 8, 11)),
      );
      final week = await endpoints.booking.list(
        h.owner.s,
        bkk(2030, 1, 7),
        bkk(2030, 1, 14),
        h.room.id,
      );
      expect(week, hasLength(1));
      final upcoming = await endpoints.booking.mine(h.member.s, true, 20, 0);
      expect(upcoming, hasLength(1));
      final past = await endpoints.booking.mine(h.member.s, false, 20, 0);
      expect(past, isEmpty);
    });
  });

  withServerpod('Approval (SRS 2.4)', (sessionBuilder, endpoints) {
    setUp(setUpHomeSlot);

    Future<Household3> approvalHome() => createHousehold(
      sessionBuilder,
      endpoints,
      room: Room(
        householdId: 0,
        name: 'Guest room',
        type: RoomType.guest,
        requiresApproval: true,
        maxMinutes: 3 * 1440,
      ),
    );

    test('requests wait for approval and hold the slot', () async {
      final h = await approvalHome();
      final pending = await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 10, 14), bkk(2030, 1, 12, 12)),
      );
      expect(pending.booking.status, BookingStatus.pending);

      // The owner was notified.
      final ownerNotes = await endpoints.notification.list(h.owner.s);
      expect(ownerNotes.first.type, NotificationType.approvalRequested);

      // The slot is held for everyone, including owners.
      await expectLater(
        endpoints.booking.create(
          h.owner.s,
          request(h.room, bkk(2030, 1, 11, 10), bkk(2030, 1, 11, 12)),
        ),
        throwsBooking(BookingErrorCode.overlap),
      );

      final approved = await endpoints.booking.approve(
        h.owner.s,
        pending.booking.id!,
        EditScope.single,
      );
      expect(approved.single.booking.status, BookingStatus.confirmed);
      final memberNotes = await endpoints.notification.list(h.member.s);
      expect(memberNotes.first.type, NotificationType.bookingApproved);
    });

    test('owners are confirmed immediately', () async {
      final h = await approvalHome();
      final view = await endpoints.booking.create(
        h.owner.s,
        request(h.room, bkk(2030, 1, 10, 14), bkk(2030, 1, 11, 12)),
      );
      expect(view.booking.status, BookingStatus.confirmed);
    });

    test('rejected requests free the slot and keep the reason', () async {
      final h = await approvalHome();
      final pending = await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 10, 14), bkk(2030, 1, 11, 12)),
      );
      final rejected = await endpoints.booking.reject(
        h.owner.s,
        pending.booking.id!,
        'แขกมาพักแล้ว',
        EditScope.single,
      );
      expect(rejected.single.booking.status, BookingStatus.rejected);
      expect(rejected.single.booking.rejectReason, 'แขกมาพักแล้ว');
      final notes = await endpoints.notification.list(h.member.s);
      expect(notes.first.body, contains('แขกมาพักแล้ว'));
      await endpoints.booking.create(
        h.owner.s,
        request(h.room, bkk(2030, 1, 10, 14), bkk(2030, 1, 11, 12)),
      );
    });

    test('undecided requests expire at their start time', () async {
      final h = await approvalHome();
      final pending = await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 8, 10), bkk(2030, 1, 8, 12)),
      );
      moveClockTo(bkk(2030, 1, 8, 10));
      final result = await Maintenance.run(sessionBuilder.build());
      expect(result.expired, 1);
      final session = sessionBuilder.build();
      final row = await Booking.db.findById(session, pending.booking.id!);
      expect(row?.status, BookingStatus.expired);
      final notes = await endpoints.notification.list(h.member.s);
      expect(notes.first.type, NotificationType.bookingExpired);
    });
  });

  withServerpod('Rooms, reminders and statistics', (sessionBuilder, endpoints) {
    setUp(setUpHomeSlot);

    test('a room with upcoming bookings cannot be deleted', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      final b = await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 8, 10), bkk(2030, 1, 8, 11)),
      );
      await expectLater(
        endpoints.room.delete(h.owner.s, h.room.id!),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCode.roomHasFutureBookings,
          ),
        ),
      );
      // The owner cancels it first; the member is notified.
      await endpoints.booking.cancel(
        h.owner.s,
        b.booking.id!,
        EditScope.single,
        'Room removed',
      );
      final notes = await endpoints.notification.list(h.member.s);
      expect(notes.first.type, NotificationType.bookingCancelledByOther);
      await endpoints.room.delete(h.owner.s, h.room.id!);
      expect(await endpoints.room.list(h.owner.s), isEmpty);
    });

    test('closing a room cancels bookings in that period', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 8, 10), bkk(2030, 1, 8, 11)),
      );
      await endpoints.room.close(
        h.owner.s,
        h.room.id!,
        bkk(2030, 1, 8, 9),
        bkk(2030, 1, 8, 17),
        'ซ่อมแอร์',
      );
      final day = await endpoints.booking.list(
        h.owner.s,
        bkk(2030, 1, 8),
        bkk(2030, 1, 9),
        null,
      );
      expect(day, isEmpty);
      final notes = await endpoints.notification.list(h.member.s);
      expect(notes.first.type, NotificationType.roomClosed);
      await expectLater(
        endpoints.booking.create(
          h.member.s,
          request(h.room, bkk(2030, 1, 8, 12), bkk(2030, 1, 8, 13)),
        ),
        throwsBooking(BookingErrorCode.roomClosed),
      );
    });

    test('home screen shows who uses each room and the next booking', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 7, 8), bkk(2030, 1, 7, 9)),
      );
      await endpoints.booking.create(
        h.owner.s,
        request(h.room, bkk(2030, 1, 7, 13), bkk(2030, 1, 7, 14)),
      );
      final status = await endpoints.room.statusNow(h.owner.s);
      expect(status.single.current?.userName, 'Member');
      expect(status.single.next?.userName, 'Owner');
      expect(status.single.openNow, isTrue);
    });

    test('reminders are sent once, N minutes before the start', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      await endpoints.account.updateSettings(h.member.s, true, 30, 'en');
      await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 7, 10), bkk(2030, 1, 7, 11)),
      );
      moveClockTo(bkk(2030, 1, 7, 9, 20));
      expect((await Maintenance.run(sessionBuilder.build())).reminded, 0);
      moveClockTo(bkk(2030, 1, 7, 9, 30));
      expect((await Maintenance.run(sessionBuilder.build())).reminded, 1);
      expect((await Maintenance.run(sessionBuilder.build())).reminded, 0);
      final notes = await endpoints.notification.list(h.member.s);
      expect(notes.first.title, 'Office starts in 30 min');
    });

    test('ended bookings become completed', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 7, 10), bkk(2030, 1, 7, 11)),
      );
      moveClockTo(bkk(2030, 1, 7, 11));
      expect((await Maintenance.run(sessionBuilder.build())).completed, 1);
      final past = await endpoints.booking.mine(h.member.s, false, 10, 0);
      expect(past.single.booking.status, BookingStatus.completed);
    });

    test('usage statistics per room, member, day and hour', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 8, 19), bkk(2030, 1, 8, 21)),
      );
      await endpoints.booking.create(
        h.owner.s,
        request(h.room, bkk(2030, 1, 9, 19), bkk(2030, 1, 9, 20)),
      );
      final week = await endpoints.stats.usage(
        h.owner.s,
        StatsPeriod.week,
        testNow,
      );
      expect(week.totalMinutes, 180);
      expect(week.byRoom.single.minutes, 180);
      expect(week.byMember.first.label, 'Member');
      expect(week.byMember.first.minutes, 120);
      expect(week.byDay, hasLength(7));
      expect(week.byDay[1].minutes, 120);

      moveClockTo(bkk(2030, 1, 10, 8));
      final peak = await endpoints.stats.peakHours(h.owner.s, null, 30);
      expect(peak.hourly[19], 120);
      expect(peak.hourly[20], 60);
      expect(peak.heatmap[1 * 24 + 19], 60);
    });
  });
}
