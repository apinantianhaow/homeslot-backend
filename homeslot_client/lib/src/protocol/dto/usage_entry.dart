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

/// Booked minutes for one room or member.
abstract class UsageEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UsageEntry._({
    required this.id,
    required this.label,
    this.color,
    required this.minutes,
    required this.bookings,
  });

  factory UsageEntry({
    required int id,
    required String label,
    String? color,
    required int minutes,
    required int bookings,
  }) = _UsageEntryImpl;

  factory UsageEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return UsageEntry(
      id: jsonSerialization['id'] as int,
      label: jsonSerialization['label'] as String,
      color: jsonSerialization['color'] as String?,
      minutes: jsonSerialization['minutes'] as int,
      bookings: jsonSerialization['bookings'] as int,
    );
  }

  int id;

  String label;

  String? color;

  int minutes;

  int bookings;

  /// Returns a shallow copy of this [UsageEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UsageEntry copyWith({
    int? id,
    String? label,
    String? color,
    int? minutes,
    int? bookings,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UsageEntry',
      'id': id,
      'label': label,
      if (color != null) 'color': color,
      'minutes': minutes,
      'bookings': bookings,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UsageEntry',
      'id': id,
      'label': label,
      if (color != null) 'color': color,
      'minutes': minutes,
      'bookings': bookings,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UsageEntryImpl extends UsageEntry {
  _UsageEntryImpl({
    required int id,
    required String label,
    String? color,
    required int minutes,
    required int bookings,
  }) : super._(
         id: id,
         label: label,
         color: color,
         minutes: minutes,
         bookings: bookings,
       );

  /// Returns a shallow copy of this [UsageEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UsageEntry copyWith({
    int? id,
    String? label,
    Object? color = _Undefined,
    int? minutes,
    int? bookings,
  }) {
    return UsageEntry(
      id: id ?? this.id,
      label: label ?? this.label,
      color: color is String? ? color : this.color,
      minutes: minutes ?? this.minutes,
      bookings: bookings ?? this.bookings,
    );
  }
}
