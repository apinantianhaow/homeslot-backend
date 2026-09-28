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

/// Application-level user profile (table `users` in the SRS ER diagram).
///
/// Linked 1:1 to the Serverpod auth user. When a user deletes their account
/// (PDPA), personal data is erased and [deletedAt] is set, but the row is kept
/// so booking history can still show "former member".
abstract class AppUser
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AppUser._({
    this.id,
    this.authUserId,
    this.email,
    required this.displayName,
    required this.color,
    this.avatarUrl,
    int? reminderMinutes,
    bool? reminderEnabled,
    String? locale,
    this.deletedAt,
    DateTime? createdAt,
  }) : reminderMinutes = reminderMinutes ?? 15,
       reminderEnabled = reminderEnabled ?? true,
       locale = locale ?? 'th',
       createdAt = createdAt ?? DateTime.now();

  factory AppUser({
    int? id,
    _isc.UuidValue? authUserId,
    String? email,
    required String displayName,
    required String color,
    String? avatarUrl,
    int? reminderMinutes,
    bool? reminderEnabled,
    String? locale,
    DateTime? deletedAt,
    DateTime? createdAt,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['authUserId'],
            ),
      email: jsonSerialization['email'] as String?,
      displayName: jsonSerialization['displayName'] as String,
      color: jsonSerialization['color'] as String,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      reminderMinutes: jsonSerialization['reminderMinutes'] as int?,
      reminderEnabled: jsonSerialization['reminderEnabled'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['reminderEnabled'],
            ),
      locale: jsonSerialization['locale'] as String?,
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// The Serverpod auth user this profile belongs to. Null once deleted.
  _isc.UuidValue? authUserId;

  String? email;

  String displayName;

  /// Personal calendar color as `#RRGGBB`.
  String color;

  String? avatarUrl;

  /// Minutes before a booking starts to send the reminder (5-60).
  int reminderMinutes;

  bool reminderEnabled;

  /// Preferred language for push notification text (`th` or `en`).
  String locale;

  DateTime? deletedAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AppUser copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? email,
    String? displayName,
    String? color,
    String? avatarUrl,
    int? reminderMinutes,
    bool? reminderEnabled,
    String? locale,
    DateTime? deletedAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (email != null) 'email': email,
      'displayName': displayName,
      'color': color,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'reminderMinutes': reminderMinutes,
      'reminderEnabled': reminderEnabled,
      'locale': locale,
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (email != null) 'email': email,
      'displayName': displayName,
      'color': color,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'reminderMinutes': reminderMinutes,
      'reminderEnabled': reminderEnabled,
      'locale': locale,
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    int? id,
    _isc.UuidValue? authUserId,
    String? email,
    required String displayName,
    required String color,
    String? avatarUrl,
    int? reminderMinutes,
    bool? reminderEnabled,
    String? locale,
    DateTime? deletedAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         email: email,
         displayName: displayName,
         color: color,
         avatarUrl: avatarUrl,
         reminderMinutes: reminderMinutes,
         reminderEnabled: reminderEnabled,
         locale: locale,
         deletedAt: deletedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AppUser copyWith({
    Object? id = _Undefined,
    Object? authUserId = _Undefined,
    Object? email = _Undefined,
    String? displayName,
    String? color,
    Object? avatarUrl = _Undefined,
    int? reminderMinutes,
    bool? reminderEnabled,
    String? locale,
    Object? deletedAt = _Undefined,
    DateTime? createdAt,
  }) {
    return AppUser(
      id: id is int? ? id : this.id,
      authUserId: authUserId is _isc.UuidValue? ? authUserId : this.authUserId,
      email: email is String? ? email : this.email,
      displayName: displayName ?? this.displayName,
      color: color ?? this.color,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      locale: locale ?? this.locale,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
