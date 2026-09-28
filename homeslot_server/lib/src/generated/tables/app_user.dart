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

/// Application-level user profile (table `users` in the SRS ER diagram).
///
/// Linked 1:1 to the Serverpod auth user. When a user deletes their account
/// (PDPA), personal data is erased and [deletedAt] is set, but the row is kept
/// so booking history can still show "former member".
abstract class AppUser
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AppUser._({
    this.id,
    this.authUserId,
    this.email,
    required this.displayName,
    required this.color,
    this.avatarUrl,
    int? reminderMinutes,
    bool? reminderEnabled,
    String? locale,
    this.deletedAt,
    DateTime? createdAt,
  }) : reminderMinutes = reminderMinutes ?? 15,
       reminderEnabled = reminderEnabled ?? true,
       locale = locale ?? 'th',
       createdAt = createdAt ?? DateTime.now();

  factory AppUser({
    int? id,
    _is.UuidValue? authUserId,
    String? email,
    required String displayName,
    required String color,
    String? avatarUrl,
    int? reminderMinutes,
    bool? reminderEnabled,
    String? locale,
    DateTime? deletedAt,
    DateTime? createdAt,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['authUserId'],
            ),
      email: jsonSerialization['email'] as String?,
      displayName: jsonSerialization['displayName'] as String,
      color: jsonSerialization['color'] as String,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      reminderMinutes: jsonSerialization['reminderMinutes'] as int?,
      reminderEnabled: jsonSerialization['reminderEnabled'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['reminderEnabled'],
            ),
      locale: jsonSerialization['locale'] as String?,
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = AppUserTable();

  static const db = AppUserRepository._();

  @override
  int? id;

  /// The Serverpod auth user this profile belongs to. Null once deleted.
  _is.UuidValue? authUserId;

  String? email;

  String displayName;

  /// Personal calendar color as `#RRGGBB`.
  String color;

  String? avatarUrl;

  /// Minutes before a booking starts to send the reminder (5-60).
  int reminderMinutes;

  bool reminderEnabled;

  /// Preferred language for push notification text (`th` or `en`).
  String locale;

  DateTime? deletedAt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AppUser copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? email,
    String? displayName,
    String? color,
    String? avatarUrl,
    int? reminderMinutes,
    bool? reminderEnabled,
    String? locale,
    DateTime? deletedAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (email != null) 'email': email,
      'displayName': displayName,
      'color': color,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'reminderMinutes': reminderMinutes,
      'reminderEnabled': reminderEnabled,
      'locale': locale,
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (email != null) 'email': email,
      'displayName': displayName,
      'color': color,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'reminderMinutes': reminderMinutes,
      'reminderEnabled': reminderEnabled,
      'locale': locale,
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static AppUserInclude include() {
    return AppUserInclude._();
  }

  static AppUserIncludeList includeList({
    _is.WhereExpressionBuilder<AppUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppUserTable>? orderBy,
    _is.OrderByListBuilder<AppUserTable>? orderByList,
    AppUserInclude? include,
  }) {
    return AppUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    int? id,
    _is.UuidValue? authUserId,
    String? email,
    required String displayName,
    required String color,
    String? avatarUrl,
    int? reminderMinutes,
    bool? reminderEnabled,
    String? locale,
    DateTime? deletedAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         email: email,
         displayName: displayName,
         color: color,
         avatarUrl: avatarUrl,
         reminderMinutes: reminderMinutes,
         reminderEnabled: reminderEnabled,
         locale: locale,
         deletedAt: deletedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AppUser copyWith({
    Object? id = _Undefined,
    Object? authUserId = _Undefined,
    Object? email = _Undefined,
    String? displayName,
    String? color,
    Object? avatarUrl = _Undefined,
    int? reminderMinutes,
    bool? reminderEnabled,
    String? locale,
    Object? deletedAt = _Undefined,
    DateTime? createdAt,
  }) {
    return AppUser(
      id: id is int? ? id : this.id,
      authUserId: authUserId is _is.UuidValue? ? authUserId : this.authUserId,
      email: email is String? ? email : this.email,
      displayName: displayName ?? this.displayName,
      color: color ?? this.color,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      locale: locale ?? this.locale,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AppUserUpdateTable extends _is.UpdateTable<AppUserTable> {
  AppUserUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> email(String? value) => _is.ColumnValue(
    table.email,
    value,
  );

  _is.ColumnValue<String, String> displayName(String value) => _is.ColumnValue(
    table.displayName,
    value,
  );

  _is.ColumnValue<String, String> color(String value) => _is.ColumnValue(
    table.color,
    value,
  );

  _is.ColumnValue<String, String> avatarUrl(String? value) => _is.ColumnValue(
    table.avatarUrl,
    value,
  );

  _is.ColumnValue<int, int> reminderMinutes(int value) => _is.ColumnValue(
    table.reminderMinutes,
    value,
  );

  _is.ColumnValue<bool, bool> reminderEnabled(bool value) => _is.ColumnValue(
    table.reminderEnabled,
    value,
  );

  _is.ColumnValue<String, String> locale(String value) => _is.ColumnValue(
    table.locale,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> deletedAt(DateTime? value) =>
      _is.ColumnValue(
        table.deletedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class AppUserTable extends _is.Table<int?> {
  AppUserTable({super.tableRelation}) : super(tableName: 'users') {
    updateTable = AppUserUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    email = _is.ColumnString(
      'email',
      this,
    );
    displayName = _is.ColumnString(
      'displayName',
      this,
    );
    color = _is.ColumnString(
      'color',
      this,
    );
    avatarUrl = _is.ColumnString(
      'avatarUrl',
      this,
    );
    reminderMinutes = _is.ColumnInt(
      'reminderMinutes',
      this,
      hasDefault: true,
    );
    reminderEnabled = _is.ColumnBool(
      'reminderEnabled',
      this,
      hasDefault: true,
    );
    locale = _is.ColumnString(
      'locale',
      this,
      hasDefault: true,
    );
    deletedAt = _is.ColumnDateTime(
      'deletedAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final AppUserUpdateTable updateTable;

  /// The Serverpod auth user this profile belongs to. Null once deleted.
  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString email;

  late final _is.ColumnString displayName;

  /// Personal calendar color as `#RRGGBB`.
  late final _is.ColumnString color;

  late final _is.ColumnString avatarUrl;

  /// Minutes before a booking starts to send the reminder (5-60).
  late final _is.ColumnInt reminderMinutes;

  late final _is.ColumnBool reminderEnabled;

  /// Preferred language for push notification text (`th` or `en`).
  late final _is.ColumnString locale;

  late final _is.ColumnDateTime deletedAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    email,
    displayName,
    color,
    avatarUrl,
    reminderMinutes,
    reminderEnabled,
    locale,
    deletedAt,
    createdAt,
  ];
}

class AppUserInclude extends _is.IncludeObject {
  AppUserInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AppUser.t;
}

class AppUserIncludeList extends _is.IncludeList {
  AppUserIncludeList._({
    _is.WhereExpressionBuilder<AppUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AppUser.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AppUser.t;
}

class AppUserRepository {
  const AppUserRepository._();

  /// Returns a list of [AppUser]s matching the given query parameters.
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
  Future<List<AppUser>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppUserTable>? orderBy,
    _is.OrderByListBuilder<AppUserTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AppUser>(
      where: where?.call(AppUser.t),
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AppUser] matching the given query parameters.
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
  Future<AppUser?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppUserTable>? where,
    int? offset,
    _is.OrderByBuilder<AppUserTable>? orderBy,
    _is.OrderByListBuilder<AppUserTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AppUser>(
      where: where?.call(AppUser.t),
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AppUser] by its [id] or null if no such row exists.
  Future<AppUser?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AppUser>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AppUser]s in the list and returns the inserted rows.
  ///
  /// The returned [AppUser]s will have their `id` fields set.
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
  Future<List<AppUser>> insert(
    _is.DatabaseSession session,
    List<AppUser> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AppUser>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AppUser] and returns the inserted row.
  ///
  /// The returned [AppUser] will have its `id` field set.
  Future<AppUser> insertRow(
    _is.DatabaseSession session,
    AppUser row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AppUser>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AppUser]s in the list and returns the resulting rows.
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
  /// The returned [AppUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppUser>> upsert(
    _is.DatabaseSession session,
    List<AppUser> rows, {
    required _is.ColumnSelections<AppUserTable> conflictColumns,
    _is.ColumnSelections<AppUserTable>? updateColumns,
    _is.WhereExpressionBuilder<AppUserTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AppUser>(
      rows,
      conflictColumns: conflictColumns(AppUser.t),
      updateColumns: updateColumns?.call(AppUser.t),
      updateWhere: updateWhere?.call(AppUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AppUser] and returns the resulting row.
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
  /// The returned [AppUser] will have its `id` field set.
  Future<AppUser?> upsertRow(
    _is.DatabaseSession session,
    AppUser row, {
    required _is.ColumnSelections<AppUserTable> conflictColumns,
    _is.ColumnSelections<AppUserTable>? updateColumns,
    _is.WhereExpressionBuilder<AppUserTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AppUser>(
      row,
      conflictColumns: conflictColumns(AppUser.t),
      updateColumns: updateColumns?.call(AppUser.t),
      updateWhere: updateWhere?.call(AppUser.t),
      transaction: transaction,
    );
  }

  /// Updates all [AppUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppUser>> update(
    _is.DatabaseSession session,
    List<AppUser> rows, {
    _is.ColumnSelections<AppUserTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AppUser>(
      rows,
      columns: columns?.call(AppUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AppUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AppUser> updateRow(
    _is.DatabaseSession session,
    AppUser row, {
    _is.ColumnSelections<AppUserTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AppUser>(
      row,
      columns: columns?.call(AppUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppUser] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AppUser?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AppUserUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AppUser>(
      id,
      columnValues: columnValues(AppUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AppUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppUser>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AppUserUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AppUserTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppUserTable>? orderBy,
    _is.OrderByListBuilder<AppUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AppUser>(
      columnValues: columnValues(AppUser.t.updateTable),
      where: where(AppUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AppUser]s in the list and returns the deleted rows.
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
  Future<List<AppUser>> delete(
    _is.DatabaseSession session,
    List<AppUser> rows, {
    _is.OrderByBuilder<AppUserTable>? orderBy,
    _is.OrderByListBuilder<AppUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AppUser>(
      rows,
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AppUser].
  Future<AppUser> deleteRow(
    _is.DatabaseSession session,
    AppUser row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AppUser>(
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
  Future<List<AppUser>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AppUserTable> where,
    _is.OrderByBuilder<AppUserTable>? orderBy,
    _is.OrderByListBuilder<AppUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AppUser>(
      where: where(AppUser.t),
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppUserTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AppUser>(
      where: where?.call(AppUser.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AppUser] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AppUserTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AppUser>(
      where: where(AppUser.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
