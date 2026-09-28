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
import '../enums/booking_status.dart' as _idgk5z95;

/// A booking of one room by one user. Core table of the system.
///
/// Overlaps are prevented in the database by the `bookings_no_overlap`
/// exclusion constraint (see `lib/src/db/constraints.dart`).
abstract class Booking
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Booking._({
    this.id,
    required this.householdId,
    required this.roomId,
    required this.userId,
    this.seriesId,
    required this.startAt,
    required this.endAt,
    required this.status,
    this.purpose,
    this.note,
    this.decidedById,
    this.rejectReason,
    this.cancelledById,
    this.cancelReason,
    this.releasedAt,
    this.reminderSentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Booking({
    int? id,
    required int householdId,
    required int roomId,
    required int userId,
    int? seriesId,
    required DateTime startAt,
    required DateTime endAt,
    required _idgk5z95.BookingStatus status,
    String? purpose,
    String? note,
    int? decidedById,
    String? rejectReason,
    int? cancelledById,
    String? cancelReason,
    DateTime? releasedAt,
    DateTime? reminderSentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _BookingImpl;

  factory Booking.fromJson(Map<String, dynamic> jsonSerialization) {
    return Booking(
      id: jsonSerialization['id'] as int?,
      householdId: jsonSerialization['householdId'] as int,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as int,
      seriesId: jsonSerialization['seriesId'] as int?,
      startAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['startAt']),
      endAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['endAt']),
      status: _idgk5z95.BookingStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      purpose: jsonSerialization['purpose'] as String?,
      note: jsonSerialization['note'] as String?,
      decidedById: jsonSerialization['decidedById'] as int?,
      rejectReason: jsonSerialization['rejectReason'] as String?,
      cancelledById: jsonSerialization['cancelledById'] as int?,
      cancelReason: jsonSerialization['cancelReason'] as String?,
      releasedAt: jsonSerialization['releasedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['releasedAt']),
      reminderSentAt: jsonSerialization['reminderSentAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['reminderSentAt'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = BookingTable();

  static const db = BookingRepository._();

  @override
  int? id;

  int householdId;

  int roomId;

  int userId;

  int? seriesId;

  DateTime startAt;

  /// Changed to the release time when the room is released early.
  DateTime endAt;

  _idgk5z95.BookingStatus status;

  String? purpose;

  String? note;

  /// Owner who approved or rejected the request.
  int? decidedById;

  String? rejectReason;

  /// Who cancelled the booking, when it was not the booker.
  int? cancelledById;

  String? cancelReason;

  DateTime? releasedAt;

  DateTime? reminderSentAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Booking copyWith({
    int? id,
    int? householdId,
    int? roomId,
    int? userId,
    int? seriesId,
    DateTime? startAt,
    DateTime? endAt,
    _idgk5z95.BookingStatus? status,
    String? purpose,
    String? note,
    int? decidedById,
    String? rejectReason,
    int? cancelledById,
    String? cancelReason,
    DateTime? releasedAt,
    DateTime? reminderSentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Booking',
      if (id != null) 'id': id,
      'householdId': householdId,
      'roomId': roomId,
      'userId': userId,
      if (seriesId != null) 'seriesId': seriesId,
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      'status': status.toJson(),
      if (purpose != null) 'purpose': purpose,
      if (note != null) 'note': note,
      if (decidedById != null) 'decidedById': decidedById,
      if (rejectReason != null) 'rejectReason': rejectReason,
      if (cancelledById != null) 'cancelledById': cancelledById,
      if (cancelReason != null) 'cancelReason': cancelReason,
      if (releasedAt != null) 'releasedAt': releasedAt?.toJson(),
      if (reminderSentAt != null) 'reminderSentAt': reminderSentAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Booking',
      if (id != null) 'id': id,
      'householdId': householdId,
      'roomId': roomId,
      'userId': userId,
      if (seriesId != null) 'seriesId': seriesId,
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      'status': status.toJson(),
      if (purpose != null) 'purpose': purpose,
      if (note != null) 'note': note,
      if (decidedById != null) 'decidedById': decidedById,
      if (rejectReason != null) 'rejectReason': rejectReason,
      if (cancelledById != null) 'cancelledById': cancelledById,
      if (cancelReason != null) 'cancelReason': cancelReason,
      if (releasedAt != null) 'releasedAt': releasedAt?.toJson(),
      if (reminderSentAt != null) 'reminderSentAt': reminderSentAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static BookingInclude include() {
    return BookingInclude._();
  }

  static BookingIncludeList includeList({
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    BookingInclude? include,
  }) {
    return BookingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingImpl extends Booking {
  _BookingImpl({
    int? id,
    required int householdId,
    required int roomId,
    required int userId,
    int? seriesId,
    required DateTime startAt,
    required DateTime endAt,
    required _idgk5z95.BookingStatus status,
    String? purpose,
    String? note,
    int? decidedById,
    String? rejectReason,
    int? cancelledById,
    String? cancelReason,
    DateTime? releasedAt,
    DateTime? reminderSentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         householdId: householdId,
         roomId: roomId,
         userId: userId,
         seriesId: seriesId,
         startAt: startAt,
         endAt: endAt,
         status: status,
         purpose: purpose,
         note: note,
         decidedById: decidedById,
         rejectReason: rejectReason,
         cancelledById: cancelledById,
         cancelReason: cancelReason,
         releasedAt: releasedAt,
         reminderSentAt: reminderSentAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Booking copyWith({
    Object? id = _Undefined,
    int? householdId,
    int? roomId,
    int? userId,
    Object? seriesId = _Undefined,
    DateTime? startAt,
    DateTime? endAt,
    _idgk5z95.BookingStatus? status,
    Object? purpose = _Undefined,
    Object? note = _Undefined,
    Object? decidedById = _Undefined,
    Object? rejectReason = _Undefined,
    Object? cancelledById = _Undefined,
    Object? cancelReason = _Undefined,
    Object? releasedAt = _Undefined,
    Object? reminderSentAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Booking(
      id: id is int? ? id : this.id,
      householdId: householdId ?? this.householdId,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      seriesId: seriesId is int? ? seriesId : this.seriesId,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      status: status ?? this.status,
      purpose: purpose is String? ? purpose : this.purpose,
      note: note is String? ? note : this.note,
      decidedById: decidedById is int? ? decidedById : this.decidedById,
      rejectReason: rejectReason is String? ? rejectReason : this.rejectReason,
      cancelledById: cancelledById is int? ? cancelledById : this.cancelledById,
      cancelReason: cancelReason is String? ? cancelReason : this.cancelReason,
      releasedAt: releasedAt is DateTime? ? releasedAt : this.releasedAt,
      reminderSentAt: reminderSentAt is DateTime?
          ? reminderSentAt
          : this.reminderSentAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class BookingUpdateTable extends _is.UpdateTable<BookingTable> {
  BookingUpdateTable(super.table);

  _is.ColumnValue<int, int> householdId(int value) => _is.ColumnValue(
    table.householdId,
    value,
  );

  _is.ColumnValue<int, int> roomId(int value) => _is.ColumnValue(
    table.roomId,
    value,
  );

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> seriesId(int? value) => _is.ColumnValue(
    table.seriesId,
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

  _is.ColumnValue<_idgk5z95.BookingStatus, _idgk5z95.BookingStatus> status(
    _idgk5z95.BookingStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> purpose(String? value) => _is.ColumnValue(
    table.purpose,
    value,
  );

  _is.ColumnValue<String, String> note(String? value) => _is.ColumnValue(
    table.note,
    value,
  );

  _is.ColumnValue<int, int> decidedById(int? value) => _is.ColumnValue(
    table.decidedById,
    value,
  );

  _is.ColumnValue<String, String> rejectReason(String? value) =>
      _is.ColumnValue(
        table.rejectReason,
        value,
      );

  _is.ColumnValue<int, int> cancelledById(int? value) => _is.ColumnValue(
    table.cancelledById,
    value,
  );

  _is.ColumnValue<String, String> cancelReason(String? value) =>
      _is.ColumnValue(
        table.cancelReason,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> releasedAt(DateTime? value) =>
      _is.ColumnValue(
        table.releasedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> reminderSentAt(DateTime? value) =>
      _is.ColumnValue(
        table.reminderSentAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class BookingTable extends _is.Table<int?> {
  BookingTable({super.tableRelation}) : super(tableName: 'bookings') {
    updateTable = BookingUpdateTable(this);
    householdId = _is.ColumnInt(
      'householdId',
      this,
    );
    roomId = _is.ColumnInt(
      'roomId',
      this,
    );
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    seriesId = _is.ColumnInt(
      'seriesId',
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
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    purpose = _is.ColumnString(
      'purpose',
      this,
    );
    note = _is.ColumnString(
      'note',
      this,
    );
    decidedById = _is.ColumnInt(
      'decidedById',
      this,
    );
    rejectReason = _is.ColumnString(
      'rejectReason',
      this,
    );
    cancelledById = _is.ColumnInt(
      'cancelledById',
      this,
    );
    cancelReason = _is.ColumnString(
      'cancelReason',
      this,
    );
    releasedAt = _is.ColumnDateTime(
      'releasedAt',
      this,
    );
    reminderSentAt = _is.ColumnDateTime(
      'reminderSentAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final BookingUpdateTable updateTable;

  late final _is.ColumnInt householdId;

  late final _is.ColumnInt roomId;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt seriesId;

  late final _is.ColumnDateTime startAt;

  /// Changed to the release time when the room is released early.
  late final _is.ColumnDateTime endAt;

  late final _is.ColumnEnum<_idgk5z95.BookingStatus> status;

  late final _is.ColumnString purpose;

  late final _is.ColumnString note;

  /// Owner who approved or rejected the request.
  late final _is.ColumnInt decidedById;

  late final _is.ColumnString rejectReason;

  /// Who cancelled the booking, when it was not the booker.
  late final _is.ColumnInt cancelledById;

  late final _is.ColumnString cancelReason;

  late final _is.ColumnDateTime releasedAt;

  late final _is.ColumnDateTime reminderSentAt;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    householdId,
    roomId,
    userId,
    seriesId,
    startAt,
    endAt,
    status,
    purpose,
    note,
    decidedById,
    rejectReason,
    cancelledById,
    cancelReason,
    releasedAt,
    reminderSentAt,
    createdAt,
    updatedAt,
  ];
}

class BookingInclude extends _is.IncludeObject {
  BookingInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Booking.t;
}

class BookingIncludeList extends _is.IncludeList {
  BookingIncludeList._({
    _is.WhereExpressionBuilder<BookingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Booking.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Booking.t;
}

class BookingRepository {
  const BookingRepository._();

  /// Returns a list of [Booking]s matching the given query parameters.
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
  Future<List<Booking>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Booking>(
      where: where?.call(Booking.t),
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Booking] matching the given query parameters.
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
  Future<Booking?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Booking>(
      where: where?.call(Booking.t),
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Booking] by its [id] or null if no such row exists.
  Future<Booking?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Booking>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Booking]s in the list and returns the inserted rows.
  ///
  /// The returned [Booking]s will have their `id` fields set.
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
  Future<List<Booking>> insert(
    _is.DatabaseSession session,
    List<Booking> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Booking>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Booking] and returns the inserted row.
  ///
  /// The returned [Booking] will have its `id` field set.
  Future<Booking> insertRow(
    _is.DatabaseSession session,
    Booking row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Booking>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Booking]s in the list and returns the resulting rows.
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
  /// The returned [Booking]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Booking>> upsert(
    _is.DatabaseSession session,
    List<Booking> rows, {
    required _is.ColumnSelections<BookingTable> conflictColumns,
    _is.ColumnSelections<BookingTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Booking>(
      rows,
      conflictColumns: conflictColumns(Booking.t),
      updateColumns: updateColumns?.call(Booking.t),
      updateWhere: updateWhere?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Booking] and returns the resulting row.
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
  /// The returned [Booking] will have its `id` field set.
  Future<Booking?> upsertRow(
    _is.DatabaseSession session,
    Booking row, {
    required _is.ColumnSelections<BookingTable> conflictColumns,
    _is.ColumnSelections<BookingTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Booking>(
      row,
      conflictColumns: conflictColumns(Booking.t),
      updateColumns: updateColumns?.call(Booking.t),
      updateWhere: updateWhere?.call(Booking.t),
      transaction: transaction,
    );
  }

  /// Updates all [Booking]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Booking>> update(
    _is.DatabaseSession session,
    List<Booking> rows, {
    _is.ColumnSelections<BookingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Booking>(
      rows,
      columns: columns?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Booking]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Booking> updateRow(
    _is.DatabaseSession session,
    Booking row, {
    _is.ColumnSelections<BookingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Booking>(
      row,
      columns: columns?.call(Booking.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Booking] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Booking?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Booking>(
      id,
      columnValues: columnValues(Booking.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Booking]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Booking>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BookingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Booking>(
      columnValues: columnValues(Booking.t.updateTable),
      where: where(Booking.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Booking]s in the list and returns the deleted rows.
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
  Future<List<Booking>> delete(
    _is.DatabaseSession session,
    List<Booking> rows, {
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Booking>(
      rows,
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Booking].
  Future<Booking> deleteRow(
    _is.DatabaseSession session,
    Booking row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Booking>(
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
  Future<List<Booking>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingTable> where,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Booking>(
      where: where(Booking.t),
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Booking>(
      where: where?.call(Booking.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Booking] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Booking>(
      where: where(Booking.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
