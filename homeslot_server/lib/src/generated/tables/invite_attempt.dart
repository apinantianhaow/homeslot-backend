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

/// Invite code attempts, used to block brute forcing (5 failures / 15 min).
abstract class InviteAttempt
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  InviteAttempt._({
    this.id,
    required this.userId,
    required this.success,
    required this.attemptedAt,
  });

  factory InviteAttempt({
    int? id,
    required int userId,
    required bool success,
    required DateTime attemptedAt,
  }) = _InviteAttemptImpl;

  factory InviteAttempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return InviteAttempt(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      success: _is.BoolJsonExtension.fromJson(jsonSerialization['success']),
      attemptedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['attemptedAt'],
      ),
    );
  }

  static final t = InviteAttemptTable();

  static const db = InviteAttemptRepository._();

  @override
  int? id;

  int userId;

  bool success;

  DateTime attemptedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [InviteAttempt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InviteAttempt copyWith({
    int? id,
    int? userId,
    bool? success,
    DateTime? attemptedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InviteAttempt',
      if (id != null) 'id': id,
      'userId': userId,
      'success': success,
      'attemptedAt': attemptedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static InviteAttemptInclude include() {
    return InviteAttemptInclude._();
  }

  static InviteAttemptIncludeList includeList({
    _is.WhereExpressionBuilder<InviteAttemptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InviteAttemptTable>? orderBy,
    _is.OrderByListBuilder<InviteAttemptTable>? orderByList,
    InviteAttemptInclude? include,
  }) {
    return InviteAttemptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InviteAttempt.t),
      orderByList: orderByList?.call(InviteAttempt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InviteAttemptImpl extends InviteAttempt {
  _InviteAttemptImpl({
    int? id,
    required int userId,
    required bool success,
    required DateTime attemptedAt,
  }) : super._(
         id: id,
         userId: userId,
         success: success,
         attemptedAt: attemptedAt,
       );

  /// Returns a shallow copy of this [InviteAttempt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InviteAttempt copyWith({
    Object? id = _Undefined,
    int? userId,
    bool? success,
    DateTime? attemptedAt,
  }) {
    return InviteAttempt(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      success: success ?? this.success,
      attemptedAt: attemptedAt ?? this.attemptedAt,
    );
  }
}

class InviteAttemptUpdateTable extends _is.UpdateTable<InviteAttemptTable> {
  InviteAttemptUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<bool, bool> success(bool value) => _is.ColumnValue(
    table.success,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> attemptedAt(DateTime value) =>
      _is.ColumnValue(
        table.attemptedAt,
        value,
      );
}

class InviteAttemptTable extends _is.Table<int?> {
  InviteAttemptTable({super.tableRelation})
    : super(tableName: 'invite_attempts') {
    updateTable = InviteAttemptUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    success = _is.ColumnBool(
      'success',
      this,
    );
    attemptedAt = _is.ColumnDateTime(
      'attemptedAt',
      this,
    );
  }

  late final InviteAttemptUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnBool success;

  late final _is.ColumnDateTime attemptedAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    success,
    attemptedAt,
  ];
}

class InviteAttemptInclude extends _is.IncludeObject {
  InviteAttemptInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => InviteAttempt.t;
}

class InviteAttemptIncludeList extends _is.IncludeList {
  InviteAttemptIncludeList._({
    _is.WhereExpressionBuilder<InviteAttemptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InviteAttempt.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => InviteAttempt.t;
}

class InviteAttemptRepository {
  const InviteAttemptRepository._();

  /// Returns a list of [InviteAttempt]s matching the given query parameters.
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
  Future<List<InviteAttempt>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InviteAttemptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InviteAttemptTable>? orderBy,
    _is.OrderByListBuilder<InviteAttemptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InviteAttempt>(
      where: where?.call(InviteAttempt.t),
      orderBy: orderBy?.call(InviteAttempt.t),
      orderByList: orderByList?.call(InviteAttempt.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InviteAttempt] matching the given query parameters.
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
  Future<InviteAttempt?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InviteAttemptTable>? where,
    int? offset,
    _is.OrderByBuilder<InviteAttemptTable>? orderBy,
    _is.OrderByListBuilder<InviteAttemptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InviteAttempt>(
      where: where?.call(InviteAttempt.t),
      orderBy: orderBy?.call(InviteAttempt.t),
      orderByList: orderByList?.call(InviteAttempt.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InviteAttempt] by its [id] or null if no such row exists.
  Future<InviteAttempt?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InviteAttempt>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InviteAttempt]s in the list and returns the inserted rows.
  ///
  /// The returned [InviteAttempt]s will have their `id` fields set.
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
  Future<List<InviteAttempt>> insert(
    _is.DatabaseSession session,
    List<InviteAttempt> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<InviteAttempt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [InviteAttempt] and returns the inserted row.
  ///
  /// The returned [InviteAttempt] will have its `id` field set.
  Future<InviteAttempt> insertRow(
    _is.DatabaseSession session,
    InviteAttempt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<InviteAttempt>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [InviteAttempt]s in the list and returns the resulting rows.
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
  /// The returned [InviteAttempt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InviteAttempt>> upsert(
    _is.DatabaseSession session,
    List<InviteAttempt> rows, {
    required _is.ColumnSelections<InviteAttemptTable> conflictColumns,
    _is.ColumnSelections<InviteAttemptTable>? updateColumns,
    _is.WhereExpressionBuilder<InviteAttemptTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<InviteAttempt>(
      rows,
      conflictColumns: conflictColumns(InviteAttempt.t),
      updateColumns: updateColumns?.call(InviteAttempt.t),
      updateWhere: updateWhere?.call(InviteAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [InviteAttempt] and returns the resulting row.
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
  /// The returned [InviteAttempt] will have its `id` field set.
  Future<InviteAttempt?> upsertRow(
    _is.DatabaseSession session,
    InviteAttempt row, {
    required _is.ColumnSelections<InviteAttemptTable> conflictColumns,
    _is.ColumnSelections<InviteAttemptTable>? updateColumns,
    _is.WhereExpressionBuilder<InviteAttemptTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<InviteAttempt>(
      row,
      conflictColumns: conflictColumns(InviteAttempt.t),
      updateColumns: updateColumns?.call(InviteAttempt.t),
      updateWhere: updateWhere?.call(InviteAttempt.t),
      transaction: transaction,
    );
  }

  /// Updates all [InviteAttempt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InviteAttempt>> update(
    _is.DatabaseSession session,
    List<InviteAttempt> rows, {
    _is.ColumnSelections<InviteAttemptTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<InviteAttempt>(
      rows,
      columns: columns?.call(InviteAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [InviteAttempt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InviteAttempt> updateRow(
    _is.DatabaseSession session,
    InviteAttempt row, {
    _is.ColumnSelections<InviteAttemptTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<InviteAttempt>(
      row,
      columns: columns?.call(InviteAttempt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InviteAttempt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InviteAttempt?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InviteAttemptUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<InviteAttempt>(
      id,
      columnValues: columnValues(InviteAttempt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InviteAttempt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InviteAttempt>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InviteAttemptUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<InviteAttemptTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InviteAttemptTable>? orderBy,
    _is.OrderByListBuilder<InviteAttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<InviteAttempt>(
      columnValues: columnValues(InviteAttempt.t.updateTable),
      where: where(InviteAttempt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InviteAttempt.t),
      orderByList: orderByList?.call(InviteAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [InviteAttempt]s in the list and returns the deleted rows.
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
  Future<List<InviteAttempt>> delete(
    _is.DatabaseSession session,
    List<InviteAttempt> rows, {
    _is.OrderByBuilder<InviteAttemptTable>? orderBy,
    _is.OrderByListBuilder<InviteAttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<InviteAttempt>(
      rows,
      orderBy: orderBy?.call(InviteAttempt.t),
      orderByList: orderByList?.call(InviteAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [InviteAttempt].
  Future<InviteAttempt> deleteRow(
    _is.DatabaseSession session,
    InviteAttempt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InviteAttempt>(
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
  Future<List<InviteAttempt>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InviteAttemptTable> where,
    _is.OrderByBuilder<InviteAttemptTable>? orderBy,
    _is.OrderByListBuilder<InviteAttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<InviteAttempt>(
      where: where(InviteAttempt.t),
      orderBy: orderBy?.call(InviteAttempt.t),
      orderByList: orderByList?.call(InviteAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InviteAttemptTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<InviteAttempt>(
      where: where?.call(InviteAttempt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InviteAttempt] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InviteAttemptTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InviteAttempt>(
      where: where(InviteAttempt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
