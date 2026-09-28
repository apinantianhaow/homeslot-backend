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

/// Input for creating a single booking.
abstract class BookingRequest
    implements _is.SerializableModel, _is.ProtocolSerialization {
  BookingRequest._({
    required this.roomId,
    required this.startAt,
    required this.endAt,
    this.purpose,
    this.note,
  });

  factory BookingRequest({
    required int roomId,
    required DateTime startAt,
    required DateTime endAt,
    String? purpose,
    String? note,
  }) = _BookingRequestImpl;

  factory BookingRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookingRequest(
      roomId: jsonSerialization['roomId'] as int,
      startAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['startAt']),
      endAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['endAt']),
      purpose: jsonSerialization['purpose'] as String?,
      note: jsonSerialization['note'] as String?,
    );
  }

  int roomId;

  DateTime startAt;

  DateTime endAt;

  String? purpose;

  String? note;

  /// Returns a shallow copy of this [BookingRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookingRequest copyWith({
    int? roomId,
    DateTime? startAt,
    DateTime? endAt,
    String? purpose,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookingRequest',
      'roomId': roomId,
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      if (purpose != null) 'purpose': purpose,
      if (note != null) 'note': note,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookingRequest',
      'roomId': roomId,
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      if (purpose != null) 'purpose': purpose,
      if (note != null) 'note': note,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingRequestImpl extends BookingRequest {
  _BookingRequestImpl({
    required int roomId,
    required DateTime startAt,
    required DateTime endAt,
    String? purpose,
    String? note,
  }) : super._(
         roomId: roomId,
         startAt: startAt,
         endAt: endAt,
         purpose: purpose,
         note: note,
       );

  /// Returns a shallow copy of this [BookingRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookingRequest copyWith({
    int? roomId,
    DateTime? startAt,
    DateTime? endAt,
    Object? purpose = _Undefined,
    Object? note = _Undefined,
  }) {
    return BookingRequest(
      roomId: roomId ?? this.roomId,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      purpose: purpose is String? ? purpose : this.purpose,
      note: note is String? ? note : this.note,
    );
  }
}
