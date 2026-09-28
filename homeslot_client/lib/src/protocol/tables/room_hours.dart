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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// Opening hours of a room for one weekday. A weekday without a row is closed.
abstract class RoomHours
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RoomHours._({
    this.id,
    this.roomId,
    required this.weekday,
    required this.openMinute,
    required this.closeMinute,
  });

  factory RoomHours({
    int? id,
    int? roomId,
    required int weekday,
    required int openMinute,
    required int closeMinute,
  }) = _RoomHoursImpl;

  factory RoomHours.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomHours(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int?,
      weekday: jsonSerialization['weekday'] as int,
      openMinute: jsonSerialization['openMinute'] as int,
      closeMinute: jsonSerialization['closeMinute'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? roomId;

  /// 1 = Monday ... 7 = Sunday (same as `DateTime.weekday`).
  int weekday;

  /// Minutes after local midnight, 0-1439.
  int openMinute;

  /// Minutes after local midnight, 1-1440 (1440 = end of day).
  int closeMinute;

  /// Returns a shallow copy of this [RoomHours]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RoomHours copyWith({
    int? id,
    int? roomId,
    int? weekday,
    int? openMinute,
    int? closeMinute,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomHours',
      if (id != null) 'id': id,
      if (roomId != null) 'roomId': roomId,
      'weekday': weekday,
      'openMinute': openMinute,
      'closeMinute': closeMinute,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomHours',
      if (id != null) 'id': id,
      if (roomId != null) 'roomId': roomId,
      'weekday': weekday,
      'openMinute': openMinute,
      'closeMinute': closeMinute,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomHoursImpl extends RoomHours {
  _RoomHoursImpl({
    int? id,
    int? roomId,
    required int weekday,
    required int openMinute,
    required int closeMinute,
  }) : super._(
         id: id,
         roomId: roomId,
         weekday: weekday,
         openMinute: openMinute,
         closeMinute: closeMinute,
       );

  /// Returns a shallow copy of this [RoomHours]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RoomHours copyWith({
    Object? id = _Undefined,
    Object? roomId = _Undefined,
    int? weekday,
    int? openMinute,
    int? closeMinute,
  }) {
    return RoomHours(
      id: id is int? ? id : this.id,
      roomId: roomId is int? ? roomId : this.roomId,
      weekday: weekday ?? this.weekday,
      openMinute: openMinute ?? this.openMinute,
      closeMinute: closeMinute ?? this.closeMinute,
    );
  }
}
