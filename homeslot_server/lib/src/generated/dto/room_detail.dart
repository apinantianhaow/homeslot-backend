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
import 'package:homeslot_server/src/generated/protocol.dart' as _ig62mdor;
import 'package:serverpod/serverpod.dart' as _is;
import '../tables/room.dart' as _ike81btj;
import '../tables/room_closure.dart' as _iqxi85fb;
import '../tables/room_hours.dart' as _innr6gla;

/// A room with its opening hours and upcoming closures.
abstract class RoomDetail
    implements _is.SerializableModel, _is.ProtocolSerialization {
  RoomDetail._({
    required this.room,
    required this.hours,
    required this.closures,
  });

  factory RoomDetail({
    required _ike81btj.Room room,
    required List<_innr6gla.RoomHours> hours,
    required List<_iqxi85fb.RoomClosure> closures,
  }) = _RoomDetailImpl;

  factory RoomDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomDetail(
      room: _ig62mdor.Protocol().deserialize<_ike81btj.Room>(
        jsonSerialization['room'],
      ),
      hours: _ig62mdor.Protocol().deserialize<List<_innr6gla.RoomHours>>(
        jsonSerialization['hours'],
      ),
      closures: _ig62mdor.Protocol().deserialize<List<_iqxi85fb.RoomClosure>>(
        jsonSerialization['closures'],
      ),
    );
  }

  _ike81btj.Room room;

  List<_innr6gla.RoomHours> hours;

  List<_iqxi85fb.RoomClosure> closures;

  /// Returns a shallow copy of this [RoomDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RoomDetail copyWith({
    _ike81btj.Room? room,
    List<_innr6gla.RoomHours>? hours,
    List<_iqxi85fb.RoomClosure>? closures,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomDetail',
      'room': room.toJson(),
      'hours': hours.toJson(valueToJson: (v) => v.toJson()),
      'closures': closures.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomDetail',
      'room': room.toJsonForProtocol(),
      'hours': hours.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'closures': closures.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _RoomDetailImpl extends RoomDetail {
  _RoomDetailImpl({
    required _ike81btj.Room room,
    required List<_innr6gla.RoomHours> hours,
    required List<_iqxi85fb.RoomClosure> closures,
  }) : super._(
         room: room,
         hours: hours,
         closures: closures,
       );

  /// Returns a shallow copy of this [RoomDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RoomDetail copyWith({
    _ike81btj.Room? room,
    List<_innr6gla.RoomHours>? hours,
    List<_iqxi85fb.RoomClosure>? closures,
  }) {
    return RoomDetail(
      room: room ?? this.room.copyWith(),
      hours: hours ?? this.hours.map((e0) => e0.copyWith()).toList(),
      closures: closures ?? this.closures.map((e0) => e0.copyWith()).toList(),
    );
  }
}
