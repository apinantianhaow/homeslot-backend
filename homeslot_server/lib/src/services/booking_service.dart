import 'package:serverpod/serverpod.dart';
import 'package:timezone/timezone.dart' as tz;

import '../generated/protocol.dart';
import '../util/clock.dart';
import '../util/errors.dart';
import '../util/messages.dart';
import '../util/time_zones.dart';
import 'booking_rules.dart';
import 'membership.dart';
import 'notifier.dart';
import 'realtime.dart';
import 'slot_finder.dart';
import 'users.dart';

typedef Range = ({DateTime start, DateTime end});

/// Booking operations (SRS 2.3 and 2.4).
///
/// Every write validates the room rules first and relies on the
/// `bookings_no_overlap` exclusion constraint as the final guard, so two
/// members pressing "book" at the same moment can never both succeed.
abstract final class BookingService {
  /// Statuses that hold the time slot.
  static const active = {BookingStatus.pending, BookingStatus.confirmed};

  /// Statuses shown in the calendar and counted for quota and statistics.
  static const visible = {
    BookingStatus.pending,
    BookingStatus.confirmed,
    BookingStatus.completed,
  };

  static const maxSeriesWeeks = 12;
  static const maxListRangeDays = 62;

  // ---------------------------------------------------------------------------
  // Queries
  // ---------------------------------------------------------------------------

  static Future<List<BookingView>> list(
    Session session,
    Actor actor, {
    required DateTime from,
    required DateTime to,
    int? roomId,
  }) async {
    if (!to.isAfter(from) ||
        to.difference(from) > const Duration(days: maxListRangeDays)) {
      fail(AppErrorCode.validation, 'Invalid range (max 62 days).');
    }
    final rows = await Booking.db.find(
      session,
      where: (t) {
        var e =
            t.householdId.equals(actor.householdId) &
            t.status.inSet(visible) &
            (t.startAt < to) &
            (t.endAt > from);
        if (roomId != null) e = e & t.roomId.equals(roomId);
        return e;
      },
      orderBy: (t) => t.startAt,
    );
    return views(session, actor, rows);
  }

  static Future<List<BookingView>> mine(
    Session session,
    Actor actor, {
    required bool upcoming,
    int limit = 50,
    int offset = 0,
  }) async {
    final now = clock.now();
    final rows = await Booking.db.find(
      session,
      where: (t) {
        final base =
            t.userId.equals(actor.userId) &
            t.householdId.equals(actor.householdId);
        final isUpcoming = t.status.inSet(active) & (t.endAt > now);
        return upcoming ? base & isUpcoming : base & ~isUpcoming;
      },
      orderBy: (t) => upcoming ? t.startAt : t.startAt.desc(),
      limit: limit.clamp(1, 200),
      offset: offset < 0 ? 0 : offset,
    );
    return views(session, actor, rows);
  }

  static Future<List<BookingView>> pendingApprovals(
    Session session,
    Actor actor,
  ) async {
    final rows = await Booking.db.find(
      session,
      where: (t) =>
          t.householdId.equals(actor.householdId) &
          t.status.equals(BookingStatus.pending) &
          (t.startAt > clock.now()),
      orderBy: (t) => t.startAt,
    );
    return views(session, actor, rows);
  }

  /// Adds room and booker display data to bookings.
  static Future<List<BookingView>> views(
    Session session,
    Actor actor,
    List<Booking> bookings, {
    Transaction? transaction,
  }) async {
    if (bookings.isEmpty) return [];
    final roomIds = bookings.map((b) => b.roomId).toSet();
    final rooms = await Room.db.find(
      session,
      where: (t) => t.id.inSet(roomIds),
      transaction: transaction,
    );
    final roomById = {for (final r in rooms) r.id!: r};
    final users = await Users.byIds(
      session,
      bookings.map((b) => b.userId),
      transaction: transaction,
    );
    return [
      for (final b in bookings)
        BookingView(
          booking: b,
          roomName: roomById[b.roomId]?.name ?? '',
          userName: _displayName(users[b.userId], actor.messages),
          userColor: users[b.userId]?.color ?? '#9E9E9E',
        ),
    ];
  }

  static String _displayName(AppUser? user, Messages messages) {
    if (user == null || user.deletedAt != null) return messages.formerMember;
    return user.displayName;
  }

