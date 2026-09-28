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
import '../enums/booking_status.dart' as _idgk5z95;

/// A booking of one room by one user. Core table of the system.
///
/// Overlaps are prevented in the database by the `bookings_no_overlap`
/// exclusion constraint (see `lib/src/db/constraints.dart`).
abstract class Booking
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Booking._({
    this.id,
    required this.householdId,
    required this.roomId,
    required this.userId,
    this.seriesId,
    required this.startAt,
    required this.endAt,
    required this.status,
    this.purpose,
    this.note,
    this.decidedById,
    this.rejectReason,
    this.cancelledById,
    this.cancelReason,
    this.releasedAt,
    this.reminderSentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Booking({
    int? id,
    required int householdId,
    required int roomId,
    required int userId,
    int? seriesId,
    required DateTime startAt,
    required DateTime endAt,
    required _idgk5z95.BookingStatus status,
    String? purpose,
    String? note,
    int? decidedById,
    String? rejectReason,
    int? cancelledById,
    String? cancelReason,
    DateTime? releasedAt,
    DateTime? reminderSentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _BookingImpl;

  factory Booking.fromJson(Map<String, dynamic> jsonSerialization) {
    return Booking(
      id: jsonSerialization['id'] as int?,
      householdId: jsonSerialization['householdId'] as int,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as int,
      seriesId: jsonSerialization['seriesId'] as int?,
      startAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startAt'],
      ),
      endAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endAt']),
      status: _idgk5z95.BookingStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      purpose: jsonSerialization['purpose'] as String?,
      note: jsonSerialization['note'] as String?,
      decidedById: jsonSerialization['decidedById'] as int?,
      rejectReason: jsonSerialization['rejectReason'] as String?,
      cancelledById: jsonSerialization['cancelledById'] as int?,
      cancelReason: jsonSerialization['cancelReason'] as String?,
      releasedAt: jsonSerialization['releasedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['releasedAt'],
            ),
      reminderSentAt: jsonSerialization['reminderSentAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['reminderSentAt'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int householdId;

  int roomId;

  int userId;

  int? seriesId;

  DateTime startAt;

  /// Changed to the release time when the room is released early.
  DateTime endAt;

  _idgk5z95.BookingStatus status;

  String? purpose;

  String? note;

  /// Owner who approved or rejected the request.
  int? decidedById;

  String? rejectReason;

  /// Who cancelled the booking, when it was not the booker.
  int? cancelledById;

  String? cancelReason;

  DateTime? releasedAt;

  DateTime? reminderSentAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Booking copyWith({
    int? id,
    int? householdId,
    int? roomId,
    int? userId,
    int? seriesId,
    DateTime? startAt,
    DateTime? endAt,
    _idgk5z95.BookingStatus? status,
    String? purpose,
    String? note,
    int? decidedById,
    String? rejectReason,
    int? cancelledById,
    String? cancelReason,
    DateTime? releasedAt,
    DateTime? reminderSentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Booking',
      if (id != null) 'id': id,
      'householdId': householdId,
      'roomId': roomId,
      'userId': userId,
      if (seriesId != null) 'seriesId': seriesId,
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      'status': status.toJson(),
      if (purpose != null) 'purpose': purpose,
      if (note != null) 'note': note,
      if (decidedById != null) 'decidedById': decidedById,
      if (rejectReason != null) 'rejectReason': rejectReason,
      if (cancelledById != null) 'cancelledById': cancelledById,
      if (cancelReason != null) 'cancelReason': cancelReason,
      if (releasedAt != null) 'releasedAt': releasedAt?.toJson(),
      if (reminderSentAt != null) 'reminderSentAt': reminderSentAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Booking',
      if (id != null) 'id': id,
      'householdId': householdId,
      'roomId': roomId,
      'userId': userId,
      if (seriesId != null) 'seriesId': seriesId,
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      'status': status.toJson(),
      if (purpose != null) 'purpose': purpose,
      if (note != null) 'note': note,
      if (decidedById != null) 'decidedById': decidedById,
      if (rejectReason != null) 'rejectReason': rejectReason,
      if (cancelledById != null) 'cancelledById': cancelledById,
      if (cancelReason != null) 'cancelReason': cancelReason,
      if (releasedAt != null) 'releasedAt': releasedAt?.toJson(),
      if (reminderSentAt != null) 'reminderSentAt': reminderSentAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingImpl extends Booking {
  _BookingImpl({
    int? id,
    required int householdId,
    required int roomId,
    required int userId,
    int? seriesId,
    required DateTime startAt,
    required DateTime endAt,
    required _idgk5z95.BookingStatus status,
    String? purpose,
    String? note,
    int? decidedById,
    String? rejectReason,
    int? cancelledById,
    String? cancelReason,
    DateTime? releasedAt,
    DateTime? reminderSentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         householdId: householdId,
         roomId: roomId,
         userId: userId,
         seriesId: seriesId,
         startAt: startAt,
         endAt: endAt,
         status: status,
         purpose: purpose,
         note: note,
         decidedById: decidedById,
         rejectReason: rejectReason,
         cancelledById: cancelledById,
         cancelReason: cancelReason,
         releasedAt: releasedAt,
         reminderSentAt: reminderSentAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Booking copyWith({
    Object? id = _Undefined,
    int? householdId,
    int? roomId,
    int? userId,
    Object? seriesId = _Undefined,
    DateTime? startAt,
    DateTime? endAt,
    _idgk5z95.BookingStatus? status,
    Object? purpose = _Undefined,
    Object? note = _Undefined,
    Object? decidedById = _Undefined,
    Object? rejectReason = _Undefined,
    Object? cancelledById = _Undefined,
    Object? cancelReason = _Undefined,
    Object? releasedAt = _Undefined,
    Object? reminderSentAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Booking(
      id: id is int? ? id : this.id,
      householdId: householdId ?? this.householdId,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      seriesId: seriesId is int? ? seriesId : this.seriesId,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      status: status ?? this.status,
      purpose: purpose is String? ? purpose : this.purpose,
      note: note is String? ? note : this.note,
      decidedById: decidedById is int? ? decidedById : this.decidedById,
      rejectReason: rejectReason is String? ? rejectReason : this.rejectReason,
      cancelledById: cancelledById is int? ? cancelledById : this.cancelledById,
      cancelReason: cancelReason is String? ? cancelReason : this.cancelReason,
      releasedAt: releasedAt is DateTime? ? releasedAt : this.releasedAt,
      reminderSentAt: reminderSentAt is DateTime?
          ? reminderSentAt
          : this.reminderSentAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
