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

/// Booked minutes on one local day.
abstract class DailyUsage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DailyUsage._({
    required this.date,
    required this.minutes,
  });

  factory DailyUsage({
    required DateTime date,
    required int minutes,
  }) = _DailyUsageImpl;

  factory DailyUsage.fromJson(Map<String, dynamic> jsonSerialization) {
    return DailyUsage(
      date: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      minutes: jsonSerialization['minutes'] as int,
    );
  }

  DateTime date;

  int minutes;

  /// Returns a shallow copy of this [DailyUsage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DailyUsage copyWith({
    DateTime? date,
    int? minutes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DailyUsage',
      'date': date.toJson(),
      'minutes': minutes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DailyUsage',
      'date': date.toJson(),
      'minutes': minutes,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DailyUsageImpl extends DailyUsage {
  _DailyUsageImpl({
    required DateTime date,
    required int minutes,
  }) : super._(
         date: date,
         minutes: minutes,
       );

  /// Returns a shallow copy of this [DailyUsage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DailyUsage copyWith({
    DateTime? date,
    int? minutes,
  }) {
    return DailyUsage(
      date: date ?? this.date,
      minutes: minutes ?? this.minutes,
    );
  }
}
