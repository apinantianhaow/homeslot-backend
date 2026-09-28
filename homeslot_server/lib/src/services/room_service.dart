import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/clock.dart';
import '../util/errors.dart';
import 'booking_rules.dart';
import 'booking_service.dart';
import 'membership.dart';
import 'notifier.dart';
import 'realtime.dart';

/// Room management (SRS 2.2) and the "status now" view (SRS 2.3.9).
abstract final class RoomService {
  static const maxRooms = 30;

  /// Opening hours used when a room is created without any: open all day.
  static List<RoomHours> allDay() => [
    for (var d = 1; d <= 7; d++)
      RoomHours(weekday: d, openMinute: 0, closeMinute: 1440),
  ];

  static Future<List<RoomDetail>> list(Session session, Actor actor) async {
    final rooms = await Room.db.find(
      session,
      where: (t) => t.householdId.equals(actor.householdId),
      orderByList: (t) => [t.sortOrder, t.name],
    );
    return _details(session, rooms);
  }

  static Future<RoomDetail> get(
    Session session,
    Actor actor,
    int roomId,
  ) async {
    final room = await BookingService.roomOf(session, actor, roomId);
    return (await _details(session, [room])).single;
  }

  static Future<List<RoomDetail>> _details(
    Session session,
    List<Room> rooms,
  ) async {
    if (rooms.isEmpty) return [];
    final ids = rooms.map((r) => r.id!).toSet();
    final hours = await RoomHours.db.find(
      session,
      where: (t) => t.roomId.inSet(ids),
      orderBy: (t) => t.weekday,
    );
    final closures = await RoomClosure.db.find(
      session,
      where: (t) => t.roomId.inSet(ids) & (t.endAt > clock.now()),
      orderBy: (t) => t.startAt,
    );
    return [
      for (final r in rooms)
        RoomDetail(
          room: r,
          hours: hours.where((h) => h.roomId == r.id).toList(),
          closures: closures.where((c) => c.roomId == r.id).toList(),
        ),
    ];
  }

