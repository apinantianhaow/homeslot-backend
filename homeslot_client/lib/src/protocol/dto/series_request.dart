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

/// Input for a weekly recurring booking. [startAt]/[endAt] is the first
/// occurrence; [skipStarts] lists occurrence starts the user chose to skip.
abstract class SeriesRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SeriesRequest._({
    required this.roomId,
    required this.startAt,
    required this.endAt,
    required this.weeks,
    this.purpose,
    this.note,
    required this.skipStarts,
  });

  factory SeriesRequest({
    required int roomId,
    required DateTime startAt,
    required DateTime endAt,
    required int weeks,
    String? purpose,
    String? note,
    required List<DateTime> skipStarts,
  }) = _SeriesRequestImpl;

  factory SeriesRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return SeriesRequest(
      roomId: jsonSerialization['roomId'] as int,
      startAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startAt'],
      ),
      endAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endAt']),
      weeks: jsonSerialization['weeks'] as int,
      purpose: jsonSerialization['purpose'] as String?,
      note: jsonSerialization['note'] as String?,
      skipStarts: _igrvdpfe.Protocol().deserialize<List<DateTime>>(
        jsonSerialization['skipStarts'],
      ),
    );
  }

  int roomId;

  DateTime startAt;

  DateTime endAt;

  int weeks;

  String? purpose;

  String? note;

  List<DateTime> skipStarts;

  /// Returns a shallow copy of this [SeriesRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SeriesRequest copyWith({
    int? roomId,
    DateTime? startAt,
    DateTime? endAt,
    int? weeks,
    String? purpose,
    String? note,
    List<DateTime>? skipStarts,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SeriesRequest',
      'roomId': roomId,
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      'weeks': weeks,
      if (purpose != null) 'purpose': purpose,
      if (note != null) 'note': note,
      'skipStarts': skipStarts.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SeriesRequest',
      'roomId': roomId,
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      'weeks': weeks,
      if (purpose != null) 'purpose': purpose,
      if (note != null) 'note': note,
      'skipStarts': skipStarts.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SeriesRequestImpl extends SeriesRequest {
  _SeriesRequestImpl({
    required int roomId,
    required DateTime startAt,
    required DateTime endAt,
    required int weeks,
    String? purpose,
    String? note,
    required List<DateTime> skipStarts,
  }) : super._(
         roomId: roomId,
         startAt: startAt,
         endAt: endAt,
         weeks: weeks,
         purpose: purpose,
         note: note,
         skipStarts: skipStarts,
       );

  /// Returns a shallow copy of this [SeriesRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SeriesRequest copyWith({
    int? roomId,
    DateTime? startAt,
    DateTime? endAt,
    int? weeks,
    Object? purpose = _Undefined,
    Object? note = _Undefined,
    List<DateTime>? skipStarts,
  }) {
    return SeriesRequest(
      roomId: roomId ?? this.roomId,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      weeks: weeks ?? this.weeks,
      purpose: purpose is String? ? purpose : this.purpose,
      note: note is String? ? note : this.note,
      skipStarts: skipStarts ?? this.skipStarts.map((e0) => e0).toList(),
    );
  }
}
