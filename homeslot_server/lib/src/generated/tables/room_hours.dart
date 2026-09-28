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

/// Opening hours of a room for one weekday. A weekday without a row is closed.
abstract class RoomHours
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RoomHours._({
    this.id,
    this.roomId,
    required this.weekday,
    required this.openMinute,
    required this.closeMinute,
  });

  factory RoomHours({
    int? id,
    int? roomId,
    required int weekday,
    required int openMinute,
    required int closeMinute,
  }) = _RoomHoursImpl;

  factory RoomHours.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomHours(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int?,
      weekday: jsonSerialization['weekday'] as int,
      openMinute: jsonSerialization['openMinute'] as int,
      closeMinute: jsonSerialization['closeMinute'] as int,
    );
  }

  static final t = RoomHoursTable();

  static const db = RoomHoursRepository._();

  @override
  int? id;

  int? roomId;

  /// 1 = Monday ... 7 = Sunday (same as `DateTime.weekday`).
  int weekday;

  /// Minutes after local midnight, 0-1439.
  int openMinute;

  /// Minutes after local midnight, 1-1440 (1440 = end of day).
  int closeMinute;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RoomHours]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RoomHours copyWith({
    int? id,
    int? roomId,
    int? weekday,
    int? openMinute,
    int? closeMinute,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomHours',
      if (id != null) 'id': id,
      if (roomId != null) 'roomId': roomId,
      'weekday': weekday,
      'openMinute': openMinute,
      'closeMinute': closeMinute,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomHours',
      if (id != null) 'id': id,
      if (roomId != null) 'roomId': roomId,
      'weekday': weekday,
      'openMinute': openMinute,
      'closeMinute': closeMinute,
    };
  }

  static RoomHoursInclude include() {
    return RoomHoursInclude._();
  }

  static RoomHoursIncludeList includeList({
    _is.WhereExpressionBuilder<RoomHoursTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomHoursTable>? orderBy,
    _is.OrderByListBuilder<RoomHoursTable>? orderByList,
    RoomHoursInclude? include,
  }) {
    return RoomHoursIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomHours.t),
      orderByList: orderByList?.call(RoomHours.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomHoursImpl extends RoomHours {
  _RoomHoursImpl({
    int? id,
    int? roomId,
    required int weekday,
    required int openMinute,
    required int closeMinute,
  }) : super._(
         id: id,
         roomId: roomId,
         weekday: weekday,
         openMinute: openMinute,
         closeMinute: closeMinute,
       );

  /// Returns a shallow copy of this [RoomHours]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RoomHours copyWith({
    Object? id = _Undefined,
    Object? roomId = _Undefined,
    int? weekday,
    int? openMinute,
    int? closeMinute,
  }) {
    return RoomHours(
      id: id is int? ? id : this.id,
      roomId: roomId is int? ? roomId : this.roomId,
      weekday: weekday ?? this.weekday,
      openMinute: openMinute ?? this.openMinute,
      closeMinute: closeMinute ?? this.closeMinute,
    );
  }
}

class RoomHoursUpdateTable extends _is.UpdateTable<RoomHoursTable> {
  RoomHoursUpdateTable(super.table);

  _is.ColumnValue<int, int> roomId(int? value) => _is.ColumnValue(
    table.roomId,
    value,
  );

  _is.ColumnValue<int, int> weekday(int value) => _is.ColumnValue(
    table.weekday,
    value,
  );

  _is.ColumnValue<int, int> openMinute(int value) => _is.ColumnValue(
    table.openMinute,
    value,
  );

  _is.ColumnValue<int, int> closeMinute(int value) => _is.ColumnValue(
    table.closeMinute,
    value,
  );
}

class RoomHoursTable extends _is.Table<int?> {
  RoomHoursTable({super.tableRelation}) : super(tableName: 'room_hours') {
    updateTable = RoomHoursUpdateTable(this);
    roomId = _is.ColumnInt(
      'roomId',
      this,
    );
    weekday = _is.ColumnInt(
      'weekday',
      this,
    );
    openMinute = _is.ColumnInt(
      'openMinute',
      this,
    );
    closeMinute = _is.ColumnInt(
      'closeMinute',
      this,
    );
  }

  late final RoomHoursUpdateTable updateTable;

  late final _is.ColumnInt roomId;

  /// 1 = Monday ... 7 = Sunday (same as `DateTime.weekday`).
  late final _is.ColumnInt weekday;

  /// Minutes after local midnight, 0-1439.
  late final _is.ColumnInt openMinute;

  /// Minutes after local midnight, 1-1440 (1440 = end of day).
  late final _is.ColumnInt closeMinute;

  @override
  List<_is.Column> get columns => [
    id,
    roomId,
    weekday,
    openMinute,
    closeMinute,
  ];
}

class RoomHoursInclude extends _is.IncludeObject {
  RoomHoursInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RoomHours.t;
}

