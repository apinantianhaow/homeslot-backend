import 'package:homeslot_server/src/generated/protocol.dart';
import 'package:homeslot_server/src/util/time_zones.dart';
import 'package:test/test.dart';
import 'package:timezone/timezone.dart' as tz;

import 'helpers.dart';

/// Regression tests for issues found in code review.
void main() {
  withServerpod('Review fixes', (sessionBuilder, endpoints) {
    setUp(setUpHomeSlot);

    test('closing a room later keeps a booking in use until then', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      final inUse = await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 7, 8), bkk(2030, 1, 7, 12)),
      );
      moveClockTo(bkk(2030, 1, 7, 9));
      await endpoints.room.close(
        h.owner.s,
        h.room.id!,
        bkk(2030, 1, 7, 10),
        bkk(2030, 1, 7, 17),
        'Painting',
      );

      final row = await Booking.db.findById(
        sessionBuilder.build(),
        inUse.booking.id!,
      );
      expect(row?.status, BookingStatus.confirmed);
      expect(row?.endAt, bkk(2030, 1, 7, 10));

      // The member is still in the room until 10:00, so it stays taken.
      await expectLater(
        endpoints.booking.create(
          h.owner.s,
          request(h.room, bkk(2030, 1, 7, 9), bkk(2030, 1, 7, 9, 45)),
        ),
        throwsA(
          isA<BookingException>().having(
            (e) => e.code,
            'code',
            BookingErrorCode.overlap,
          ),
        ),
      );
      final notes = await endpoints.notification.list(h.member.s);
      expect(notes.first.body, contains('สิ้นสุดเร็วขึ้น'));
    });

    test('releasing at the very first instant cancels the booking', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      final b = await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 7, 9), bkk(2030, 1, 7, 10)),
      );
      moveClockTo(bkk(2030, 1, 7, 9));
      final released = await endpoints.booking.release(
        h.member.s,
        b.booking.id!,
      );
      expect(released.booking.status, BookingStatus.cancelled);
    });

    test('peak hours finish across a daylight saving change', () async {
      final owner = TestUser.create(sessionBuilder);
      await endpoints.household.create(owner.s, 'Berlin flat', 'Europe/Berlin');
      final room = (await endpoints.room.create(
        owner.s,
        Room(householdId: 0, name: 'Office', type: RoomType.office),
        [],
      )).room;
      final me = await endpoints.account.me(owner.s);
      final berlin = TimeZones.location('Europe/Berlin');
      // Clocks go back from 03:00 to 02:00 on 28 October 2029, so
      // 00:00-04:00 local time lasts five real hours.
      await Booking.db.insertRow(
        sessionBuilder.build(),
        Booking(
          householdId: me.household!.id!,
          roomId: room.id!,
          userId: me.user.id!,
          startAt: TimeZones.utc(tz.TZDateTime(berlin, 2029, 10, 28)),
          endAt: TimeZones.utc(tz.TZDateTime(berlin, 2029, 10, 28, 4)),
          status: BookingStatus.completed,
        ),
      );
      moveClockTo(DateTime.utc(2029, 11, 1, 12));
      final peak = await endpoints.stats.peakHours(owner.s, null, 30);
      expect(peak.hourly.reduce((a, b) => a + b), 300);
      expect(peak.hourly[2], 120);
    });

    test('member emails are visible to owners only', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      final session = sessionBuilder.build();
      final ids = (await endpoints.household.members(
        h.owner.s,
      )).map((m) => m.userId).toSet();
      for (final user in await AppUser.db.find(
        session,
        where: (t) => t.id.inSet(ids),
      )) {
        await AppUser.db.updateRow(
          session,
          user.copyWith(email: 'user${user.id}@example.com'),
        );
      }
      final asOwner = await endpoints.household.members(h.owner.s);
      expect(asOwner.every((m) => m.email != null), isTrue);
      final asMember = await endpoints.household.members(h.member.s);
      final myId = (await endpoints.account.me(h.member.s)).user.id;
      for (final m in asMember) {
        expect(m.email == null, m.userId != myId);
      }
    });

    test('profile and room images must be http(s) URLs', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      await expectLater(
        endpoints.account.updateProfile(
          h.member.s,
          'Member',
          '#4FC3F7',
          'javascript:alert(1)',
        ),
        throwsA(isA<AppException>()),
      );
      final saved = await endpoints.account.updateProfile(
        h.member.s,
        'Member',
        '#4FC3F7',
        'https://example.com/a.png',
      );
      expect(saved.avatarUrl, 'https://example.com/a.png');
    });
  });
}
