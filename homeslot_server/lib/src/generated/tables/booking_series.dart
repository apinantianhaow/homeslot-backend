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

/// A weekly recurring booking (up to 12 weeks).
abstract class BookingSeries
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  BookingSeries._({
    this.id,
    required this.roomId,
    required this.userId,
    required this.weekday,
    required this.startMinute,
    required this.endMinute,
    required this.weeks,
    required this.untilDate,
    this.purpose,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory BookingSeries({
    int? id,
    required int roomId,
    required int userId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    required int weeks,
    required DateTime untilDate,
    String? purpose,
    DateTime? createdAt,
  }) = _BookingSeriesImpl;

  factory BookingSeries.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookingSeries(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as int,
      weekday: jsonSerialization['weekday'] as int,
      startMinute: jsonSerialization['startMinute'] as int,
      endMinute: jsonSerialization['endMinute'] as int,
      weeks: jsonSerialization['weeks'] as int,
      untilDate: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['untilDate'],
      ),
      purpose: jsonSerialization['purpose'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = BookingSeriesTable();

  static const db = BookingSeriesRepository._();

  @override
  int? id;

  int roomId;

  int userId;

  /// 1 = Monday ... 7 = Sunday, in the household time zone.
  int weekday;

  /// Local start, minutes after midnight.
  int startMinute;

  /// Local end, minutes after midnight of the start day (may exceed 1440).
  int endMinute;

  int weeks;

  /// Start of the last occurrence.
  DateTime untilDate;

  String? purpose;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookingSeries]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookingSeries copyWith({
    int? id,
    int? roomId,
    int? userId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    int? weeks,
    DateTime? untilDate,
    String? purpose,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookingSeries',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'weeks': weeks,
      'untilDate': untilDate.toJson(),
      if (purpose != null) 'purpose': purpose,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookingSeries',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'weeks': weeks,
      'untilDate': untilDate.toJson(),
      if (purpose != null) 'purpose': purpose,
      'createdAt': createdAt.toJson(),
    };
  }

  static BookingSeriesInclude include() {
    return BookingSeriesInclude._();
  }

  static BookingSeriesIncludeList includeList({
    _is.WhereExpressionBuilder<BookingSeriesTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingSeriesTable>? orderBy,
    _is.OrderByListBuilder<BookingSeriesTable>? orderByList,
    BookingSeriesInclude? include,
  }) {
    return BookingSeriesIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookingSeries.t),
      orderByList: orderByList?.call(BookingSeries.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingSeriesImpl extends BookingSeries {
  _BookingSeriesImpl({
    int? id,
    required int roomId,
    required int userId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    required int weeks,
    required DateTime untilDate,
    String? purpose,
    DateTime? createdAt,
  }) : super._(
         id: id,
         roomId: roomId,
         userId: userId,
         weekday: weekday,
         startMinute: startMinute,
         endMinute: endMinute,
         weeks: weeks,
         untilDate: untilDate,
         purpose: purpose,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [BookingSeries]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookingSeries copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? userId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    int? weeks,
    DateTime? untilDate,
    Object? purpose = _Undefined,
    DateTime? createdAt,
  }) {
    return BookingSeries(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      weekday: weekday ?? this.weekday,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      weeks: weeks ?? this.weeks,
      untilDate: untilDate ?? this.untilDate,
      purpose: purpose is String? ? purpose : this.purpose,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class BookingSeriesUpdateTable extends _is.UpdateTable<BookingSeriesTable> {
  BookingSeriesUpdateTable(super.table);

  _is.ColumnValue<int, int> roomId(int value) => _is.ColumnValue(
    table.roomId,
    value,
  );

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> weekday(int value) => _is.ColumnValue(
    table.weekday,
    value,
  );

  _is.ColumnValue<int, int> startMinute(int value) => _is.ColumnValue(
    table.startMinute,
    value,
  );

  _is.ColumnValue<int, int> endMinute(int value) => _is.ColumnValue(
    table.endMinute,
    value,
  );

  _is.ColumnValue<int, int> weeks(int value) => _is.ColumnValue(
    table.weeks,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> untilDate(DateTime value) =>
      _is.ColumnValue(
        table.untilDate,
        value,
      );

  _is.ColumnValue<String, String> purpose(String? value) => _is.ColumnValue(
    table.purpose,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class BookingSeriesTable extends _is.Table<int?> {
  BookingSeriesTable({super.tableRelation})
    : super(tableName: 'booking_series') {
    updateTable = BookingSeriesUpdateTable(this);
    roomId = _is.ColumnInt(
      'roomId',
      this,
    );
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    weekday = _is.ColumnInt(
      'weekday',
      this,
    );
    startMinute = _is.ColumnInt(
      'startMinute',
      this,
    );
    endMinute = _is.ColumnInt(
      'endMinute',
      this,
    );
    weeks = _is.ColumnInt(
      'weeks',
      this,
    );
    untilDate = _is.ColumnDateTime(
      'untilDate',
      this,
    );
    purpose = _is.ColumnString(
      'purpose',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final BookingSeriesUpdateTable updateTable;

  late final _is.ColumnInt roomId;

  late final _is.ColumnInt userId;

  /// 1 = Monday ... 7 = Sunday, in the household time zone.
  late final _is.ColumnInt weekday;

  /// Local start, minutes after midnight.
  late final _is.ColumnInt startMinute;

  /// Local end, minutes after midnight of the start day (may exceed 1440).
  late final _is.ColumnInt endMinute;

  late final _is.ColumnInt weeks;

  /// Start of the last occurrence.
  late final _is.ColumnDateTime untilDate;

  late final _is.ColumnString purpose;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    roomId,
    userId,
    weekday,
    startMinute,
    endMinute,
    weeks,
    untilDate,
    purpose,
    createdAt,
  ];
}

class BookingSeriesInclude extends _is.IncludeObject {
  BookingSeriesInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => BookingSeries.t;
}

class BookingSeriesIncludeList extends _is.IncludeList {
  BookingSeriesIncludeList._({
    _is.WhereExpressionBuilder<BookingSeriesTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookingSeries.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BookingSeries.t;
}

class BookingSeriesRepository {
  const BookingSeriesRepository._();

  /// Returns a list of [BookingSeries]s matching the given query parameters.
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
  Future<List<BookingSeries>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingSeriesTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingSeriesTable>? orderBy,
    _is.OrderByListBuilder<BookingSeriesTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookingSeries>(
      where: where?.call(BookingSeries.t),
      orderBy: orderBy?.call(BookingSeries.t),
      orderByList: orderByList?.call(BookingSeries.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BookingSeries] matching the given query parameters.
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
  Future<BookingSeries?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingSeriesTable>? where,
    int? offset,
    _is.OrderByBuilder<BookingSeriesTable>? orderBy,
    _is.OrderByListBuilder<BookingSeriesTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookingSeries>(
      where: where?.call(BookingSeries.t),
      orderBy: orderBy?.call(BookingSeries.t),
      orderByList: orderByList?.call(BookingSeries.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookingSeries] by its [id] or null if no such row exists.
  Future<BookingSeries?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BookingSeries>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BookingSeries]s in the list and returns the inserted rows.
  ///
  /// The returned [BookingSeries]s will have their `id` fields set.
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
  Future<List<BookingSeries>> insert(
    _is.DatabaseSession session,
    List<BookingSeries> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BookingSeries>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BookingSeries] and returns the inserted row.
  ///
  /// The returned [BookingSeries] will have its `id` field set.
  Future<BookingSeries> insertRow(
    _is.DatabaseSession session,
    BookingSeries row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookingSeries>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [BookingSeries]s in the list and returns the resulting rows.
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
  /// The returned [BookingSeries]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookingSeries>> upsert(
    _is.DatabaseSession session,
    List<BookingSeries> rows, {
    required _is.ColumnSelections<BookingSeriesTable> conflictColumns,
    _is.ColumnSelections<BookingSeriesTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingSeriesTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BookingSeries>(
      rows,
      conflictColumns: conflictColumns(BookingSeries.t),
      updateColumns: updateColumns?.call(BookingSeries.t),
      updateWhere: updateWhere?.call(BookingSeries.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BookingSeries] and returns the resulting row.
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
  /// The returned [BookingSeries] will have its `id` field set.
  Future<BookingSeries?> upsertRow(
    _is.DatabaseSession session,
    BookingSeries row, {
    required _is.ColumnSelections<BookingSeriesTable> conflictColumns,
    _is.ColumnSelections<BookingSeriesTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingSeriesTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BookingSeries>(
      row,
      conflictColumns: conflictColumns(BookingSeries.t),
      updateColumns: updateColumns?.call(BookingSeries.t),
      updateWhere: updateWhere?.call(BookingSeries.t),
      transaction: transaction,
    );
  }

  /// Updates all [BookingSeries]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookingSeries>> update(
    _is.DatabaseSession session,
    List<BookingSeries> rows, {
    _is.ColumnSelections<BookingSeriesTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BookingSeries>(
      rows,
      columns: columns?.call(BookingSeries.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BookingSeries]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookingSeries> updateRow(
    _is.DatabaseSession session,
    BookingSeries row, {
    _is.ColumnSelections<BookingSeriesTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookingSeries>(
      row,
      columns: columns?.call(BookingSeries.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookingSeries] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookingSeries?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookingSeriesUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BookingSeries>(
      id,
      columnValues: columnValues(BookingSeries.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookingSeries]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookingSeries>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookingSeriesUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BookingSeriesTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingSeriesTable>? orderBy,
    _is.OrderByListBuilder<BookingSeriesTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BookingSeries>(
      columnValues: columnValues(BookingSeries.t.updateTable),
      where: where(BookingSeries.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookingSeries.t),
      orderByList: orderByList?.call(BookingSeries.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BookingSeries]s in the list and returns the deleted rows.
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
  Future<List<BookingSeries>> delete(
    _is.DatabaseSession session,
    List<BookingSeries> rows, {
    _is.OrderByBuilder<BookingSeriesTable>? orderBy,
    _is.OrderByListBuilder<BookingSeriesTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BookingSeries>(
      rows,
      orderBy: orderBy?.call(BookingSeries.t),
      orderByList: orderByList?.call(BookingSeries.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BookingSeries].
  Future<BookingSeries> deleteRow(
    _is.DatabaseSession session,
    BookingSeries row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookingSeries>(
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
  Future<List<BookingSeries>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingSeriesTable> where,
    _is.OrderByBuilder<BookingSeriesTable>? orderBy,
    _is.OrderByListBuilder<BookingSeriesTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BookingSeries>(
      where: where(BookingSeries.t),
      orderBy: orderBy?.call(BookingSeries.t),
      orderByList: orderByList?.call(BookingSeries.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingSeriesTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BookingSeries>(
      where: where?.call(BookingSeries.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookingSeries] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingSeriesTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookingSeries>(
      where: where(BookingSeries.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
