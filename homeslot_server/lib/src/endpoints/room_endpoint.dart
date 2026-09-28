import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/membership.dart';
import '../services/room_service.dart';

/// Rooms, opening hours, booking rules and closures (SRS 2.2).
class RoomEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<RoomDetail>> list(Session session) async =>
      RoomService.list(session, await Membership.requireMember(session));

  Future<RoomDetail> get(Session session, int roomId) async =>
      RoomService.get(session, await Membership.requireMember(session), roomId);

  Future<List<RoomStatus>> statusNow(Session session) async =>
      RoomService.statusNow(session, await Membership.requireMember(session));

  Future<RoomDetail> create(
    Session session,
    Room room,
    List<RoomHours> hours,
  ) async => RoomService.create(
    session,
    await Membership.requireOwner(session),
    room,
    hours,
  );

  Future<RoomDetail> update(
    Session session,
    Room room,
    List<RoomHours> hours,
  ) async => RoomService.update(
    session,
    await Membership.requireOwner(session),
    room,
    hours,
  );

  Future<void> delete(Session session, int roomId) async => RoomService.delete(
    session,
    await Membership.requireOwner(session),
    roomId,
  );

  Future<RoomClosure> close(
    Session session,
    int roomId,
    DateTime startAt,
    DateTime endAt,
    String reason,
  ) async => RoomService.close(
    session,
    await Membership.requireOwner(session),
    roomId: roomId,
    startAt: startAt,
    endAt: endAt,
    reason: reason,
  );

  Future<void> removeClosure(Session session, int closureId) async =>
      RoomService.removeClosure(
        session,
        await Membership.requireOwner(session),
        closureId,
      );
}
