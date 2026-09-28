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
import '../enums/member_role.dart' as _iw6qhlck;

/// A household member as shown in the member list.
abstract class MemberInfo
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MemberInfo._({
    required this.userId,
    required this.displayName,
    required this.color,
    this.avatarUrl,
    this.email,
    required this.role,
    required this.joinedAt,
  });

  factory MemberInfo({
    required int userId,
    required String displayName,
    required String color,
    String? avatarUrl,
    String? email,
    required _iw6qhlck.MemberRole role,
    required DateTime joinedAt,
  }) = _MemberInfoImpl;

  factory MemberInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemberInfo(
      userId: jsonSerialization['userId'] as int,
      displayName: jsonSerialization['displayName'] as String,
      color: jsonSerialization['color'] as String,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      email: jsonSerialization['email'] as String?,
      role: _iw6qhlck.MemberRole.fromJson(
        (jsonSerialization['role'] as String),
      ),
      joinedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  int userId;

  String displayName;

  String color;

  String? avatarUrl;

  String? email;

  _iw6qhlck.MemberRole role;

  DateTime joinedAt;

  /// Returns a shallow copy of this [MemberInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MemberInfo copyWith({
    int? userId,
    String? displayName,
    String? color,
    String? avatarUrl,
    String? email,
    _iw6qhlck.MemberRole? role,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemberInfo',
      'userId': userId,
      'displayName': displayName,
      'color': color,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (email != null) 'email': email,
      'role': role.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemberInfo',
      'userId': userId,
      'displayName': displayName,
      'color': color,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (email != null) 'email': email,
      'role': role.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemberInfoImpl extends MemberInfo {
  _MemberInfoImpl({
    required int userId,
    required String displayName,
    required String color,
    String? avatarUrl,
    String? email,
    required _iw6qhlck.MemberRole role,
    required DateTime joinedAt,
  }) : super._(
         userId: userId,
         displayName: displayName,
         color: color,
         avatarUrl: avatarUrl,
         email: email,
         role: role,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [MemberInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MemberInfo copyWith({
    int? userId,
    String? displayName,
    String? color,
    Object? avatarUrl = _Undefined,
    Object? email = _Undefined,
    _iw6qhlck.MemberRole? role,
    DateTime? joinedAt,
  }) {
    return MemberInfo(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      color: color ?? this.color,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      email: email is String? ? email : this.email,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