  static Future<RoomDetail> create(
    Session session,
    Actor actor,
    Room room,
    List<RoomHours> hours,
  ) async {
    final count = await Room.db.count(
      session,
      where: (t) => t.householdId.equals(actor.householdId),
    );
    if (count >= maxRooms) {
      fail(AppErrorCode.limitReached, 'A household can have $maxRooms rooms.');
    }
    final clean = _clean(room).copyWith(
      id: null,
      householdId: actor.householdId,
      createdAt: clock.now(),
    );
    final effectiveHours = hours.isEmpty ? allDay() : hours;
    _validate(clean, effectiveHours);
    final saved = await session.db.transaction((transaction) async {
      final inserted = await Room.db.insertRow(
        session,
        clean,
        transaction: transaction,
      );
      await _replaceHours(session, inserted.id!, effectiveHours, transaction);
      return inserted;
    });
    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.roomsChanged,
      roomId: saved.id,
    );
    return get(session, actor, saved.id!);
  }

  static Future<RoomDetail> update(
    Session session,
    Actor actor,
    Room room,
    List<RoomHours> hours,
  ) async {
    final existing = await BookingService.roomOf(session, actor, room.id ?? -1);
    final clean = _clean(room).copyWith(
      householdId: existing.householdId,
      createdAt: existing.createdAt,
    );
    _validate(clean, hours);
    await session.db.transaction((transaction) async {
      await Room.db.updateRow(session, clean, transaction: transaction);
      await _replaceHours(session, existing.id!, hours, transaction);
    });
    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.roomsChanged,
      roomId: existing.id,
    );
    return get(session, actor, existing.id!);
  }

  /// Deletes a room. Not allowed while it has upcoming bookings (SRS 2.2.5).
  static Future<void> delete(Session session, Actor actor, int roomId) async {
    final room = await BookingService.roomOf(session, actor, roomId);
    final upcoming = await Booking.db.count(
      session,
      where: (t) =>
          t.roomId.equals(roomId) &
          t.status.inSet(BookingService.active) &
          (t.endAt > clock.now()),
    );
    if (upcoming > 0) {
      fail(
        AppErrorCode.roomHasFutureBookings,
        actor.user.locale == 'en'
            ? 'This room still has $upcoming upcoming bookings. Cancel them '
                  'first or close the room instead.'
            : 'ห้องนี้ยังมีการจองในอนาคต $upcoming รายการ ต้องยกเลิกการจองก่อน '
                  'หรือปิดห้องชั่วคราวแทน',
      );
    }
    await Room.db.deleteRow(session, room);
    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.roomsChanged,
      roomId: roomId,
    );
  }

  /// Closes a room temporarily. Bookings in the closed period are cancelled
  /// and their bookers are notified (SRS 2.2.4, 2.5.3).
  static Future<RoomClosure> close(
    Session session,
    Actor actor, {
    required int roomId,
    required DateTime startAt,
    required DateTime endAt,
    required String reason,
  }) async {
    final room = await BookingService.roomOf(session, actor, roomId);
    final start = startAt.toUtc();
    final end = endAt.toUtc();
    final now = clock.now();
    if (!end.isAfter(start) || !end.isAfter(now)) {
      fail(AppErrorCode.validation, 'The closure must end in the future.');
    }
    final cleanReason = cleanRequired(reason, max: 200, field: 'Reason');

    final (closure, affected) = await session.db.transaction((
      transaction,
    ) async {
      final closure = await RoomClosure.db.insertRow(
        session,
        RoomClosure(
          roomId: roomId,
          startAt: start,
          endAt: end,
          reason: cleanReason,
          createdById: actor.userId,
          createdAt: now,
        ),
        transaction: transaction,
      );
      final overlapping = await Booking.db.find(
        session,
        where: (t) =>
            t.roomId.equals(roomId) &
            t.status.inSet(BookingService.active) &
            (t.startAt < end) &
            (t.endAt > start) &
            (t.endAt > now),
        transaction: transaction,
      );
      final updated = await Booking.db.update(session, [
        for (final b in overlapping)
          if (b.startAt.isAfter(now))
            b.copyWith(
              status: BookingStatus.cancelled,
              cancelledById: actor.userId,
              cancelReason: cleanReason,
              updatedAt: now,
            )
          else if (start.isAfter(now))
            // In use and the closure starts later: keep the booking (and
            // its slot) but end it when the closure starts.
            b.copyWith(endAt: start, updatedAt: now)
          else
            // In use and the closure starts now: end the booking now.
            b.copyWith(
              status: BookingStatus.completed,
              endAt: now.isAfter(b.startAt) ? now : b.endAt,
              releasedAt: now,
              updatedAt: now,
            ),
      ], transaction: transaction);
      return (closure, updated);
    });

    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.roomsChanged,
      roomId: roomId,
    );
    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.bookingsChanged,
      roomId: roomId,
    );
    for (final b in affected) {
      if (b.userId == actor.userId) continue;
      await Notifier.aboutBooking(
        session,
        userId: b.userId,
        type: NotificationType.roomClosed,
        booking: b,
        room: room,
        household: actor.household,
        extra: {
          'reason': cleanReason,
          if (b.status != BookingStatus.cancelled) 'shortened': 'true',
        },
      );
    }
    return closure;
  }

  static Future<void> removeClosure(
    Session session,
    Actor actor,
    int closureId,
  ) async {
    final closure = await RoomClosure.db.findById(session, closureId);
    if (closure == null) fail(AppErrorCode.notFound, 'Closure not found.');
    await BookingService.roomOf(session, actor, closure.roomId);
    await RoomClosure.db.deleteRow(session, closure);
    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.roomsChanged,
      roomId: closure.roomId,
    );
  }

  /// Whether each room is free or in use right now, and its next booking.
  static Future<List<RoomStatus>> statusNow(
    Session session,
    Actor actor,
  ) async {
    final details = await list(session, actor);
    if (details.isEmpty) return [];
    final now = clock.now();
    final ids = details.map((d) => d.room.id!).toSet();
    final bookings = await Booking.db.find(
      session,
      where: (t) =>
          t.roomId.inSet(ids) &
          t.status.inSet(BookingService.active) &
          (t.endAt > now) &
          (t.startAt < now.add(const Duration(days: 7))),
      orderBy: (t) => t.startAt,
    );
    final views = await BookingService.views(session, actor, bookings);
    return [
      for (final d in details)
        () {
          final roomViews = views.where((v) => v.booking.roomId == d.room.id);
          final current = roomViews
              .where(
                (v) =>
                    v.booking.status == BookingStatus.confirmed &&
                    !v.booking.startAt.isAfter(now),
              )
              .firstOrNull;
          final next = roomViews
              .where((v) => v.booking.startAt.isAfter(now))
              .firstOrNull;
          final closure = d.closures
              .where((c) => !c.startAt.isAfter(now) && c.endAt.isAfter(now))
              .firstOrNull;
          final ctx = RuleContext(
            room: d.room,
            hours: d.hours,
            closures: const [],
            location: actor.location,
            now: now,
          );
          final openNow =
              closure == null &&
              BookingRules.isWithinHours(
                ctx,
                now,
                now.add(const Duration(minutes: 1)),
              );
          return RoomStatus(
            room: d.room,
            current: current,
            next: next,
            closure: closure,
            openNow: openNow,
          );
        }(),
    ];
  }

  static Room _clean(Room room) => room.copyWith(
    name: cleanRequired(room.name, max: 60, field: 'Room name'),
    description: cleanOptional(
      room.description,
      max: 500,
      field: 'Description',
    ),
    imageUrl: cleanOptional(room.imageUrl, max: 1000, field: 'Image URL'),
  );

  static void _validate(Room room, List<RoomHours> hours) {
    final error = BookingRules.validateRoomSettings(room, hours);
    if (error != null) fail(AppErrorCode.validation, error);
  }

  static Future<void> _replaceHours(
    Session session,
    int roomId,
    List<RoomHours> hours,
    Transaction transaction,
  ) async {
    await RoomHours.db.deleteWhere(
      session,
      where: (t) => t.roomId.equals(roomId),
      transaction: transaction,
    );
    if (hours.isEmpty) return;
    await RoomHours.db.insert(session, [
      for (final h in hours)
        RoomHours(
          roomId: roomId,
          weekday: h.weekday,
          openMinute: h.openMinute,
          closeMinute: h.closeMinute,
        ),
    ], transaction: transaction);
  }
}
