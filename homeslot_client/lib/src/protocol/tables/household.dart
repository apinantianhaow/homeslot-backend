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

/// A household: the group of people sharing the same set of rooms.
abstract class Household
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Household._({
    this.id,
    required this.name,
    String? timezone,
    DateTime? createdAt,
  }) : timezone = timezone ?? 'Asia/Bangkok',
       createdAt = createdAt ?? DateTime.now();

  factory Household({
    int? id,
    required String name,
    String? timezone,
    DateTime? createdAt,
  }) = _HouseholdImpl;

  factory Household.fromJson(Map<String, dynamic> jsonSerialization) {
    return Household(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      timezone: jsonSerialization['timezone'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  /// IANA time zone used to display and validate all times.
  String timezone;

  DateTime createdAt;

  /// Returns a shallow copy of this [Household]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Household copyWith({
    int? id,
    String? name,
    String? timezone,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Household',
      if (id != null) 'id': id,
      'name': name,
      'timezone': timezone,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Household',
      if (id != null) 'id': id,
      'name': name,
      'timezone': timezone,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HouseholdImpl extends Household {
  _HouseholdImpl({
    int? id,
    required String name,
    String? timezone,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         timezone: timezone,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Household]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Household copyWith({
    Object? id = _Undefined,
    String? name,
    String? timezone,
    DateTime? createdAt,
  }) {
    return Household(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      timezone: timezone ?? this.timezone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