class RoomHoursIncludeList extends _is.IncludeList {
  RoomHoursIncludeList._({
    _is.WhereExpressionBuilder<RoomHoursTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoomHours.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RoomHours.t;
}

class RoomHoursRepository {
  const RoomHoursRepository._();

  /// Returns a list of [RoomHours]s matching the given query parameters.
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
  Future<List<RoomHours>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomHoursTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomHoursTable>? orderBy,
    _is.OrderByListBuilder<RoomHoursTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RoomHours>(
      where: where?.call(RoomHours.t),
      orderBy: orderBy?.call(RoomHours.t),
      orderByList: orderByList?.call(RoomHours.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RoomHours] matching the given query parameters.
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
  Future<RoomHours?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomHoursTable>? where,
    int? offset,
    _is.OrderByBuilder<RoomHoursTable>? orderBy,
    _is.OrderByListBuilder<RoomHoursTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RoomHours>(
      where: where?.call(RoomHours.t),
      orderBy: orderBy?.call(RoomHours.t),
      orderByList: orderByList?.call(RoomHours.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RoomHours] by its [id] or null if no such row exists.
  Future<RoomHours?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RoomHours>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RoomHours]s in the list and returns the inserted rows.
  ///
  /// The returned [RoomHours]s will have their `id` fields set.
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
  Future<List<RoomHours>> insert(
    _is.DatabaseSession session,
    List<RoomHours> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RoomHours>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RoomHours] and returns the inserted row.
  ///
  /// The returned [RoomHours] will have its `id` field set.
  Future<RoomHours> insertRow(
    _is.DatabaseSession session,
    RoomHours row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoomHours>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RoomHours]s in the list and returns the resulting rows.
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
  /// The returned [RoomHours]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoomHours>> upsert(
    _is.DatabaseSession session,
    List<RoomHours> rows, {
    required _is.ColumnSelections<RoomHoursTable> conflictColumns,
    _is.ColumnSelections<RoomHoursTable>? updateColumns,
    _is.WhereExpressionBuilder<RoomHoursTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RoomHours>(
      rows,
      conflictColumns: conflictColumns(RoomHours.t),
      updateColumns: updateColumns?.call(RoomHours.t),
      updateWhere: updateWhere?.call(RoomHours.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RoomHours] and returns the resulting row.
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
  /// The returned [RoomHours] will have its `id` field set.
  Future<RoomHours?> upsertRow(
    _is.DatabaseSession session,
    RoomHours row, {
    required _is.ColumnSelections<RoomHoursTable> conflictColumns,
    _is.ColumnSelections<RoomHoursTable>? updateColumns,
    _is.WhereExpressionBuilder<RoomHoursTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RoomHours>(
      row,
      conflictColumns: conflictColumns(RoomHours.t),
      updateColumns: updateColumns?.call(RoomHours.t),
      updateWhere: updateWhere?.call(RoomHours.t),
      transaction: transaction,
    );
  }

  /// Updates all [RoomHours]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoomHours>> update(
    _is.DatabaseSession session,
    List<RoomHours> rows, {
    _is.ColumnSelections<RoomHoursTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RoomHours>(
      rows,
      columns: columns?.call(RoomHours.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RoomHours]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RoomHours> updateRow(
    _is.DatabaseSession session,
    RoomHours row, {
    _is.ColumnSelections<RoomHoursTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoomHours>(
      row,
      columns: columns?.call(RoomHours.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomHours] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RoomHours?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RoomHoursUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RoomHours>(
      id,
      columnValues: columnValues(RoomHours.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RoomHours]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoomHours>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RoomHoursUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RoomHoursTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoomHoursTable>? orderBy,
    _is.OrderByListBuilder<RoomHoursTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RoomHours>(
      columnValues: columnValues(RoomHours.t.updateTable),
      where: where(RoomHours.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomHours.t),
      orderByList: orderByList?.call(RoomHours.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RoomHours]s in the list and returns the deleted rows.
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
  Future<List<RoomHours>> delete(
    _is.DatabaseSession session,
    List<RoomHours> rows, {
    _is.OrderByBuilder<RoomHoursTable>? orderBy,
    _is.OrderByListBuilder<RoomHoursTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RoomHours>(
      rows,
      orderBy: orderBy?.call(RoomHours.t),
      orderByList: orderByList?.call(RoomHours.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RoomHours].
  Future<RoomHours> deleteRow(
    _is.DatabaseSession session,
    RoomHours row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoomHours>(
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
  Future<List<RoomHours>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoomHoursTable> where,
    _is.OrderByBuilder<RoomHoursTable>? orderBy,
    _is.OrderByListBuilder<RoomHoursTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RoomHours>(
      where: where(RoomHours.t),
      orderBy: orderBy?.call(RoomHours.t),
      orderByList: orderByList?.call(RoomHours.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoomHoursTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RoomHours>(
      where: where?.call(RoomHours.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RoomHours] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoomHoursTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RoomHours>(
      where: where(RoomHours.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
