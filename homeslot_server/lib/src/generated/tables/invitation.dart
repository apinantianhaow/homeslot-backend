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

/// A 6-digit invite code (also rendered as a QR code) valid for 48 hours.
abstract class Invitation
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = InvitationTable();

  static const db = InvitationRepository._();

  @override
  int? id;

  String code;

  int householdId;

  int createdById;

  DateTime expiresAt;

  DateTime? revokedAt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static InvitationInclude include() {
    return InvitationInclude._();
  }

  static InvitationIncludeList includeList({
    _is.WhereExpressionBuilder<InvitationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvitationTable>? orderBy,
    _is.OrderByListBuilder<InvitationTable>? orderByList,
    InvitationInclude? include,
  }) {
    return InvitationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Invitation.t),
      orderByList: orderByList?.call(Invitation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class InvitationUpdateTable extends _is.UpdateTable<InvitationTable> {
  InvitationUpdateTable(super.table);

  _is.ColumnValue<String, String> code(String value) => _is.ColumnValue(
    table.code,
    value,
  );

  _is.ColumnValue<int, int> householdId(int value) => _is.ColumnValue(
    table.householdId,
    value,
  );

  _is.ColumnValue<int, int> createdById(int value) => _is.ColumnValue(
    table.createdById,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> revokedAt(DateTime? value) =>
      _is.ColumnValue(
        table.revokedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class InvitationTable extends _is.Table<int?> {
  InvitationTable({super.tableRelation}) : super(tableName: 'invitations') {
    updateTable = InvitationUpdateTable(this);
    code = _is.ColumnString(
      'code',
      this,
    );
    householdId = _is.ColumnInt(
      'householdId',
      this,
    );
    createdById = _is.ColumnInt(
      'createdById',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
    revokedAt = _is.ColumnDateTime(
      'revokedAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final InvitationUpdateTable updateTable;

  late final _is.ColumnString code;

  late final _is.ColumnInt householdId;

  late final _is.ColumnInt createdById;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnDateTime revokedAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    code,
    householdId,
    createdById,
    expiresAt,
    revokedAt,
    createdAt,
  ];
}

class InvitationInclude extends _is.IncludeObject {
  InvitationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Invitation.t;
}

class InvitationIncludeList extends _is.IncludeList {
  InvitationIncludeList._({
    _is.WhereExpressionBuilder<InvitationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Invitation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Invitation.t;
}

class InvitationRepository {
  const InvitationRepository._();

  /// Returns a list of [Invitation]s matching the given query parameters.
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
  Future<List<Invitation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvitationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvitationTable>? orderBy,
    _is.OrderByListBuilder<InvitationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Invitation>(
      where: where?.call(Invitation.t),
      orderBy: orderBy?.call(Invitation.t),
      orderByList: orderByList?.call(Invitation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Invitation] matching the given query parameters.
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
  Future<Invitation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvitationTable>? where,
    int? offset,
    _is.OrderByBuilder<InvitationTable>? orderBy,
    _is.OrderByListBuilder<InvitationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Invitation>(
      where: where?.call(Invitation.t),
      orderBy: orderBy?.call(Invitation.t),
      orderByList: orderByList?.call(Invitation.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Invitation] by its [id] or null if no such row exists.
  Future<Invitation?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Invitation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Invitation]s in the list and returns the inserted rows.
  ///
  /// The returned [Invitation]s will have their `id` fields set.
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
  Future<List<Invitation>> insert(
    _is.DatabaseSession session,
    List<Invitation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Invitation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Invitation] and returns the inserted row.
  ///
  /// The returned [Invitation] will have its `id` field set.
  Future<Invitation> insertRow(
    _is.DatabaseSession session,
    Invitation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Invitation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Invitation]s in the list and returns the resulting rows.
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
  /// The returned [Invitation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invitation>> upsert(
    _is.DatabaseSession session,
    List<Invitation> rows, {
    required _is.ColumnSelections<InvitationTable> conflictColumns,
    _is.ColumnSelections<InvitationTable>? updateColumns,
    _is.WhereExpressionBuilder<InvitationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Invitation>(
      rows,
      conflictColumns: conflictColumns(Invitation.t),
      updateColumns: updateColumns?.call(Invitation.t),
      updateWhere: updateWhere?.call(Invitation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Invitation] and returns the resulting row.
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
  /// The returned [Invitation] will have its `id` field set.
  Future<Invitation?> upsertRow(
    _is.DatabaseSession session,
    Invitation row, {
    required _is.ColumnSelections<InvitationTable> conflictColumns,
    _is.ColumnSelections<InvitationTable>? updateColumns,
    _is.WhereExpressionBuilder<InvitationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Invitation>(
      row,
      conflictColumns: conflictColumns(Invitation.t),
      updateColumns: updateColumns?.call(Invitation.t),
      updateWhere: updateWhere?.call(Invitation.t),
      transaction: transaction,
    );
  }

  /// Updates all [Invitation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invitation>> update(
    _is.DatabaseSession session,
    List<Invitation> rows, {
    _is.ColumnSelections<InvitationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Invitation>(
      rows,
      columns: columns?.call(Invitation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Invitation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Invitation> updateRow(
    _is.DatabaseSession session,
    Invitation row, {
    _is.ColumnSelections<InvitationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Invitation>(
      row,
      columns: columns?.call(Invitation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Invitation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Invitation?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InvitationUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Invitation>(
      id,
      columnValues: columnValues(Invitation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Invitation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invitation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InvitationUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<InvitationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvitationTable>? orderBy,
    _is.OrderByListBuilder<InvitationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Invitation>(
      columnValues: columnValues(Invitation.t.updateTable),
      where: where(Invitation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Invitation.t),
      orderByList: orderByList?.call(Invitation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Invitation]s in the list and returns the deleted rows.
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
  Future<List<Invitation>> delete(
    _is.DatabaseSession session,
    List<Invitation> rows, {
    _is.OrderByBuilder<InvitationTable>? orderBy,
    _is.OrderByListBuilder<InvitationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Invitation>(
      rows,
      orderBy: orderBy?.call(Invitation.t),
      orderByList: orderByList?.call(Invitation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Invitation].
  Future<Invitation> deleteRow(
    _is.DatabaseSession session,
    Invitation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Invitation>(
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
  Future<List<Invitation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InvitationTable> where,
    _is.OrderByBuilder<InvitationTable>? orderBy,
    _is.OrderByListBuilder<InvitationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Invitation>(
      where: where(Invitation.t),
      orderBy: orderBy?.call(Invitation.t),
      orderByList: orderByList?.call(Invitation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvitationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Invitation>(
      where: where?.call(Invitation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Invitation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InvitationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Invitation>(
      where: where(Invitation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
