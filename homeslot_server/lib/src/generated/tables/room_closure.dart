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

/// A temporary closure of a room, e.g. while the air conditioner is repaired.
abstract class RoomClosure
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RoomClosure._({
    this.id,
    required this.roomId,
    required this.startAt,
    required this.endAt,
    required this.reason,
    required this.createdById,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory RoomClosure({
    int? id,
    required int roomId,
    required DateTime startAt,
    required DateTime endAt,
    required String reason,
    required int createdById,
    DateTime? createdAt,
  }) = _RoomClosureImpl;

  factory RoomClosure.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomClosure(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      startAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['startAt']),
      endAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['endAt']),
      reason: jsonSerialization['reason'] as String,
      createdById: jsonSerialization['createdById'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = RoomClosureTable();

  static const db = RoomClosureRepository._();

  @override
  int? id;

  int roomId;

  DateTime startAt;

  DateTime endAt;

  String reason;

  int createdById;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RoomClosure]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RoomClosure copyWith({
    int? id,
    int? roomId,
    DateTime? startAt,
    DateTime? endAt,
    String? reason,
    int? createdById,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomClosure',
      if (id != null) 'id': id,
      'roomId': roomId,
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      'reason': reason,
      'createdById': createdById,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomClosure',
      if (id != null) 'id': id,
      'roomId': roomId,
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      'reason': reason,
      'createdById': createdById,
      'createdAt': createdAt.toJson(),
    };
  }

  static RoomClosureInclude include() {
    return RoomClosureInclude._();
  }

  static RoomClosureIncludeList includeList({
    _is.WhereExpressionBuilder<RoomClosureTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomClosureTable>? orderBy,
    _is.OrderByListBuilder<RoomClosureTable>? orderByList,
    RoomClosureInclude? include,
  }) {
    return RoomClosureIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomClosure.t),
      orderByList: orderByList?.call(RoomClosure.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomClosureImpl extends RoomClosure {
  _RoomClosureImpl({
    int? id,
    required int roomId,
    required DateTime startAt,
    required DateTime endAt,
    required String reason,
    required int createdById,
    DateTime? createdAt,
  }) : super._(
         id: id,
         roomId: roomId,
         startAt: startAt,
         endAt: endAt,
         reason: reason,
         createdById: createdById,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RoomClosure]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RoomClosure copyWith({
    Object? id = _Undefined,
    int? roomId,
    DateTime? startAt,
    DateTime? endAt,
    String? reason,
    int? createdById,
    DateTime? createdAt,
  }) {
    return RoomClosure(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      reason: reason ?? this.reason,
      createdById: createdById ?? this.createdById,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RoomClosureUpdateTable extends _is.UpdateTable<RoomClosureTable> {
  RoomClosureUpdateTable(super.table);

  _is.ColumnValue<int, int> roomId(int value) => _is.ColumnValue(
    table.roomId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startAt(DateTime value) =>
      _is.ColumnValue(
        table.startAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endAt(DateTime value) => _is.ColumnValue(
    table.endAt,
    value,
  );

  _is.ColumnValue<String, String> reason(String value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<int, int> createdById(int value) => _is.ColumnValue(
    table.createdById,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class RoomClosureTable extends _is.Table<int?> {
  RoomClosureTable({super.tableRelation}) : super(tableName: 'room_closures') {
    updateTable = RoomClosureUpdateTable(this);
    roomId = _is.ColumnInt(
      'roomId',
      this,
    );
    startAt = _is.ColumnDateTime(
      'startAt',
      this,
    );
    endAt = _is.ColumnDateTime(
      'endAt',
      this,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    createdById = _is.ColumnInt(
      'createdById',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final RoomClosureUpdateTable updateTable;

  late final _is.ColumnInt roomId;

  late final _is.ColumnDateTime startAt;

  late final _is.ColumnDateTime endAt;

  late final _is.ColumnString reason;

  late final _is.ColumnInt createdById;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    roomId,
    startAt,
    endAt,
    reason,
    createdById,
    createdAt,
  ];
}

class RoomClosureInclude extends _is.IncludeObject {
  RoomClosureInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RoomClosure.t;
}

class RoomClosureIncludeList extends _is.IncludeList {
  RoomClosureIncludeList._({
    _is.WhereExpressionBuilder<RoomClosureTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoomClosure.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RoomClosure.t;
}

class RoomClosureRepository {
  const RoomClosureRepository._();

  /// Returns a list of [RoomClosure]s matching the given query parameters.
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
  Future<List<RoomClosure>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomClosureTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomClosureTable>? orderBy,
    _is.OrderByListBuilder<RoomClosureTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RoomClosure>(
      where: where?.call(RoomClosure.t),
      orderBy: orderBy?.call(RoomClosure.t),
      orderByList: orderByList?.call(RoomClosure.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RoomClosure] matching the given query parameters.
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
  Future<RoomClosure?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomClosureTable>? where,
    int? offset,
    _is.OrderByBuilder<RoomClosureTable>? orderBy,
    _is.OrderByListBuilder<RoomClosureTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RoomClosure>(
      where: where?.call(RoomClosure.t),
      orderBy: orderBy?.call(RoomClosure.t),
      orderByList: orderByList?.call(RoomClosure.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RoomClosure] by its [id] or null if no such row exists.
  Future<RoomClosure?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RoomClosure>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RoomClosure]s in the list and returns the inserted rows.
  ///
  /// The returned [RoomClosure]s will have their `id` fields set.
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
  Future<List<RoomClosure>> insert(
    _is.DatabaseSession session,
    List<RoomClosure> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RoomClosure>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RoomClosure] and returns the inserted row.
  ///
  /// The returned [RoomClosure] will have its `id` field set.
  Future<RoomClosure> insertRow(
    _is.DatabaseSession session,
    RoomClosure row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoomClosure>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RoomClosure]s in the list and returns the resulting rows.
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
  /// The returned [RoomClosure]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoomClosure>> upsert(
    _is.DatabaseSession session,
    List<RoomClosure> rows, {
    required _is.ColumnSelections<RoomClosureTable> conflictColumns,
    _is.ColumnSelections<RoomClosureTable>? updateColumns,
    _is.WhereExpressionBuilder<RoomClosureTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RoomClosure>(
      rows,
      conflictColumns: conflictColumns(RoomClosure.t),
      updateColumns: updateColumns?.call(RoomClosure.t),
      updateWhere: updateWhere?.call(RoomClosure.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RoomClosure] and returns the resulting row.
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
  /// The returned [RoomClosure] will have its `id` field set.
  Future<RoomClosure?> upsertRow(
    _is.DatabaseSession session,
    RoomClosure row, {
    required _is.ColumnSelections<RoomClosureTable> conflictColumns,
    _is.ColumnSelections<RoomClosureTable>? updateColumns,
    _is.WhereExpressionBuilder<RoomClosureTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RoomClosure>(
      row,
      conflictColumns: conflictColumns(RoomClosure.t),
      updateColumns: updateColumns?.call(RoomClosure.t),
      updateWhere: updateWhere?.call(RoomClosure.t),
      transaction: transaction,
    );
  }

  /// Updates all [RoomClosure]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoomClosure>> update(
    _is.DatabaseSession session,
    List<RoomClosure> rows, {
    _is.ColumnSelections<RoomClosureTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RoomClosure>(
      rows,
      columns: columns?.call(RoomClosure.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RoomClosure]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RoomClosure> updateRow(
    _is.DatabaseSession session,
    RoomClosure row, {
    _is.ColumnSelections<RoomClosureTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoomClosure>(
      row,
      columns: columns?.call(RoomClosure.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomClosure] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RoomClosure?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RoomClosureUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RoomClosure>(
      id,
      columnValues: columnValues(RoomClosure.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RoomClosure]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoomClosure>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RoomClosureUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RoomClosureTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomClosureTable>? orderBy,
    _is.OrderByListBuilder<RoomClosureTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RoomClosure>(
      columnValues: columnValues(RoomClosure.t.updateTable),
      where: where(RoomClosure.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomClosure.t),
      orderByList: orderByList?.call(RoomClosure.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RoomClosure]s in the list and returns the deleted rows.
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
  Future<List<RoomClosure>> delete(
    _is.DatabaseSession session,
    List<RoomClosure> rows, {
    _is.OrderByBuilder<RoomClosureTable>? orderBy,
    _is.OrderByListBuilder<RoomClosureTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RoomClosure>(
      rows,
      orderBy: orderBy?.call(RoomClosure.t),
      orderByList: orderByList?.call(RoomClosure.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RoomClosure].
  Future<RoomClosure> deleteRow(
    _is.DatabaseSession session,
    RoomClosure row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoomClosure>(
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
  Future<List<RoomClosure>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoomClosureTable> where,
    _is.OrderByBuilder<RoomClosureTable>? orderBy,
    _is.OrderByListBuilder<RoomClosureTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RoomClosure>(
      where: where(RoomClosure.t),
      orderBy: orderBy?.call(RoomClosure.t),
      orderByList: orderByList?.call(RoomClosure.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomClosureTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RoomClosure>(
      where: where?.call(RoomClosure.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RoomClosure] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoomClosureTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RoomClosure>(
      where: where(RoomClosure.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
