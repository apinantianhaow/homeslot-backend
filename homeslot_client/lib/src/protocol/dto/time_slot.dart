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

/// A free time range suggested to the user.
abstract class TimeSlot
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TimeSlot._({
    required this.startAt,
    required this.endAt,
  });

  factory TimeSlot({
    required DateTime startAt,
    required DateTime endAt,
  }) = _TimeSlotImpl;

  factory TimeSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimeSlot(
      startAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startAt'],
      ),
      endAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endAt']),
    );
  }

  DateTime startAt;

  DateTime endAt;

  /// Returns a shallow copy of this [TimeSlot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TimeSlot copyWith({
    DateTime? startAt,
    DateTime? endAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TimeSlot',
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TimeSlot',
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _TimeSlotImpl extends TimeSlot {
  _TimeSlotImpl({
    required DateTime startAt,
    required DateTime endAt,
  }) : super._(
         startAt: startAt,
         endAt: endAt,
       );

  /// Returns a shallow copy of this [TimeSlot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TimeSlot copyWith({
    DateTime? startAt,
    DateTime? endAt,
  }) {
    return TimeSlot(
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
    );
  }
}