  // ---------------------------------------------------------------------------
  // Create
  // ---------------------------------------------------------------------------

  static Future<BookingView> create(
    Session session,
    Actor actor,
    BookingRequest request,
  ) async {
    final room = await roomOf(session, actor, request.roomId);
    final start = request.startAt.toUtc();
    final end = request.endAt.toUtc();
    final purpose = cleanOptional(request.purpose, max: 120, field: 'Purpose');
    final note = cleanOptional(request.note, max: 500, field: 'Note');

    final ctx = await contextFor(session, actor, room);
    await _validateOrThrow(session, actor, ctx, start, end);

    final status = room.requiresApproval && !actor.isOwner
        ? BookingStatus.pending
        : BookingStatus.confirmed;
    final now = clock.now();
    final Booking booking;
    try {
      booking = await Booking.db.insertRow(
        session,
        Booking(
          householdId: actor.householdId,
          roomId: room.id!,
          userId: actor.userId,
          startAt: start,
          endAt: end,
          status: status,
          purpose: purpose,
          note: note,
          createdAt: now,
          updatedAt: now,
        ),
      );
    } on DatabaseQueryException catch (e) {
      if (isOverlapViolation(e)) {
        throw await _error(
          session,
          actor,
          ctx,
          const RuleViolation(BookingErrorCode.overlap),
          start,
          end,
        );
      }
      rethrow;
    }

    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.bookingsChanged,
      roomId: room.id,
      bookingId: booking.id,
    );
    if (booking.status == BookingStatus.pending) {
      await _notifyOwnersOfRequest(session, actor, room, booking);
    }
    return (await views(session, actor, [booking])).single;
  }

  static Future<List<TimeSlot>> suggest(
    Session session,
    Actor actor, {
    required int roomId,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    final room = await roomOf(session, actor, roomId);
    final ctx = await contextFor(session, actor, room);
    return _suggestions(session, ctx, startAt.toUtc(), endAt.toUtc());
  }

  // ---------------------------------------------------------------------------
  // Recurring series (SRS 2.3.5)
  // ---------------------------------------------------------------------------

  static Future<List<SeriesOccurrence>> previewSeries(
    Session session,
    Actor actor,
    SeriesRequest request,
  ) async {
    final room = await roomOf(session, actor, request.roomId);
    final ctx = await contextFor(session, actor, room);
    return _checkOccurrences(
      session,
      actor,
      ctx,
      occurrences(
        actor.location,
        request.startAt.toUtc(),
        request.endAt.toUtc(),
        _validWeeks(request.weeks),
      ),
    );
  }

  static Future<List<BookingView>> createSeries(
    Session session,
    Actor actor,
    SeriesRequest request,
  ) async {
    final room = await roomOf(session, actor, request.roomId);
    final ctx = await contextFor(session, actor, room);
    final weeks = _validWeeks(request.weeks);
    final purpose = cleanOptional(request.purpose, max: 120, field: 'Purpose');
    final note = cleanOptional(request.note, max: 500, field: 'Note');
    final start = request.startAt.toUtc();
    final end = request.endAt.toUtc();

    final checked = await _checkOccurrences(
      session,
      actor,
      ctx,
      occurrences(actor.location, start, end, weeks),
    );
    final skipped = request.skipStarts
        .map((d) => d.toUtc().microsecondsSinceEpoch)
        .toSet();
    bool isSkipped(SeriesOccurrence o) =>
        skipped.contains(o.startAt.microsecondsSinceEpoch);

    final conflicts = checked.where((o) => !o.ok && !isSkipped(o)).toList();
    if (conflicts.isNotEmpty) {
      throw _seriesConflict(actor, room, checked);
    }
    final toCreate = checked.where((o) => o.ok && !isSkipped(o)).toList();
    if (toCreate.isEmpty) {
      throw BookingException(
        code: BookingErrorCode.seriesConflict,
        message: actor.messages.bookingError(BookingErrorCode.seriesConflict),
        conflicts: checked,
      );
    }

    final status = room.requiresApproval && !actor.isOwner
        ? BookingStatus.pending
        : BookingStatus.confirmed;
    final localStart = TimeZones.local(start, actor.location);
    final startMinute = TimeZones.minuteOfDay(localStart);
    final now = clock.now();

    final List<Booking> created;
    try {
      created = await session.db.transaction((transaction) async {
        final series = await BookingSeries.db.insertRow(
          session,
          BookingSeries(
            roomId: room.id!,
            userId: actor.userId,
            weekday: localStart.weekday,
            startMinute: startMinute,
            endMinute: startMinute + end.difference(start).inMinutes,
            weeks: weeks,
            untilDate: checked.last.startAt,
            purpose: purpose,
          ),
          transaction: transaction,
        );
        return Booking.db.insert(session, [
          for (final o in toCreate)
            Booking(
              householdId: actor.householdId,
              roomId: room.id!,
              userId: actor.userId,
              seriesId: series.id,
              startAt: o.startAt,
              endAt: o.endAt,
              status: status,
              purpose: purpose,
              note: note,
              createdAt: now,
              updatedAt: now,
            ),
        ], transaction: transaction);
      });
    } on DatabaseQueryException catch (e) {
      if (isOverlapViolation(e)) {
        final again = await _checkOccurrences(
          session,
          actor,
          ctx,
          occurrences(actor.location, start, end, weeks),
        );
        throw _seriesConflict(actor, room, again);
      }
      rethrow;
    }

    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.bookingsChanged,
      roomId: room.id,
    );
    if (status == BookingStatus.pending) {
      await _notifyOwnersOfRequest(session, actor, room, created.first);
    }
    return views(session, actor, created);
  }

  /// Weekly occurrences keeping the same local wall-clock time, even across
  /// daylight saving changes.
  static List<Range> occurrences(
    tz.Location location,
    DateTime start,
    DateTime end,
    int weeks,
  ) {
    final ls = TimeZones.local(start, location);
    final le = TimeZones.local(end, location);
    return [
      for (var i = 0; i < weeks; i++)
        (
          start: _utc(
            tz.TZDateTime(
              location,
              ls.year,
              ls.month,
              ls.day + 7 * i,
              ls.hour,
              ls.minute,
            ),
          ),
          end: _utc(
            tz.TZDateTime(
              location,
              le.year,
              le.month,
              le.day + 7 * i,
              le.hour,
              le.minute,
            ),
          ),
        ),
    ];
  }

  static int _validWeeks(int weeks) {
    if (weeks < 2 || weeks > maxSeriesWeeks) {
      fail(
        AppErrorCode.validation,
        'A recurring booking must be 2-$maxSeriesWeeks weeks.',
      );
    }
    return weeks;
  }

  static Future<List<SeriesOccurrence>> _checkOccurrences(
    Session session,
    Actor actor,
    RuleContext ctx,
    List<Range> ranges, {
    Set<int> excludeIds = const {},
  }) async {
    if (ranges.isEmpty) return [];
    final spanStart = ranges.first.start;
    final spanEnd = ranges.last.end;
    final busy = await busyRanges(
      session,
      ctx.room.id!,
      spanStart,
      spanEnd,
      excludeIds: excludeIds,
    );
    final usage = actor.isOwner
        ? null
        : await _quotaUsage(
            session,
            actor,
            ctx,
            spanStart,
            spanEnd,
            excludeIds: excludeIds,
          );

    final result = <SeriesOccurrence>[];
    for (var i = 0; i < ranges.length; i++) {
      final r = ranges[i];
      var violation = BookingRules.check(
        ctx,
        r.start,
        r.end,
        enforceAdvanceLimit: i == 0,
      );
      if (violation == null && usage != null) {
        violation = BookingRules.checkQuota(ctx, r.start, r.end, usage);
      }
      if (violation == null &&
          busy.any(
            (b) => BookingRules.overlaps(r.start, r.end, b.start, b.end),
          )) {
        violation = const RuleViolation(BookingErrorCode.overlap);
      }
      result.add(
        SeriesOccurrence(
          startAt: r.start,
          endAt: r.end,
          ok: violation == null,
          code: violation?.code,
          message: violation == null
              ? null
              : _message(actor, ctx.room, violation),
        ),
      );
    }
    return result;
  }

  static BookingException _seriesConflict(
    Actor actor,
    Room room,
    List<SeriesOccurrence> checked,
  ) => BookingException(
    code: BookingErrorCode.seriesConflict,
    message: actor.messages.bookingError(BookingErrorCode.seriesConflict),
    conflicts: checked,
  );

  // ---------------------------------------------------------------------------
  // Edit, cancel, release (SRS 2.3.6, 2.3.7)
  // ---------------------------------------------------------------------------

  static Future<List<BookingView>> update(
    Session session,
    Actor actor, {
    required int bookingId,
    required DateTime startAt,
    required DateTime endAt,
    String? purpose,
    String? note,
    EditScope scope = EditScope.single,
  }) async {
    final booking = await _ownBooking(session, actor, bookingId);
    _requireNotStarted(actor, booking);
    final room = await roomOf(session, actor, booking.roomId);
    final ctx = await contextFor(session, actor, room);
    final newPurpose = cleanOptional(purpose, max: 120, field: 'Purpose');
    final newNote = cleanOptional(note, max: 500, field: 'Note');
    final start = startAt.toUtc();
    final end = endAt.toUtc();

    if (scope == EditScope.series && booking.seriesId != null) {
      return _updateSeries(
        session,
        actor,
        ctx,
        booking,
        start,
        end,
        newPurpose,
        newNote,
      );
    }

    final timeChanged =
        !start.isAtSameMomentAs(booking.startAt) ||
        !end.isAtSameMomentAs(booking.endAt);
    if (timeChanged) {
      await _validateOrThrow(
        session,
        actor,
        ctx,
        start,
        end,
        excludeIds: {booking.id!},
      );
    }
    final needsApproval =
        timeChanged && room.requiresApproval && !actor.isOwner;
    final updatedRow = booking.copyWith(
      startAt: start,
      endAt: end,
      purpose: newPurpose,
      note: newNote,
      status: needsApproval ? BookingStatus.pending : booking.status,
      decidedById: needsApproval ? null : booking.decidedById,
      reminderSentAt: timeChanged ? null : booking.reminderSentAt,
      updatedAt: clock.now(),
    );
    final Booking saved;
    try {
      saved = await Booking.db.updateRow(session, updatedRow);
    } on DatabaseQueryException catch (e) {
      if (isOverlapViolation(e)) {
        throw await _error(
          session,
          actor,
          ctx,
          const RuleViolation(BookingErrorCode.overlap),
          start,
          end,
          excludeIds: {booking.id!},
        );
      }
      rethrow;
    }
    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.bookingsChanged,
      roomId: room.id,
      bookingId: saved.id,
    );
    if (needsApproval) {
      await _notifyOwnersOfRequest(session, actor, room, saved);
    }
    return views(session, actor, [saved]);
  }

  static Future<List<BookingView>> _updateSeries(
    Session session,
    Actor actor,
    RuleContext ctx,
    Booking edited,
    DateTime start,
    DateTime end,
    String? purpose,
    String? note,
  ) async {
    final now = clock.now();
    final siblings = await Booking.db.find(
      session,
      where: (t) =>
          t.seriesId.equals(edited.seriesId) &
          t.status.inSet(active) &
          (t.startAt > now),
      orderBy: (t) => t.startAt,
    );
    final location = actor.location;
    final oldStart = TimeZones.local(edited.startAt, location);
    final newStart = TimeZones.local(start, location);
    final dayShift = TimeZones.startOfDay(
      newStart,
    ).difference(TimeZones.startOfDay(oldStart)).inHours.toDouble();
    final shiftDays = (dayShift / 24).round();
    if (shiftDays.abs() > 6) {
      fail(
        AppErrorCode.validation,
        'A series can be moved by at most 6 days. Cancel it and book again.',
      );
    }
    final startMinute = TimeZones.minuteOfDay(newStart);
    final duration = end.difference(start).inMinutes;
    if (duration <= 0) {
      throw BookingException(
        code: BookingErrorCode.invalidRange,
        message: actor.messages.bookingError(BookingErrorCode.invalidRange),
      );
    }

    final ranges = <Range>[
      for (final b in siblings)
        () {
          final day = TimeZones.local(b.startAt, location);
          final s = tz.TZDateTime(
            location,
            day.year,
            day.month,
            day.day + shiftDays,
            0,
            startMinute,
          );
          final e = tz.TZDateTime(
            location,
            day.year,
            day.month,
            day.day + shiftDays,
            0,
            startMinute + duration,
          );
          return (start: _utc(s), end: _utc(e));
        }(),
    ];
    final siblingIds = siblings.map((b) => b.id!).toSet();
    final checked = await _checkOccurrences(
      session,
      actor,
      ctx,
      ranges,
      excludeIds: siblingIds,
    );
    if (checked.any((o) => !o.ok)) {
      throw _seriesConflict(actor, ctx.room, checked);
    }

    final timeChanged =
        !start.isAtSameMomentAs(edited.startAt) ||
        !end.isAtSameMomentAs(edited.endAt);
    final needsApproval =
        timeChanged && ctx.room.requiresApproval && !actor.isOwner;

    // Apply in an order that never makes two siblings overlap temporarily.
    final order = [for (var i = 0; i < siblings.length; i++) i];
    if (start.isAfter(edited.startAt)) {
      order.setAll(0, order.reversed.toList());
    }

    final List<Booking> saved;
    try {
      saved = await session.db.transaction((transaction) async {
        final result = List<Booking?>.filled(siblings.length, null);
        for (final i in order) {
          result[i] = await Booking.db.updateRow(
            session,
            siblings[i].copyWith(
              startAt: ranges[i].start,
              endAt: ranges[i].end,
              purpose: purpose,
              note: note,
              status: needsApproval
                  ? BookingStatus.pending
                  : siblings[i].status,
              decidedById: needsApproval ? null : siblings[i].decidedById,
              reminderSentAt: timeChanged ? null : siblings[i].reminderSentAt,
              updatedAt: now,
            ),
            transaction: transaction,
          );
        }
        final series = await BookingSeries.db.findById(
          session,
          edited.seriesId!,
          transaction: transaction,
        );
        if (series != null && ranges.isNotEmpty) {
          final first = TimeZones.local(ranges.first.start, location);
          await BookingSeries.db.updateRow(
            session,
            series.copyWith(
              weekday: first.weekday,
              startMinute: startMinute,
              endMinute: startMinute + duration,
              untilDate: ranges.last.start,
              purpose: purpose,
            ),
            transaction: transaction,
          );
        }
        return result.cast<Booking>();
      });
    } on DatabaseQueryException catch (e) {
      if (isOverlapViolation(e)) {
        final again = await _checkOccurrences(
          session,
          actor,
          ctx,
          ranges,
          excludeIds: siblingIds,
        );
        throw _seriesConflict(actor, ctx.room, again);
      }
      rethrow;
    }

    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.bookingsChanged,
      roomId: ctx.room.id,
    );
    if (needsApproval && saved.isNotEmpty) {
      await _notifyOwnersOfRequest(session, actor, ctx.room, saved.first);
    }
    return views(session, actor, saved);
  }

  /// Cancels a booking before it starts. Owners may cancel anyone's booking
  /// (e.g. before deleting a room, SRS 2.2.5); the booker is then notified.
  static Future<int> cancel(
    Session session,
    Actor actor, {
    required int bookingId,
    EditScope scope = EditScope.single,
    String? reason,
  }) async {
    final booking = await _householdBooking(session, actor, bookingId);
    final byOther = booking.userId != actor.userId;
    if (byOther && !actor.isOwner) {
      throw _simple(actor, BookingErrorCode.notAllowed);
    }
    _requireNotStarted(actor, booking);
    final cleanReason = cleanOptional(reason, max: 200, field: 'Reason');
    final now = clock.now();

    final targets = scope == EditScope.series && booking.seriesId != null
        ? await Booking.db.find(
            session,
            where: (t) =>
                t.seriesId.equals(booking.seriesId) &
                t.status.inSet(active) &
                (t.startAt > now),
            orderBy: (t) => t.startAt,
          )
        : [booking];

    final cancelled = await Booking.db.update(session, [
      for (final b in targets)
        b.copyWith(
          status: BookingStatus.cancelled,
          cancelledById: byOther ? actor.userId : null,
          cancelReason: cleanReason,
          updatedAt: now,
        ),
    ]);
    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.bookingsChanged,
      roomId: booking.roomId,
      bookingId: booking.id,
    );
    if (byOther && cancelled.isNotEmpty) {
      final room = await Room.db.findById(session, booking.roomId);
      if (room != null) {
        await Notifier.aboutBooking(
          session,
          userId: booking.userId,
          type: NotificationType.bookingCancelledByOther,
          booking: cancelled.first,
          room: room,
          household: actor.household,
          extra: {
            'user': actor.user.displayName,
            'reason': ?cleanReason,
          },
        );
      }
    }
    return cancelled.length;
  }

  /// Ends a booking early so others can use the rest of the time (SRS 2.3.7).
  static Future<BookingView> release(
    Session session,
    Actor actor,
    int bookingId,
  ) async {
    final booking = await _ownBooking(session, actor, bookingId);
    final now = clock.now();
    if (booking.status != BookingStatus.confirmed ||
        booking.startAt.isAfter(now) ||
        !booking.endAt.isAfter(now)) {
      throw _simple(
        actor,
        BookingErrorCode.invalidState,
        detail: actor.user.locale == 'en'
            ? 'Only a booking that is in use now can be released.'
            : 'คืนห้องได้เฉพาะการจองที่กำลังใช้งานอยู่',
      );
    }
    // Released at the very first instant: nothing was used, so cancel it.
    final used = now.isAfter(booking.startAt);
    final saved = await Booking.db.updateRow(
      session,
      booking.copyWith(
        endAt: used ? now : booking.endAt,
        status: used ? BookingStatus.completed : BookingStatus.cancelled,
        releasedAt: now,
        updatedAt: now,
      ),
    );
    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.bookingsChanged,
      roomId: booking.roomId,
      bookingId: booking.id,
    );
    return (await views(session, actor, [saved])).single;
  }

  // ---------------------------------------------------------------------------
  // Approval (SRS 2.4)
  // ---------------------------------------------------------------------------

  static Future<List<BookingView>> decide(
    Session session,
    Actor actor, {
    required int bookingId,
    required bool approve,
    String? reason,
    EditScope scope = EditScope.single,
  }) async {
    if (!actor.isOwner) throw _simple(actor, BookingErrorCode.notAllowed);
    final booking = await _householdBooking(session, actor, bookingId);
    final now = clock.now();
    if (booking.status != BookingStatus.pending ||
        !booking.startAt.isAfter(now)) {
      throw _simple(
        actor,
        BookingErrorCode.invalidState,
        detail: actor.user.locale == 'en'
            ? 'This request has already been decided or has expired.'
            : 'คำขอนี้ถูกตัดสินไปแล้วหรือหมดอายุแล้ว',
      );
    }
    final cleanReason = cleanOptional(reason, max: 200, field: 'Reason');
    final targets = scope == EditScope.series && booking.seriesId != null
        ? await Booking.db.find(
            session,
            where: (t) =>
                t.seriesId.equals(booking.seriesId) &
                t.status.equals(BookingStatus.pending) &
                (t.startAt > now),
            orderBy: (t) => t.startAt,
          )
        : [booking];

    final saved = await Booking.db.update(session, [
      for (final b in targets)
        b.copyWith(
          status: approve ? BookingStatus.confirmed : BookingStatus.rejected,
          decidedById: actor.userId,
          rejectReason: approve ? null : cleanReason,
          updatedAt: now,
        ),
    ]);
    await Realtime.household(
      session,
      actor.householdId,
      HouseholdEventType.bookingsChanged,
      roomId: booking.roomId,
      bookingId: booking.id,
    );
    final room = await Room.db.findById(session, booking.roomId);
    if (room != null && saved.isNotEmpty) {
      await Notifier.aboutBooking(
        session,
        userId: booking.userId,
        type: approve
            ? NotificationType.bookingApproved
            : NotificationType.bookingRejected,
        booking: saved.first,
        room: room,
        household: actor.household,
        extra: {'reason': ?cleanReason},
      );
    }
    saved.sort((a, b) => a.startAt.compareTo(b.startAt));
    return views(session, actor, saved);
  }

  // ---------------------------------------------------------------------------
  // Cascades used by membership and room management
  // ---------------------------------------------------------------------------

  /// Cancels a member's upcoming bookings and ends any booking in progress,
  /// e.g. when they leave or are removed from the household (SRS 2.1.7).
  static Future<List<Booking>> endFutureBookingsOfUser(
    Session session, {
    required int householdId,
    required int userId,
    int? byUserId,
    String? reason,
    Transaction? transaction,
  }) async {
    final now = clock.now();
    final rows = await Booking.db.find(
      session,
      where: (t) =>
          t.householdId.equals(householdId) &
          t.userId.equals(userId) &
          t.status.inSet(active) &
          (t.endAt > now),
      transaction: transaction,
    );
    if (rows.isEmpty) return [];
    return Booking.db.update(session, [
      for (final b in rows)
        b.startAt.isAfter(now)
            ? b.copyWith(
                status: BookingStatus.cancelled,
                cancelledById: byUserId,
                cancelReason: reason,
                updatedAt: now,
              )
            : b.status == BookingStatus.confirmed
            ? b.copyWith(
                status: BookingStatus.completed,
                endAt: now,
                releasedAt: now,
                updatedAt: now,
              )
            : b.copyWith(status: BookingStatus.expired, updatedAt: now),
    ], transaction: transaction);
  }

  // ---------------------------------------------------------------------------
  // Validation helpers
  // ---------------------------------------------------------------------------

  static Future<Room> roomOf(
    Session session,
    Actor actor,
    int roomId, {
    Transaction? transaction,
  }) async {
    final room = await Room.db.findById(
      session,
      roomId,
      transaction: transaction,
    );
    if (room == null || room.householdId != actor.householdId) {
      throw _simple(actor, BookingErrorCode.notFound);
    }
    return room;
  }

  static Future<RuleContext> contextFor(
    Session session,
    Actor actor,
    Room room,
  ) async {
    final hours = await RoomHours.db.find(
      session,
      where: (t) => t.roomId.equals(room.id),
    );
    final now = clock.now();
    final closures = await RoomClosure.db.find(
      session,
      where: (t) => t.roomId.equals(room.id) & (t.endAt > now),
    );
    return RuleContext(
      room: room,
      hours: hours,
      closures: closures,
      location: actor.location,
      now: now,
    );
  }

  static Future<List<Range>> busyRanges(
    Session session,
    int roomId,
    DateTime from,
    DateTime to, {
    Set<int> excludeIds = const {},
  }) async {
    final rows = await Booking.db.find(
      session,
      where: (t) {
        var e =
            t.roomId.equals(roomId) &
            t.status.inSet(active) &
            (t.startAt < to) &
            (t.endAt > from);
        if (excludeIds.isNotEmpty) e = e & t.id.notInSet(excludeIds);
        return e;
      },
      orderBy: (t) => t.startAt,
    );
    return [for (final b in rows) (start: b.startAt, end: b.endAt)];
  }

  /// Loads what the member already booked in this room for the local weeks
  /// touched by [from, to), for the weekly quota rule.
  static Future<int Function(tz.TZDateTime)> _quotaUsage(
    Session session,
    Actor actor,
    RuleContext ctx,
    DateTime from,
    DateTime to, {
    Set<int> excludeIds = const {},
  }) async {
    if (ctx.room.weeklyQuotaMinutes == null) return (_) => 0;
    final weekFrom = TimeZones.startOfWeek(TimeZones.local(from, ctx.location));
    final weekTo = TimeZones.addDays(
      TimeZones.startOfWeek(TimeZones.local(to, ctx.location)),
      7,
    );
    final rows = await Booking.db.find(
      session,
      where: (t) {
        var e =
            t.roomId.equals(ctx.room.id) &
            t.userId.equals(actor.userId) &
            t.status.inSet(visible) &
            (t.startAt < TimeZones.utc(weekTo)) &
            (t.endAt > TimeZones.utc(weekFrom));
        if (excludeIds.isNotEmpty) e = e & t.id.notInSet(excludeIds);
        return e;
      },
    );
    return (weekStart) {
      final weekEnd = TimeZones.addDays(weekStart, 7);
      var total = 0;
      for (final b in rows) {
        total += BookingRules.overlapMinutes(
          b.startAt,
          b.endAt,
          weekStart,
          weekEnd,
        );
      }
      return total;
    };
  }

  static Future<void> _validateOrThrow(
    Session session,
    Actor actor,
    RuleContext ctx,
    DateTime start,
    DateTime end, {
    Set<int> excludeIds = const {},
  }) async {
    var violation = BookingRules.check(ctx, start, end);
    if (violation == null && !actor.isOwner) {
      final usage = await _quotaUsage(
        session,
        actor,
        ctx,
        start,
        end,
        excludeIds: excludeIds,
      );
      violation = BookingRules.checkQuota(ctx, start, end, usage);
    }
    if (violation == null) {
      final busy = await busyRanges(
        session,
        ctx.room.id!,
        start,
        end,
        excludeIds: excludeIds,
      );
      if (busy.isNotEmpty) {
        violation = const RuleViolation(BookingErrorCode.overlap);
      }
    }
    if (violation != null) {
      throw await _error(
        session,
        actor,
        ctx,
        violation,
        start,
        end,
        excludeIds: excludeIds,
      );
    }
  }

  static Future<BookingException> _error(
    Session session,
    Actor actor,
    RuleContext ctx,
    RuleViolation violation,
    DateTime start,
    DateTime end, {
    Set<int> excludeIds = const {},
  }) async {
    const withSuggestions = {
      BookingErrorCode.overlap,
      BookingErrorCode.outsideHours,
      BookingErrorCode.roomClosed,
      BookingErrorCode.inPast,
    };
    List<TimeSlot>? suggestions;
    if (withSuggestions.contains(violation.code) && end.isAfter(start)) {
      suggestions = await _suggestions(
        session,
        ctx,
        start,
        end,
        excludeIds: excludeIds,
      );
    }
    return BookingException(
      code: violation.code,
      message: _message(actor, ctx.room, violation),
      suggestions: suggestions,
    );
  }

  static String _message(Actor actor, Room room, RuleViolation violation) {
    final messages = actor.messages;
    var detail = violation.detail;
    if (violation.code == BookingErrorCode.quotaExceeded && detail != null) {
      detail = messages.duration(int.tryParse(detail) ?? 0);
    }
    return messages.bookingError(violation.code, room: room, detail: detail);
  }

  static Future<List<TimeSlot>> _suggestions(
    Session session,
    RuleContext ctx,
    DateTime start,
    DateTime end, {
    Set<int> excludeIds = const {},
  }) async {
    final horizon = ctx.now.add(Duration(days: ctx.room.advanceDays + 2));
    final busy = await busyRanges(
      session,
      ctx.room.id!,
      ctx.now.subtract(const Duration(days: 1)),
      horizon,
      excludeIds: excludeIds,
    );
    return SlotFinder.suggest(
      ctx: ctx,
      desiredStart: start,
      durationMinutes: end.difference(start).inMinutes,
      busy: busy,
    );
  }

  static bool isOverlapViolation(DatabaseQueryException e) =>
      e.code == '23P01' || e.constraintName == 'bookings_no_overlap';

  static Future<Booking> _householdBooking(
    Session session,
    Actor actor,
    int bookingId,
  ) async {
    final booking = await Booking.db.findById(session, bookingId);
    if (booking == null || booking.householdId != actor.householdId) {
      throw _simple(actor, BookingErrorCode.notFound);
    }
    return booking;
  }

  static Future<Booking> _ownBooking(
    Session session,
    Actor actor,
    int bookingId,
  ) async {
    final booking = await _householdBooking(session, actor, bookingId);
    if (booking.userId != actor.userId) {
      throw _simple(actor, BookingErrorCode.notAllowed);
    }
    return booking;
  }

  static void _requireNotStarted(Actor actor, Booking booking) {
    if (!active.contains(booking.status) ||
        !booking.startAt.isAfter(clock.now())) {
      throw _simple(
        actor,
        BookingErrorCode.invalidState,
        detail: actor.user.locale == 'en'
            ? 'Only upcoming bookings can be changed. Release a booking in use instead.'
            : 'แก้ไขหรือยกเลิกได้เฉพาะการจองที่ยังไม่เริ่ม ถ้ากำลังใช้งานอยู่ให้กดคืนห้องแทน',
      );
    }
  }

  static BookingException _simple(
    Actor actor,
    BookingErrorCode code, {
    String? detail,
  }) => BookingException(
    code: code,
    message: actor.messages.bookingError(code, detail: detail),
  );

  static Future<void> _notifyOwnersOfRequest(
    Session session,
    Actor actor,
    Room room,
    Booking booking,
  ) async {
    final owners = await Membership.ownerIds(session, actor.householdId);
    for (final ownerId in owners) {
      if (ownerId == actor.userId) continue;
      await Notifier.aboutBooking(
        session,
        userId: ownerId,
        type: NotificationType.approvalRequested,
        booking: booking,
        room: room,
        household: actor.household,
        extra: {'user': actor.user.displayName},
      );
    }
  }

  static DateTime _utc(DateTime t) => TimeZones.utc(t);
}
