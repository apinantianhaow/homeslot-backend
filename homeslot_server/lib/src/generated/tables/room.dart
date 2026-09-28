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
import '../enums/room_type.dart' as _ijhslqsh;

/// A bookable room together with its booking rules (SRS 2.3 rule table).
abstract class Room implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _is.BoolJsonExtension.fromJson(
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
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = RoomTable();

  static const db = RoomRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static RoomInclude include() {
    return RoomInclude._();
  }

  static RoomIncludeList includeList({
    _is.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomTable>? orderBy,
    _is.OrderByListBuilder<RoomTable>? orderByList,
    RoomInclude? include,
  }) {
    return RoomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class RoomUpdateTable extends _is.UpdateTable<RoomTable> {
  RoomUpdateTable(super.table);

  _is.ColumnValue<int, int> householdId(int value) => _is.ColumnValue(
    table.householdId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<_ijhslqsh.RoomType, _ijhslqsh.RoomType> type(
    _ijhslqsh.RoomType value,
  ) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<String, String> imageUrl(String? value) => _is.ColumnValue(
    table.imageUrl,
    value,
  );

  _is.ColumnValue<int, int> capacity(int value) => _is.ColumnValue(
    table.capacity,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<bool, bool> requiresApproval(bool value) => _is.ColumnValue(
    table.requiresApproval,
    value,
  );

  _is.ColumnValue<int, int> slotMinutes(int value) => _is.ColumnValue(
    table.slotMinutes,
    value,
  );

  _is.ColumnValue<int, int> minMinutes(int value) => _is.ColumnValue(
    table.minMinutes,
    value,
  );

  _is.ColumnValue<int, int> maxMinutes(int value) => _is.ColumnValue(
    table.maxMinutes,
    value,
  );

  _is.ColumnValue<int, int> advanceDays(int value) => _is.ColumnValue(
    table.advanceDays,
    value,
  );

  _is.ColumnValue<int, int> weeklyQuotaMinutes(int? value) => _is.ColumnValue(
    table.weeklyQuotaMinutes,
    value,
  );

  _is.ColumnValue<int, int> sortOrder(int value) => _is.ColumnValue(
    table.sortOrder,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class RoomTable extends _is.Table<int?> {
  RoomTable({super.tableRelation}) : super(tableName: 'rooms') {
    updateTable = RoomUpdateTable(this);
    householdId = _is.ColumnInt(
      'householdId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    type = _is.ColumnEnum(
      'type',
      this,
      _is.EnumSerialization.byName,
    );
    imageUrl = _is.ColumnString(
      'imageUrl',
      this,
    );
    capacity = _is.ColumnInt(
      'capacity',
      this,
      hasDefault: true,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    requiresApproval = _is.ColumnBool(
      'requiresApproval',
      this,
      hasDefault: true,
    );
    slotMinutes = _is.ColumnInt(
      'slotMinutes',
      this,
      hasDefault: true,
    );
    minMinutes = _is.ColumnInt(
      'minMinutes',
      this,
      hasDefault: true,
    );
    maxMinutes = _is.ColumnInt(
      'maxMinutes',
      this,
      hasDefault: true,
    );
    advanceDays = _is.ColumnInt(
      'advanceDays',
      this,
      hasDefault: true,
    );
    weeklyQuotaMinutes = _is.ColumnInt(
      'weeklyQuotaMinutes',
      this,
    );
    sortOrder = _is.ColumnInt(
      'sortOrder',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final RoomUpdateTable updateTable;

  late final _is.ColumnInt householdId;

  late final _is.ColumnString name;

  late final _is.ColumnEnum<_ijhslqsh.RoomType> type;

  late final _is.ColumnString imageUrl;

  late final _is.ColumnInt capacity;

  late final _is.ColumnString description;

  /// Bookings by members must be approved by an owner first.
  late final _is.ColumnBool requiresApproval;

  /// Start and end times must align to this many minutes.
  late final _is.ColumnInt slotMinutes;

  /// Minimum length of one booking.
  late final _is.ColumnInt minMinutes;

  /// Maximum length of one booking.
  late final _is.ColumnInt maxMinutes;

  /// How many days ahead a booking may start.
  late final _is.ColumnInt advanceDays;

  /// Weekly minutes a member may book in this room. Null means unlimited.
  late final _is.ColumnInt weeklyQuotaMinutes;

  late final _is.ColumnInt sortOrder;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    householdId,
    name,
    type,
    imageUrl,
    capacity,
    description,
    requiresApproval,
    slotMinutes,
    minMinutes,
    maxMinutes,
    advanceDays,
    weeklyQuotaMinutes,
    sortOrder,
    createdAt,
  ];
}

class RoomInclude extends _is.IncludeObject {
  RoomInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Room.t;
}

class RoomIncludeList extends _is.IncludeList {
  RoomIncludeList._({
    _is.WhereExpressionBuilder<RoomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Room.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Room.t;
}

class RoomRepository {
  const RoomRepository._();

  /// Returns a list of [Room]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Room>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomTable>? orderBy,
    _is.OrderByListBuilder<RoomTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Room>(
      where: where?.call(Room.t),
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Room] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Room?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomTable>? where,
    int? offset,
    _is.OrderByBuilder<RoomTable>? orderBy,
    _is.OrderByListBuilder<RoomTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Room>(
      where: where?.call(Room.t),
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Room] by its [id] or null if no such row exists.
  Future<Room?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Room>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Room]s in the list and returns the inserted rows.
  ///
  /// The returned [Room]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Room>> insert(
    _is.DatabaseSession session,
    List<Room> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Room>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Room] and returns the inserted row.
  ///
  /// The returned [Room] will have its `id` field set.
  Future<Room> insertRow(
    _is.DatabaseSession session,
    Room row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Room>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Room]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Room]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Room>> upsert(
    _is.DatabaseSession session,
    List<Room> rows, {
    required _is.ColumnSelections<RoomTable> conflictColumns,
    _is.ColumnSelections<RoomTable>? updateColumns,
    _is.WhereExpressionBuilder<RoomTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Room>(
      rows,
      conflictColumns: conflictColumns(Room.t),
      updateColumns: updateColumns?.call(Room.t),
      updateWhere: updateWhere?.call(Room.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Room] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Room] will have its `id` field set.
  Future<Room?> upsertRow(
    _is.DatabaseSession session,
    Room row, {
    required _is.ColumnSelections<RoomTable> conflictColumns,
    _is.ColumnSelections<RoomTable>? updateColumns,
    _is.WhereExpressionBuilder<RoomTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Room>(
      row,
      conflictColumns: conflictColumns(Room.t),
      updateColumns: updateColumns?.call(Room.t),
      updateWhere: updateWhere?.call(Room.t),
      transaction: transaction,
    );
  }

  /// Updates all [Room]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Room>> update(
    _is.DatabaseSession session,
    List<Room> rows, {
    _is.ColumnSelections<RoomTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Room>(
      rows,
      columns: columns?.call(Room.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Room]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Room> updateRow(
    _is.DatabaseSession session,
    Room row, {
    _is.ColumnSelections<RoomTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Room>(
      row,
      columns: columns?.call(Room.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Room] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Room?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RoomUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Room>(
      id,
      columnValues: columnValues(Room.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Room]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Room>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RoomUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RoomTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomTable>? orderBy,
    _is.OrderByListBuilder<RoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Room>(
      columnValues: columnValues(Room.t.updateTable),
      where: where(Room.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Room]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Room>> delete(
    _is.DatabaseSession session,
    List<Room> rows, {
    _is.OrderByBuilder<RoomTable>? orderBy,
    _is.OrderByListBuilder<RoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Room>(
      rows,
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Room].
  Future<Room> deleteRow(
    _is.DatabaseSession session,
    Room row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Room>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Room>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoomTable> where,
    _is.OrderByBuilder<RoomTable>? orderBy,
    _is.OrderByListBuilder<RoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Room>(
      where: where(Room.t),
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Room>(
      where: where?.call(Room.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Room] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoomTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Room>(
      where: where(Room.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
