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

/// A temporary closure of a room, e.g. while the air conditioner is repaired.
abstract class RoomClosure
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RoomClosure._({
    this.id,
    required this.roomId,
    required this.startAt,
    required this.endAt,
    required this.reason,
    required this.createdById,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory RoomClosure({
    int? id,
    required int roomId,
    required DateTime startAt,
    required DateTime endAt,
    required String reason,
    required int createdById,
    DateTime? createdAt,
  }) = _RoomClosureImpl;

  factory RoomClosure.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomClosure(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      startAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startAt'],
      ),
      endAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endAt']),
      reason: jsonSerialization['reason'] as String,
      createdById: jsonSerialization['createdById'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  DateTime startAt;

  DateTime endAt;

  String reason;

  int createdById;

  DateTime createdAt;

  /// Returns a shallow copy of this [RoomClosure]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RoomClosure copyWith({
    int? id,
    int? roomId,
    DateTime? startAt,
    DateTime? endAt,
    String? reason,
    int? createdById,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomClosure',
      if (id != null) 'id': id,
      'roomId': roomId,
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      'reason': reason,
      'createdById': createdById,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomClosure',
      if (id != null) 'id': id,
      'roomId': roomId,
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      'reason': reason,
      'createdById': createdById,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomClosureImpl extends RoomClosure {
  _RoomClosureImpl({
    int? id,
    required int roomId,
    required DateTime startAt,
    required DateTime endAt,
    required String reason,
    required int createdById,
    DateTime? createdAt,
  }) : super._(
         id: id,
         roomId: roomId,
         startAt: startAt,
         endAt: endAt,
         reason: reason,
         createdById: createdById,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RoomClosure]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RoomClosure copyWith({
    Object? id = _Undefined,
    int? roomId,
    DateTime? startAt,
    DateTime? endAt,
    String? reason,
    int? createdById,
    DateTime? createdAt,
  }) {
    return RoomClosure(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      reason: reason ?? this.reason,
      createdById: createdById ?? this.createdById,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
