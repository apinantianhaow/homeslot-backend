import 'package:homeslot_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// SRS 4.4 / 4.6: double bookings must be impossible even when requests
/// arrive at the same moment. Rollback is disabled so every request runs on
/// its own database connection and the requests really race.
void main() {
  withServerpod(
    'Concurrent booking requests against the real database',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      final householdIds = <int>[];

      setUp(setUpHomeSlot);

      tearDownAll(() async {
        final session = sessionBuilder.build();
        for (final id in householdIds) {
          await Household.db.deleteWhere(
            session,
            where: (t) => t.id.equals(id),
          );
        }
      });

      test('exactly one of many simultaneous requests wins the slot', () async {
        final h = await createHousehold(sessionBuilder, endpoints);
        householdIds.add(h.room.householdId);
        final invite = await endpoints.household.createInvite(h.owner.s);
        final racers = <TestUser>[h.owner, h.member];
        for (var i = 0; i < 8; i++) {
          final u = TestUser.create(sessionBuilder);
          await endpoints.household.join(u.s, invite.code);
          racers.add(u);
        }

        final results = await Future.wait([
          for (final u in racers)
            endpoints.booking
                .create(
                  u.s,
                  request(h.room, bkk(2030, 1, 20, 10), bkk(2030, 1, 20, 12)),
                )
                .then<Object>((v) => v)
                .catchError((Object e) => e),
        ]);

        final wins = results.whereType<BookingView>().toList();
        final losses = results.whereType<BookingException>().toList();
        expect(wins, hasLength(1));
        expect(losses, hasLength(racers.length - 1));
        expect(losses.map((e) => e.code).toSet(), {BookingErrorCode.overlap});

        final stored = await Booking.db.find(
          sessionBuilder.build(),
          where: (t) =>
              t.roomId.equals(h.room.id) &
              t.status.inSet({BookingStatus.pending, BookingStatus.confirmed}),
        );
        expect(stored, hasLength(1));
      });

      test('the exclusion constraint itself rejects overlaps', () async {
        final h = await createHousehold(sessionBuilder, endpoints);
        householdIds.add(h.room.householdId);
        final session = sessionBuilder.build();
        final ownerId = (await endpoints.account.me(h.owner.s)).user.id!;

        Booking row(DateTime s, DateTime e, BookingStatus status) => Booking(
          householdId: h.room.householdId,
          roomId: h.room.id!,
          userId: ownerId,
          startAt: s,
          endAt: e,
          status: status,
        );

        await Booking.db.insertRow(
          session,
          row(
            bkk(2030, 1, 21, 10),
            bkk(2030, 1, 21, 11),
            BookingStatus.confirmed,
          ),
        );
        // Direct insert bypassing all application checks.
        await expectLater(
          Booking.db.insertRow(
            session,
            row(
              bkk(2030, 1, 21, 10, 30),
              bkk(2030, 1, 21, 11, 30),
              BookingStatus.pending,
            ),
          ),
          throwsA(
            isA<DatabaseQueryException>().having(
              (e) => e.code,
              'code',
              '23P01',
            ),
          ),
        );
        // [) ranges: back-to-back is fine.
        await Booking.db.insertRow(
          session,
          row(
            bkk(2030, 1, 21, 11),
            bkk(2030, 1, 21, 12),
            BookingStatus.confirmed,
          ),
        );
        // Cancelled bookings do not hold the slot.
        await Booking.db.insertRow(
          session,
          row(
            bkk(2030, 1, 21, 10),
            bkk(2030, 1, 21, 11),
            BookingStatus.cancelled,
          ),
        );
        // end must be after start.
        await expectLater(
          Booking.db.insertRow(
            session,
            row(
              bkk(2030, 1, 21, 15),
              bkk(2030, 1, 21, 14),
              BookingStatus.cancelled,
            ),
          ),
          throwsA(isA<DatabaseQueryException>()),
        );
      });
    },
  );
}
