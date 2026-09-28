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

/// A 6-digit invite code (also rendered as a QR code) valid for 48 hours.
abstract class Invitation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Invitation._({
    this.id,
    required this.code,
    required this.householdId,
    required this.createdById,
    required this.expiresAt,
    this.revokedAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Invitation({
    int? id,
    required String code,
    required int householdId,
    required int createdById,
    required DateTime expiresAt,
    DateTime? revokedAt,
    DateTime? createdAt,
  }) = _InvitationImpl;

  factory Invitation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Invitation(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      householdId: jsonSerialization['householdId'] as int,
      createdById: jsonSerialization['createdById'] as int,
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String code;

  int householdId;

  int createdById;

  DateTime expiresAt;

  DateTime? revokedAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Invitation copyWith({
    int? id,
    String? code,
    int? householdId,
    int? createdById,
    DateTime? expiresAt,
    DateTime? revokedAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Invitation',
      if (id != null) 'id': id,
      'code': code,
      'householdId': householdId,
      'createdById': createdById,
      'expiresAt': expiresAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Invitation',
      if (id != null) 'id': id,
      'code': code,
      'householdId': householdId,
      'createdById': createdById,
      'expiresAt': expiresAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvitationImpl extends Invitation {
  _InvitationImpl({
    int? id,
    required String code,
    required int householdId,
    required int createdById,
    required DateTime expiresAt,
    DateTime? revokedAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         code: code,
         householdId: householdId,
         createdById: createdById,
         expiresAt: expiresAt,
         revokedAt: revokedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Invitation copyWith({
    Object? id = _Undefined,
    String? code,
    int? householdId,
    int? createdById,
    DateTime? expiresAt,
    Object? revokedAt = _Undefined,
    DateTime? createdAt,
  }) {
    return Invitation(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      householdId: householdId ?? this.householdId,
      createdById: createdById ?? this.createdById,
      expiresAt: expiresAt ?? this.expiresAt,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
