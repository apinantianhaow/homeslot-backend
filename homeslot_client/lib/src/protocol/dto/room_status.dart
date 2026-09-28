/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:homeslot_client/src/protocol/protocol.dart' as _igrvdpfe;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../dto/booking_view.dart' as _idy42zuf;
import '../tables/room.dart' as _ike81btj;
import '../tables/room_closure.dart' as _iqxi85fb;

/// Current state of a room for the home screen (SRS 2.3.9).
abstract class RoomStatus
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RoomStatus._({
    required this.room,
    this.current,
    this.next,
    this.closure,
    required this.openNow,
  });

  factory RoomStatus({
    required _ike81btj.Room room,
    _idy42zuf.BookingView? current,
    _idy42zuf.BookingView? next,
    _iqxi85fb.RoomClosure? closure,
    required bool openNow,
  }) = _RoomStatusImpl;

  factory RoomStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomStatus(
      room: _igrvdpfe.Protocol().deserialize<_ike81btj.Room>(
        jsonSerialization['room'],
      ),
      current: jsonSerialization['current'] == null
          ? null
          : _igrvdpfe.Protocol().deserialize<_idy42zuf.BookingView>(
              jsonSerialization['current'],
            ),
      next: jsonSerialization['next'] == null
          ? null
          : _igrvdpfe.Protocol().deserialize<_idy42zuf.BookingView>(
              jsonSerialization['next'],
            ),
      closure: jsonSerialization['closure'] == null
          ? null
          : _igrvdpfe.Protocol().deserialize<_iqxi85fb.RoomClosure>(
              jsonSerialization['closure'],
            ),
      openNow: _isc.BoolJsonExtension.fromJson(jsonSerialization['openNow']),
    );
  }

  _ike81btj.Room room;

  _idy42zuf.BookingView? current;

  _idy42zuf.BookingView? next;

  _iqxi85fb.RoomClosure? closure;

  bool openNow;

  /// Returns a shallow copy of this [RoomStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RoomStatus copyWith({
    _ike81btj.Room? room,
    _idy42zuf.BookingView? current,
    _idy42zuf.BookingView? next,
    _iqxi85fb.RoomClosure? closure,
    bool? openNow,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomStatus',
      'room': room.toJson(),
      if (current != null) 'current': current?.toJson(),
      if (next != null) 'next': next?.toJson(),
      if (closure != null) 'closure': closure?.toJson(),
      'openNow': openNow,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomStatus',
      'room': room.toJsonForProtocol(),
      if (current != null) 'current': current?.toJsonForProtocol(),
      if (next != null) 'next': next?.toJsonForProtocol(),
      if (closure != null) 'closure': closure?.toJsonForProtocol(),
      'openNow': openNow,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomStatusImpl extends RoomStatus {
  _RoomStatusImpl({
    required _ike81btj.Room room,
    _idy42zuf.BookingView? current,
    _idy42zuf.BookingView? next,
    _iqxi85fb.RoomClosure? closure,
    required bool openNow,
  }) : super._(
         room: room,
         current: current,
         next: next,
         closure: closure,
         openNow: openNow,
       );

  /// Returns a shallow copy of this [RoomStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RoomStatus copyWith({
    _ike81btj.Room? room,
    Object? current = _Undefined,
    Object? next = _Undefined,
    Object? closure = _Undefined,
    bool? openNow,
  }) {
    return RoomStatus(
      room: room ?? this.room.copyWith(),
      current: current is _idy42zuf.BookingView?
          ? current
          : this.current?.copyWith(),
      next: next is _idy42zuf.BookingView? ? next : this.next?.copyWith(),
      closure: closure is _iqxi85fb.RoomClosure?
          ? closure
          : this.closure?.copyWith(),
      openNow: openNow ?? this.openNow,
    );
  }
}
