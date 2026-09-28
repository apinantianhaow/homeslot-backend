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
import '../enums/room_type.dart' as _ijhslqsh;

/// A bookable room together with its booking rules (SRS 2.3 rule table).
abstract class Room
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Room._({
    this.id,
    required this.householdId,
    required this.name,
    required this.type,
    this.imageUrl,
    int? capacity,
    this.description,
    bool? requiresApproval,
    int? slotMinutes,
    int? minMinutes,
    int? maxMinutes,
    int? advanceDays,
    this.weeklyQuotaMinutes,
    int? sortOrder,
    DateTime? createdAt,
  }) : capacity = capacity ?? 1,
       requiresApproval = requiresApproval ?? false,
       slotMinutes = slotMinutes ?? 15,
       minMinutes = minMinutes ?? 30,
       maxMinutes = maxMinutes ?? 240,
       advanceDays = advanceDays ?? 30,
       sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory Room({
    int? id,
    required int householdId,
    required String name,
    required _ijhslqsh.RoomType type,
    String? imageUrl,
    int? capacity,
    String? description,
    bool? requiresApproval,
    int? slotMinutes,
    int? minMinutes,
    int? maxMinutes,
    int? advanceDays,
    int? weeklyQuotaMinutes,
    int? sortOrder,
    DateTime? createdAt,
  }) = _RoomImpl;

  factory Room.fromJson(Map<String, dynamic> jsonSerialization) {
    return Room(
      id: jsonSerialization['id'] as int?,
      householdId: jsonSerialization['householdId'] as int,
      name: jsonSerialization['name'] as String,
      type: _ijhslqsh.RoomType.fromJson((jsonSerialization['type'] as String)),
      imageUrl: jsonSerialization['imageUrl'] as String?,
      capacity: jsonSerialization['capacity'] as int?,
      description: jsonSerialization['description'] as String?,
      requiresApproval: jsonSerialization['requiresApproval'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['requiresApproval'],
            ),
      slotMinutes: jsonSerialization['slotMinutes'] as int?,
      minMinutes: jsonSerialization['minMinutes'] as int?,
      maxMinutes: jsonSerialization['maxMinutes'] as int?,
      advanceDays: jsonSerialization['advanceDays'] as int?,
      weeklyQuotaMinutes: jsonSerialization['weeklyQuotaMinutes'] as int?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int householdId;

  String name;

  _ijhslqsh.RoomType type;

  String? imageUrl;

  int capacity;

  String? description;

  /// Bookings by members must be approved by an owner first.
  bool requiresApproval;

  /// Start and end times must align to this many minutes.
  int slotMinutes;

  /// Minimum length of one booking.
  int minMinutes;

  /// Maximum length of one booking.
  int maxMinutes;

  /// How many days ahead a booking may start.
  int advanceDays;

  /// Weekly minutes a member may book in this room. Null means unlimited.
  int? weeklyQuotaMinutes;

  int sortOrder;

  DateTime createdAt;

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Room copyWith({
    int? id,
    int? householdId,
    String? name,
    _ijhslqsh.RoomType? type,
    String? imageUrl,
    int? capacity,
    String? description,
    bool? requiresApproval,
    int? slotMinutes,
    int? minMinutes,
    int? maxMinutes,
    int? advanceDays,
    int? weeklyQuotaMinutes,
    int? sortOrder,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Room',
      if (id != null) 'id': id,
      'householdId': householdId,
      'name': name,
      'type': type.toJson(),
      if (imageUrl != null) 'imageUrl': imageUrl,
      'capacity': capacity,
      if (description != null) 'description': description,
      'requiresApproval': requiresApproval,
      'slotMinutes': slotMinutes,
      'minMinutes': minMinutes,
      'maxMinutes': maxMinutes,
      'advanceDays': advanceDays,
      if (weeklyQuotaMinutes != null) 'weeklyQuotaMinutes': weeklyQuotaMinutes,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Room',
      if (id != null) 'id': id,
      'householdId': householdId,
      'name': name,
      'type': type.toJson(),
      if (imageUrl != null) 'imageUrl': imageUrl,
      'capacity': capacity,
      if (description != null) 'description': description,
      'requiresApproval': requiresApproval,
      'slotMinutes': slotMinutes,
      'minMinutes': minMinutes,
      'maxMinutes': maxMinutes,
      'advanceDays': advanceDays,
      if (weeklyQuotaMinutes != null) 'weeklyQuotaMinutes': weeklyQuotaMinutes,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomImpl extends Room {
  _RoomImpl({
    int? id,
    required int householdId,
    required String name,
    required _ijhslqsh.RoomType type,
    String? imageUrl,
    int? capacity,
    String? description,
    bool? requiresApproval,
    int? slotMinutes,
    int? minMinutes,
    int? maxMinutes,
    int? advanceDays,
    int? weeklyQuotaMinutes,
    int? sortOrder,
    DateTime? createdAt,
  }) : super._(
         id: id,
         householdId: householdId,
         name: name,
         type: type,
         imageUrl: imageUrl,
         capacity: capacity,
         description: description,
         requiresApproval: requiresApproval,
         slotMinutes: slotMinutes,
         minMinutes: minMinutes,
         maxMinutes: maxMinutes,
         advanceDays: advanceDays,
         weeklyQuotaMinutes: weeklyQuotaMinutes,
         sortOrder: sortOrder,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Room copyWith({
    Object? id = _Undefined,
    int? householdId,
    String? name,
    _ijhslqsh.RoomType? type,
    Object? imageUrl = _Undefined,
    int? capacity,
    Object? description = _Undefined,
    bool? requiresApproval,
    int? slotMinutes,
    int? minMinutes,
    int? maxMinutes,
    int? advanceDays,
    Object? weeklyQuotaMinutes = _Undefined,
    int? sortOrder,
    DateTime? createdAt,
  }) {
    return Room(
      id: id is int? ? id : this.id,
      householdId: householdId ?? this.householdId,
      name: name ?? this.name,
      type: type ?? this.type,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      capacity: capacity ?? this.capacity,
      description: description is String? ? description : this.description,
      requiresApproval: requiresApproval ?? this.requiresApproval,
      slotMinutes: slotMinutes ?? this.slotMinutes,
      minMinutes: minMinutes ?? this.minMinutes,
      maxMinutes: maxMinutes ?? this.maxMinutes,
      advanceDays: advanceDays ?? this.advanceDays,
      weeklyQuotaMinutes: weeklyQuotaMinutes is int?
          ? weeklyQuotaMinutes
          : this.weeklyQuotaMinutes,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
