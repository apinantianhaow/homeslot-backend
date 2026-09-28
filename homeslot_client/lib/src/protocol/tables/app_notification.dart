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
import '../enums/notification_type.dart' as _izfnm04l;

/// In-app notification history (kept for 30 days).
abstract class AppNotification
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AppNotification._({
    this.id,
    required this.userId,
    this.householdId,
    required this.type,
    required this.title,
    required this.body,
    this.bookingId,
    this.readAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AppNotification({
    int? id,
    required int userId,
    int? householdId,
    required _izfnm04l.NotificationType type,
    required String title,
    required String body,
    int? bookingId,
    DateTime? readAt,
    DateTime? createdAt,
  }) = _AppNotificationImpl;

  factory AppNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppNotification(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      householdId: jsonSerialization['householdId'] as int?,
      type: _izfnm04l.NotificationType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      bookingId: jsonSerialization['bookingId'] as int?,
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int? householdId;

  _izfnm04l.NotificationType type;

  String title;

  String body;

  int? bookingId;

  DateTime? readAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [AppNotification]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AppNotification copyWith({
    int? id,
    int? userId,
    int? householdId,
    _izfnm04l.NotificationType? type,
    String? title,
    String? body,
    int? bookingId,
    DateTime? readAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppNotification',
      if (id != null) 'id': id,
      'userId': userId,
      if (householdId != null) 'householdId': householdId,
      'type': type.toJson(),
      'title': title,
      'body': body,
      if (bookingId != null) 'bookingId': bookingId,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppNotification',
      if (id != null) 'id': id,
      'userId': userId,
      if (householdId != null) 'householdId': householdId,
      'type': type.toJson(),
      'title': title,
      'body': body,
      if (bookingId != null) 'bookingId': bookingId,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppNotificationImpl extends AppNotification {
  _AppNotificationImpl({
    int? id,
    required int userId,
    int? householdId,
    required _izfnm04l.NotificationType type,
    required String title,
    required String body,
    int? bookingId,
    DateTime? readAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         householdId: householdId,
         type: type,
         title: title,
         body: body,
         bookingId: bookingId,
         readAt: readAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AppNotification]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AppNotification copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? householdId = _Undefined,
    _izfnm04l.NotificationType? type,
    String? title,
    String? body,
    Object? bookingId = _Undefined,
    Object? readAt = _Undefined,
    DateTime? createdAt,
  }) {
    return AppNotification(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      householdId: householdId is int? ? householdId : this.householdId,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      bookingId: bookingId is int? ? bookingId : this.bookingId,
      readAt: readAt is DateTime? ? readAt : this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
