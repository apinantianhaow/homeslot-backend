import 'package:homeslot_server/src/generated/protocol.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  withServerpod('Household, invitations and members (SRS 2.1)', (
    sessionBuilder,
    endpoints,
  ) {
    setUp(setUpHomeSlot);

    test('creating a household makes the creator its owner', () async {
      final user = TestUser.create(sessionBuilder);
      final me = await endpoints.household.create(user.s, 'บ้านสุข', '');
      expect(me.household?.name, 'บ้านสุข');
      expect(me.household?.timezone, 'Asia/Bangkok');
      expect(me.role, MemberRole.owner);
    });

    test('invite codes have 6 digits and expire after 48 hours', () async {
      final owner = TestUser.create(sessionBuilder);
      await endpoints.household.create(owner.s, 'Home', 'Asia/Bangkok');
      final invite = await endpoints.household.createInvite(owner.s);
      expect(invite.code, matches(RegExp(r'^\d{6}$')));
      expect(invite.expiresAt, testNow.add(const Duration(hours: 48)));

      final joiner = TestUser.create(sessionBuilder);
      moveClockTo(testNow.add(const Duration(hours: 48, minutes: 1)));
      await expectLater(
        endpoints.household.join(joiner.s, invite.code),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCode.invalidInvite,
          ),
        ),
      );
    });

    test('a member joins with the code and sees the same household', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      final me = await endpoints.account.me(h.member.s);
      expect(me.role, MemberRole.member);
      final members = await endpoints.household.members(h.owner.s);
      expect(members.map((m) => m.displayName), ['Owner', 'Member']);
    });

    test('revoked codes stop working immediately', () async {
      final owner = TestUser.create(sessionBuilder);
      await endpoints.household.create(owner.s, 'Home', 'Asia/Bangkok');
      final invite = await endpoints.household.createInvite(owner.s);
      await endpoints.household.revokeInvite(owner.s, invite.id!);
      await expectLater(
        endpoints.household.join(
          TestUser.create(sessionBuilder).s,
          invite.code,
        ),
        throwsA(isA<AppException>()),
      );
    });

    test('5 wrong codes within 15 minutes lock joining', () async {
      final owner = TestUser.create(sessionBuilder);
      await endpoints.household.create(owner.s, 'Home', 'Asia/Bangkok');
      final invite = await endpoints.household.createInvite(owner.s);
      final guesser = TestUser.create(sessionBuilder);
      final wrong = invite.code == '000000' ? '111111' : '000000';
      for (var i = 0; i < 5; i++) {
        await expectLater(
          endpoints.household.join(guesser.s, wrong),
          throwsA(isA<AppException>()),
        );
      }
      await expectLater(
        endpoints.household.join(guesser.s, invite.code),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCode.inviteLocked,
          ),
        ),
      );
      moveClockTo(testNow.add(const Duration(minutes: 16)));
      final me = await endpoints.household.join(guesser.s, invite.code);
      expect(me.household, isNotNull);
    });

    test('owner-only actions are checked on the server', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      final notOwner = throwsA(
        isA<AppException>().having(
          (e) => e.code,
          'code',
          AppErrorCode.notOwner,
        ),
      );
      await expectLater(endpoints.household.createInvite(h.member.s), notOwner);
      await expectLater(
        endpoints.room.create(
          h.member.s,
          Room(householdId: 0, name: 'Mine', type: RoomType.other),
          [],
        ),
        notOwner,
      );
      await expectLater(endpoints.booking.pending(h.member.s), notOwner);
      await expectLater(
        endpoints.stats.usage(h.member.s, StatsPeriod.week, testNow),
        notOwner,
      );
    });

    test('a household always keeps at least one owner', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      final ownerId = (await endpoints.account.me(h.owner.s)).user.id!;
      await expectLater(
        endpoints.household.changeRole(h.owner.s, ownerId, MemberRole.member),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCode.lastOwner,
          ),
        ),
      );
      await expectLater(
        endpoints.household.leave(h.owner.s),
        throwsA(isA<AppException>()),
      );

      final memberId = (await endpoints.account.me(h.member.s)).user.id!;
      final promoted = await endpoints.household.changeRole(
        h.owner.s,
        memberId,
        MemberRole.owner,
      );
      expect(promoted.role, MemberRole.owner);
      await endpoints.household.leave(h.owner.s);
      expect((await endpoints.account.me(h.owner.s)).household, isNull);
    });

    test('leaving cancels the member\'s upcoming bookings', () async {
      final h = await createHousehold(sessionBuilder, endpoints);
      final booking = await endpoints.booking.create(
        h.member.s,
        request(h.room, bkk(2030, 1, 8, 10), bkk(2030, 1, 8, 11)),
      );
      await endpoints.household.leave(h.member.s);
      final all = await endpoints.booking.list(
        h.owner.s,
        bkk(2030, 1, 8),
        bkk(2030, 1, 9),
        null,
      );
      expect(all, isEmpty);
      final session = sessionBuilder.build();
      final row = await Booking.db.findById(session, booking.booking.id!);
      expect(row?.status, BookingStatus.cancelled);
    });

    test(
      'removing a member cancels their bookings and notifies them',
      () async {
        final h = await createHousehold(sessionBuilder, endpoints);
        await endpoints.booking.create(
          h.member.s,
          request(h.room, bkk(2030, 1, 8, 10), bkk(2030, 1, 8, 11)),
        );
        final memberId = (await endpoints.account.me(h.member.s)).user.id!;
        await endpoints.household.removeMember(h.owner.s, memberId);
        expect((await endpoints.account.me(h.member.s)).household, isNull);
        final notes = await endpoints.notification.list(h.member.s);
        expect(notes.first.type, NotificationType.memberRemoved);
      },
    );

    test('data of another household is never visible', () async {
      final a = await createHousehold(sessionBuilder, endpoints);
      final b = await createHousehold(sessionBuilder, endpoints);
      final booking = await endpoints.booking.create(
        a.member.s,
        request(a.room, bkk(2030, 1, 8, 10), bkk(2030, 1, 8, 11)),
      );
      final rooms = await endpoints.room.list(b.owner.s);
      expect(rooms.map((r) => r.room.id), isNot(contains(a.room.id)));
      await expectLater(
        endpoints.room.get(b.owner.s, a.room.id!),
        throwsA(isA<BookingException>()),
      );
      await expectLater(
        endpoints.booking.cancel(
          b.owner.s,
          booking.booking.id!,
          EditScope.single,
          null,
        ),
        throwsA(
          isA<BookingException>().having(
            (e) => e.code,
            'code',
            BookingErrorCode.notFound,
          ),
        ),
      );
    });

    test('deleting the account erases personal data (PDPA)', () async {
      final session = sessionBuilder.build();
      final authUser = await AuthServices.instance.authUsers.create(session);
      final h = await createHousehold(sessionBuilder, endpoints);
      final leaving = TestUser.create(
        sessionBuilder,
        authUserId: authUser.id.uuid,
      );
      await endpoints.household.join(
        leaving.s,
        (await endpoints.household.createInvite(h.owner.s)).code,
      );
      await endpoints.account.updateProfile(
        leaving.s,
        'Somchai',
        '#81C784',
        null,
      );
      moveClockTo(testNow.subtract(const Duration(days: 2)));
      await endpoints.booking.create(
        leaving.s,
        request(h.room, bkk(2030, 1, 5, 10), bkk(2030, 1, 5, 11)),
      );
      moveClockTo(testNow);

      await endpoints.account.deleteAccount(leaving.s);

      final users = await AppUser.db.find(
        session,
        where: (t) => t.displayName.equals('อดีตสมาชิก'),
      );
      expect(users, hasLength(1));
      expect(users.single.email, isNull);
      expect(users.single.authUserId, isNull);
      expect(users.single.deletedAt, isNotNull);

      final history = await endpoints.booking.list(
        h.owner.s,
        bkk(2030, 1, 5),
        bkk(2030, 1, 6),
        null,
      );
      expect(history.single.userName, 'อดีตสมาชิก');
    });
  });
}
