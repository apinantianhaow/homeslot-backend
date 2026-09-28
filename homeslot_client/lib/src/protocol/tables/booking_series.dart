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

/// A weekly recurring booking (up to 12 weeks).
abstract class BookingSeries
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BookingSeries._({
    this.id,
    required this.roomId,
    required this.userId,
    required this.weekday,
    required this.startMinute,
    required this.endMinute,
    required this.weeks,
    required this.untilDate,
    this.purpose,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory BookingSeries({
    int? id,
    required int roomId,
    required int userId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    required int weeks,
    required DateTime untilDate,
    String? purpose,
    DateTime? createdAt,
  }) = _BookingSeriesImpl;

  factory BookingSeries.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookingSeries(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as int,
      weekday: jsonSerialization['weekday'] as int,
      startMinute: jsonSerialization['startMinute'] as int,
      endMinute: jsonSerialization['endMinute'] as int,
      weeks: jsonSerialization['weeks'] as int,
      untilDate: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['untilDate'],
      ),
      purpose: jsonSerialization['purpose'] as String?,
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

  int userId;

  /// 1 = Monday ... 7 = Sunday, in the household time zone.
  int weekday;

  /// Local start, minutes after midnight.
  int startMinute;

  /// Local end, minutes after midnight of the start day (may exceed 1440).
  int endMinute;

  int weeks;

  /// Start of the last occurrence.
  DateTime untilDate;

  String? purpose;

  DateTime createdAt;

  /// Returns a shallow copy of this [BookingSeries]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BookingSeries copyWith({
    int? id,
    int? roomId,
    int? userId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    int? weeks,
    DateTime? untilDate,
    String? purpose,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookingSeries',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'weeks': weeks,
      'untilDate': untilDate.toJson(),
      if (purpose != null) 'purpose': purpose,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookingSeries',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'weeks': weeks,
      'untilDate': untilDate.toJson(),
      if (purpose != null) 'purpose': purpose,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingSeriesImpl extends BookingSeries {
  _BookingSeriesImpl({
    int? id,
    required int roomId,
    required int userId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    required int weeks,
    required DateTime untilDate,
    String? purpose,
    DateTime? createdAt,
  }) : super._(
         id: id,
         roomId: roomId,
         userId: userId,
         weekday: weekday,
         startMinute: startMinute,
         endMinute: endMinute,
         weeks: weeks,
         untilDate: untilDate,
         purpose: purpose,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [BookingSeries]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BookingSeries copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? userId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    int? weeks,
    DateTime? untilDate,
    Object? purpose = _Undefined,
    DateTime? createdAt,
  }) {
    return BookingSeries(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      weekday: weekday ?? this.weekday,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      weeks: weeks ?? this.weeks,
      untilDate: untilDate ?? this.untilDate,
      purpose: purpose is String? ? purpose : this.purpose,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
