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

/// When rooms are used the most (SRS 2.6.3).
abstract class PeakHours
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PeakHours._({
    this.roomId,
    required this.from,
    required this.to,
    required this.hourly,
    required this.heatmap,
  });

  factory PeakHours({
    int? roomId,
    required DateTime from,
    required DateTime to,
    required List<int> hourly,
    required List<int> heatmap,
  }) = _PeakHoursImpl;

  factory PeakHours.fromJson(Map<String, dynamic> jsonSerialization) {
    return PeakHours(
      roomId: jsonSerialization['roomId'] as int?,
      from: _is.DateTimeJsonExtension.fromJson(jsonSerialization['from']),
      to: _is.DateTimeJsonExtension.fromJson(jsonSerialization['to']),
      hourly: _ig62mdor.Protocol().deserialize<List<int>>(
        jsonSerialization['hourly'],
      ),
      heatmap: _ig62mdor.Protocol().deserialize<List<int>>(
        jsonSerialization['heatmap'],
      ),
    );
  }

  int? roomId;

  DateTime from;

  DateTime to;

  /// 24 values: booked minutes per local hour of day.
  List<int> hourly;

  /// 7 x 24 values (Monday first): booked minutes per weekday and hour.
  List<int> heatmap;

  /// Returns a shallow copy of this [PeakHours]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PeakHours copyWith({
    int? roomId,
    DateTime? from,
    DateTime? to,
    List<int>? hourly,
    List<int>? heatmap,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PeakHours',
      if (roomId != null) 'roomId': roomId,
      'from': from.toJson(),
      'to': to.toJson(),
      'hourly': hourly.toJson(),
      'heatmap': heatmap.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PeakHours',
      if (roomId != null) 'roomId': roomId,
      'from': from.toJson(),
      'to': to.toJson(),
      'hourly': hourly.toJson(),
      'heatmap': heatmap.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PeakHoursImpl extends PeakHours {
  _PeakHoursImpl({
    int? roomId,
    required DateTime from,
    required DateTime to,
    required List<int> hourly,
    required List<int> heatmap,
  }) : super._(
         roomId: roomId,
         from: from,
         to: to,
         hourly: hourly,
         heatmap: heatmap,
       );

  /// Returns a shallow copy of this [PeakHours]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PeakHours copyWith({
    Object? roomId = _Undefined,
    DateTime? from,
    DateTime? to,
    List<int>? hourly,
    List<int>? heatmap,
  }) {
    return PeakHours(
      roomId: roomId is int? ? roomId : this.roomId,
      from: from ?? this.from,
      to: to ?? this.to,
      hourly: hourly ?? this.hourly.map((e0) => e0).toList(),
      heatmap: heatmap ?? this.heatmap.map((e0) => e0).toList(),
    );
  }
}
