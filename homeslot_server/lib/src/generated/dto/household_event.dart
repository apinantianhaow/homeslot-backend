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
import 'package:serverpod/serverpod.dart' as _is;
import '../enums/household_event_type.dart' as _idhlbht8;

/// Real-time event streamed to clients so calendars refresh without reload.
abstract class HouseholdEvent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  HouseholdEvent._({
    required this.type,
    this.roomId,
    this.bookingId,
    required this.at,
  });

  factory HouseholdEvent({
    required _idhlbht8.HouseholdEventType type,
    int? roomId,
    int? bookingId,
    required DateTime at,
  }) = _HouseholdEventImpl;

  factory HouseholdEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return HouseholdEvent(
      type: _idhlbht8.HouseholdEventType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      roomId: jsonSerialization['roomId'] as int?,
      bookingId: jsonSerialization['bookingId'] as int?,
      at: _is.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  _idhlbht8.HouseholdEventType type;

  int? roomId;

  int? bookingId;

  DateTime at;

  /// Returns a shallow copy of this [HouseholdEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  HouseholdEvent copyWith({
    _idhlbht8.HouseholdEventType? type,
    int? roomId,
    int? bookingId,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'HouseholdEvent',
      'type': type.toJson(),
      if (roomId != null) 'roomId': roomId,
      if (bookingId != null) 'bookingId': bookingId,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'HouseholdEvent',
      'type': type.toJson(),
      if (roomId != null) 'roomId': roomId,
      if (bookingId != null) 'bookingId': bookingId,
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HouseholdEventImpl extends HouseholdEvent {
  _HouseholdEventImpl({
    required _idhlbht8.HouseholdEventType type,
    int? roomId,
    int? bookingId,
    required DateTime at,
  }) : super._(
         type: type,
         roomId: roomId,
         bookingId: bookingId,
         at: at,
       );

  /// Returns a shallow copy of this [HouseholdEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  HouseholdEvent copyWith({
    _idhlbht8.HouseholdEventType? type,
    Object? roomId = _Undefined,
    Object? bookingId = _Undefined,
    DateTime? at,
  }) {
    return HouseholdEvent(
      type: type ?? this.type,
      roomId: roomId is int? ? roomId : this.roomId,
      bookingId: bookingId is int? ? bookingId : this.bookingId,
      at: at ?? this.at,
    );
  }
}
