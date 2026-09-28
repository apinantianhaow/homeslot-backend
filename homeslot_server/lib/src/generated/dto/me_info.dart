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
import '../enums/member_role.dart' as _iw6qhlck;
import '../tables/app_user.dart' as _i5qq0nr3;
import '../tables/household.dart' as _iplu4xa1;

/// The signed-in user with their household and role, if any.
abstract class MeInfo
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MeInfo._({
    required this.user,
    this.household,
    this.role,
  });

  factory MeInfo({
    required _i5qq0nr3.AppUser user,
    _iplu4xa1.Household? household,
    _iw6qhlck.MemberRole? role,
  }) = _MeInfoImpl;

  factory MeInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return MeInfo(
      user: _ig62mdor.Protocol().deserialize<_i5qq0nr3.AppUser>(
        jsonSerialization['user'],
      ),
      household: jsonSerialization['household'] == null
          ? null
          : _ig62mdor.Protocol().deserialize<_iplu4xa1.Household>(
              jsonSerialization['household'],
            ),
      role: jsonSerialization['role'] == null
          ? null
          : _iw6qhlck.MemberRole.fromJson(
              (jsonSerialization['role'] as String),
            ),
    );
  }

  _i5qq0nr3.AppUser user;

  _iplu4xa1.Household? household;

  _iw6qhlck.MemberRole? role;

  /// Returns a shallow copy of this [MeInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MeInfo copyWith({
    _i5qq0nr3.AppUser? user,
    _iplu4xa1.Household? household,
    _iw6qhlck.MemberRole? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MeInfo',
      'user': user.toJson(),
      if (household != null) 'household': household?.toJson(),
      if (role != null) 'role': role?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MeInfo',
      'user': user.toJsonForProtocol(),
      if (household != null) 'household': household?.toJsonForProtocol(),
      if (role != null) 'role': role?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MeInfoImpl extends MeInfo {
  _MeInfoImpl({
    required _i5qq0nr3.AppUser user,
    _iplu4xa1.Household? household,
    _iw6qhlck.MemberRole? role,
  }) : super._(
         user: user,
         household: household,
         role: role,
       );

  /// Returns a shallow copy of this [MeInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MeInfo copyWith({
    _i5qq0nr3.AppUser? user,
    Object? household = _Undefined,
    Object? role = _Undefined,
  }) {
    return MeInfo(
      user: user ?? this.user.copyWith(),
      household: household is _iplu4xa1.Household?
          ? household
          : this.household?.copyWith(),
      role: role is _iw6qhlck.MemberRole? ? role : this.role,
    );
  }
}
