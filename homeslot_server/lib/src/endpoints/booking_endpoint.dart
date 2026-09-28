import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/booking_service.dart';
import '../services/membership.dart';

/// Calendar, booking and approval (SRS 2.3, 2.4).
class BookingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Bookings in the household (or one room) overlapping [from, to).
  Future<List<BookingView>> list(
    Session session,
    DateTime from,
    DateTime to,
    int? roomId,
  ) async => BookingService.list(
    session,
    await Membership.requireMember(session),
    from: from.toUtc(),
    to: to.toUtc(),
    roomId: roomId,
  );

  Future<BookingView> create(Session session, BookingRequest request) async =>
      BookingService.create(
        session,
        await Membership.requireMember(session),
        request,
      );

  /// Free slots near the requested time, same length.
  Future<List<TimeSlot>> suggest(
    Session session,
    int roomId,
    DateTime startAt,
    DateTime endAt,
  ) async => BookingService.suggest(
    session,
    await Membership.requireMember(session),
    roomId: roomId,
    startAt: startAt,
    endAt: endAt,
  );

  Future<List<SeriesOccurrence>> previewSeries(
    Session session,
    SeriesRequest request,
  ) async => BookingService.previewSeries(
    session,
    await Membership.requireMember(session),
    request,
  );

  Future<List<BookingView>> createSeries(
    Session session,
    SeriesRequest request,
  ) async => BookingService.createSeries(
    session,
    await Membership.requireMember(session),
    request,
  );

  Future<List<BookingView>> update(
    Session session,
    int bookingId,
    DateTime startAt,
    DateTime endAt,
    String? purpose,
    String? note,
    EditScope scope,
  ) async => BookingService.update(
    session,
    await Membership.requireMember(session),
    bookingId: bookingId,
    startAt: startAt,
    endAt: endAt,
    purpose: purpose,
    note: note,
    scope: scope,
  );

  /// Returns how many bookings were cancelled.
  Future<int> cancel(
    Session session,
    int bookingId,
    EditScope scope,
    String? reason,
  ) async => BookingService.cancel(
    session,
    await Membership.requireMember(session),
    bookingId: bookingId,
    scope: scope,
    reason: reason,
  );

  Future<BookingView> release(Session session, int bookingId) async =>
      BookingService.release(
        session,
        await Membership.requireMember(session),
        bookingId,
      );

  Future<List<BookingView>> mine(
    Session session,
    bool upcoming,
    int limit,
    int offset,
  ) async => BookingService.mine(
    session,
    await Membership.requireMember(session),
    upcoming: upcoming,
    limit: limit,
    offset: offset,
  );

  Future<List<BookingView>> pending(Session session) async =>
      BookingService.pendingApprovals(
        session,
        await Membership.requireOwner(session),
      );

  Future<List<BookingView>> approve(
    Session session,
    int bookingId,
    EditScope scope,
  ) async => BookingService.decide(
    session,
    await Membership.requireOwner(session),
    bookingId: bookingId,
    approve: true,
    scope: scope,
  );

  Future<List<BookingView>> reject(
    Session session,
    int bookingId,
    String? reason,
    EditScope scope,
  ) async => BookingService.decide(
    session,
    await Membership.requireOwner(session),
    bookingId: bookingId,
    approve: false,
    reason: reason,
    scope: scope,
  );
}
