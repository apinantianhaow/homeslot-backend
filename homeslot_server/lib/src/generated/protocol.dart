/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:homeslot_server/src/generated/dto/booking_view.dart'
    as _iq1afkun;
import 'package:homeslot_server/src/generated/dto/member_info.dart'
    as _i27s71a0;
import 'package:homeslot_server/src/generated/dto/room_detail.dart'
    as _i3ny064f;
import 'package:homeslot_server/src/generated/dto/room_status.dart'
    as _igrbpelp;
import 'package:homeslot_server/src/generated/dto/series_occurrence.dart'
    as _id8f59ik;
import 'package:homeslot_server/src/generated/dto/time_slot.dart' as _ict5rtcm;
import 'package:homeslot_server/src/generated/tables/app_notification.dart'
    as _i4mlqc0y;
import 'package:homeslot_server/src/generated/tables/invitation.dart'
    as _iqa5hkvg;
import 'package:homeslot_server/src/generated/tables/room_hours.dart'
    as _i3dfjhwo;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'dto/app_exception.dart' as _i2bomax4;
import 'dto/booking_exception.dart' as _iwj0eyzc;
import 'dto/booking_request.dart' as _isjupa8c;
import 'dto/booking_view.dart' as _imwypi3s;
import 'dto/daily_usage.dart' as _ifjcum2y;
import 'dto/household_event.dart' as _icqqh3tk;
import 'dto/me_info.dart' as _iwopsbei;
import 'dto/member_info.dart' as _iim79ks6;
import 'dto/peak_hours.dart' as _ia33gi2d;
import 'dto/room_detail.dart' as _i2q5p93n;
import 'dto/room_status.dart' as _ig25z30n;
import 'dto/series_occurrence.dart' as _ie893o67;
import 'dto/series_request.dart' as _ixpeu2zq;
import 'dto/time_slot.dart' as _iomuimzj;
import 'dto/upload_ticket.dart' as _i0ulrzc8;
import 'dto/usage_entry.dart' as _ifuy3au4;
import 'dto/usage_stats.dart' as _i5j36xpc;
import 'enums/app_error_code.dart' as _ix5xerl7;
import 'enums/booking_error_code.dart' as _id5wbqdr;
import 'enums/booking_status.dart' as _i75mj084;
import 'enums/edit_scope.dart' as _ilbz46ft;
import 'enums/household_event_type.dart' as _ieptqvya;
import 'enums/member_role.dart' as _icimtxba;
import 'enums/notification_type.dart' as _ij5x7qg1;
import 'enums/room_type.dart' as _iuqv4u9g;
import 'enums/stats_period.dart' as _ikitw31k;
import 'tables/app_notification.dart' as _iavhcq44;
import 'tables/app_user.dart' as _ixkbjq1f;
import 'tables/booking.dart' as _iahyoybt;
import 'tables/booking_series.dart' as _iy10bu26;
import 'tables/device_token.dart' as _ilmi8bdd;
import 'tables/household.dart' as _i2hqha2j;
import 'tables/household_member.dart' as _io5ke34u;
import 'tables/invitation.dart' as _ilu35nbv;
import 'tables/invite_attempt.dart' as _i6ut1p8z;
import 'tables/room.dart' as _ie9hxdgh;
import 'tables/room_closure.dart' as _isdv16rb;
import 'tables/room_hours.dart' as _ikqn1k4z;
export 'dto/app_exception.dart';
export 'dto/booking_exception.dart';
export 'dto/booking_request.dart';
export 'dto/booking_view.dart';
export 'dto/daily_usage.dart';
export 'dto/household_event.dart';
export 'dto/me_info.dart';
export 'dto/member_info.dart';
export 'dto/peak_hours.dart';
export 'dto/room_detail.dart';
export 'dto/room_status.dart';
export 'dto/series_occurrence.dart';
export 'dto/series_request.dart';
export 'dto/time_slot.dart';
export 'dto/upload_ticket.dart';
export 'dto/usage_entry.dart';
export 'dto/usage_stats.dart';
export 'enums/app_error_code.dart';
export 'enums/booking_error_code.dart';
export 'enums/booking_status.dart';
export 'enums/edit_scope.dart';
export 'enums/household_event_type.dart';
export 'enums/member_role.dart';
export 'enums/notification_type.dart';
export 'enums/room_type.dart';
export 'enums/stats_period.dart';
export 'tables/app_notification.dart';
export 'tables/app_user.dart';
export 'tables/booking.dart';
export 'tables/booking_series.dart';
export 'tables/device_token.dart';
export 'tables/household.dart';
export 'tables/household_member.dart';
export 'tables/invitation.dart';
export 'tables/invite_attempt.dart';
export 'tables/room.dart';
export 'tables/room_closure.dart';
export 'tables/room_hours.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'booking_series',
      dartName: 'BookingSeries',
      schema: 'public',
      module: 'homeslot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'roomId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'weekday',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'startMinute',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'endMinute',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'weeks',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'untilDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'purpose',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'booking_series_fk_0',
          columns: ['roomId'],
          referenceTable: 'rooms',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'booking_series_fk_1',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'bookings',
      dartName: 'Booking',
      schema: 'public',
      module: 'homeslot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'householdId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'roomId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'seriesId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'startAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'endAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:BookingStatus',
        ),
        _isp.ColumnDefinition(
          name: 'purpose',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'note',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'decidedById',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'rejectReason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'cancelledById',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'cancelReason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'releasedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'reminderSentAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'bookings_fk_0',
          columns: ['householdId'],
          referenceTable: 'households',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'bookings_fk_1',
          columns: ['roomId'],
          referenceTable: 'rooms',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'bookings_fk_2',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'bookings_fk_3',
          columns: ['seriesId'],
          referenceTable: 'booking_series',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'bookings_room_start_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'roomId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'startAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'bookings_user_start_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'startAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'bookings_household_start_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'householdId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'startAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'bookings_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'device_tokens',
      dartName: 'DeviceToken',
      schema: 'public',
      module: 'homeslot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'token',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'platform',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'device_tokens_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'device_tokens_token_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'token',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'device_tokens_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'household_members',
      dartName: 'HouseholdMember',
      schema: 'public',
      module: 'homeslot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'householdId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MemberRole',
        ),
        _isp.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'household_members_fk_0',
          columns: ['householdId'],
          referenceTable: 'households',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'household_members_fk_1',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'household_members_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'household_members_household_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'householdId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'households',
      dartName: 'Household',
      schema: 'public',
      module: 'homeslot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'timezone',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'Asia/Bangkok\'',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'invitations',
      dartName: 'Invitation',
      schema: 'public',
      module: 'homeslot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'code',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'householdId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdById',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'revokedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'invitations_fk_0',
          columns: ['householdId'],
          referenceTable: 'households',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'invitations_fk_1',
          columns: ['createdById'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'invitations_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'invitations_household_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'householdId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'invite_attempts',
      dartName: 'InviteAttempt',
      schema: 'public',
      module: 'homeslot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'success',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'attemptedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'invite_attempts_user_time_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'attemptedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'notifications',
      dartName: 'AppNotification',
      schema: 'public',
      module: 'homeslot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'householdId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:NotificationType',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'body',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'bookingId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'readAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'notifications_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'notifications_user_created_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'room_closures',
      dartName: 'RoomClosure',
      schema: 'public',
      module: 'homeslot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'roomId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'startAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'endAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'reason',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdById',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'room_closures_fk_0',
          columns: ['roomId'],
          referenceTable: 'rooms',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'room_closures_room_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'roomId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'startAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'room_hours',
      dartName: 'RoomHours',
      schema: 'public',
      module: 'homeslot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'roomId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'weekday',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'openMinute',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'closeMinute',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'room_hours_fk_0',
          columns: ['roomId'],
          referenceTable: 'rooms',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'room_hours_room_weekday_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'roomId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'weekday',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'rooms',
      dartName: 'Room',
      schema: 'public',
      module: 'homeslot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'householdId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RoomType',
        ),
        _isp.ColumnDefinition(
          name: 'imageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'capacity',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'requiresApproval',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'slotMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '15',
        ),
        _isp.ColumnDefinition(
          name: 'minMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '30',
        ),
        _isp.ColumnDefinition(
          name: 'maxMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '240',
        ),
        _isp.ColumnDefinition(
          name: 'advanceDays',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '30',
        ),
        _isp.ColumnDefinition(
          name: 'weeklyQuotaMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sortOrder',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'rooms_fk_0',
          columns: ['householdId'],
          referenceTable: 'households',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'rooms_household_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'householdId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'users',
      dartName: 'AppUser',
      schema: 'public',
      module: 'homeslot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'color',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'avatarUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'reminderMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '15',
        ),
        _isp.ColumnDefinition(
          name: 'reminderEnabled',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'locale',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'th\'',
        ),
        _isp.ColumnDefinition(
          name: 'deletedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'users_auth_user_id_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'users_email_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2bomax4.AppException) {
      return _i2bomax4.AppException.fromJson(data) as T;
    }
    if (t == _iwj0eyzc.BookingException) {
      return _iwj0eyzc.BookingException.fromJson(data) as T;
    }
    if (t == _isjupa8c.BookingRequest) {
      return _isjupa8c.BookingRequest.fromJson(data) as T;
    }
    if (t == _imwypi3s.BookingView) {
      return _imwypi3s.BookingView.fromJson(data) as T;
    }
    if (t == _ifjcum2y.DailyUsage) {
      return _ifjcum2y.DailyUsage.fromJson(data) as T;
    }
    if (t == _icqqh3tk.HouseholdEvent) {
      return _icqqh3tk.HouseholdEvent.fromJson(data) as T;
    }
    if (t == _iwopsbei.MeInfo) {
      return _iwopsbei.MeInfo.fromJson(data) as T;
    }
    if (t == _iim79ks6.MemberInfo) {
      return _iim79ks6.MemberInfo.fromJson(data) as T;
    }
    if (t == _ia33gi2d.PeakHours) {
      return _ia33gi2d.PeakHours.fromJson(data) as T;
    }
    if (t == _i2q5p93n.RoomDetail) {
      return _i2q5p93n.RoomDetail.fromJson(data) as T;
    }
    if (t == _ig25z30n.RoomStatus) {
      return _ig25z30n.RoomStatus.fromJson(data) as T;
    }
    if (t == _ie893o67.SeriesOccurrence) {
      return _ie893o67.SeriesOccurrence.fromJson(data) as T;
    }
    if (t == _ixpeu2zq.SeriesRequest) {
      return _ixpeu2zq.SeriesRequest.fromJson(data) as T;
    }
    if (t == _iomuimzj.TimeSlot) {
      return _iomuimzj.TimeSlot.fromJson(data) as T;
    }
    if (t == _i0ulrzc8.UploadTicket) {
      return _i0ulrzc8.UploadTicket.fromJson(data) as T;
    }
    if (t == _ifuy3au4.UsageEntry) {
      return _ifuy3au4.UsageEntry.fromJson(data) as T;
    }
    if (t == _i5j36xpc.UsageStats) {
      return _i5j36xpc.UsageStats.fromJson(data) as T;
    }
    if (t == _ix5xerl7.AppErrorCode) {
      return _ix5xerl7.AppErrorCode.fromJson(data) as T;
    }
    if (t == _id5wbqdr.BookingErrorCode) {
      return _id5wbqdr.BookingErrorCode.fromJson(data) as T;
    }
    if (t == _i75mj084.BookingStatus) {
      return _i75mj084.BookingStatus.fromJson(data) as T;
    }
    if (t == _ilbz46ft.EditScope) {
      return _ilbz46ft.EditScope.fromJson(data) as T;
    }
    if (t == _ieptqvya.HouseholdEventType) {
      return _ieptqvya.HouseholdEventType.fromJson(data) as T;
    }
    if (t == _icimtxba.MemberRole) {
      return _icimtxba.MemberRole.fromJson(data) as T;
    }
    if (t == _ij5x7qg1.NotificationType) {
      return _ij5x7qg1.NotificationType.fromJson(data) as T;
    }
    if (t == _iuqv4u9g.RoomType) {
      return _iuqv4u9g.RoomType.fromJson(data) as T;
    }
    if (t == _ikitw31k.StatsPeriod) {
      return _ikitw31k.StatsPeriod.fromJson(data) as T;
    }
    if (t == _iavhcq44.AppNotification) {
      return _iavhcq44.AppNotification.fromJson(data) as T;
    }
    if (t == _ixkbjq1f.AppUser) {
      return _ixkbjq1f.AppUser.fromJson(data) as T;
    }
    if (t == _iahyoybt.Booking) {
      return _iahyoybt.Booking.fromJson(data) as T;
    }
    if (t == _iy10bu26.BookingSeries) {
      return _iy10bu26.BookingSeries.fromJson(data) as T;
    }
    if (t == _ilmi8bdd.DeviceToken) {
      return _ilmi8bdd.DeviceToken.fromJson(data) as T;
    }
    if (t == _i2hqha2j.Household) {
      return _i2hqha2j.Household.fromJson(data) as T;
    }
    if (t == _io5ke34u.HouseholdMember) {
      return _io5ke34u.HouseholdMember.fromJson(data) as T;
    }
    if (t == _ilu35nbv.Invitation) {
      return _ilu35nbv.Invitation.fromJson(data) as T;
    }
    if (t == _i6ut1p8z.InviteAttempt) {
      return _i6ut1p8z.InviteAttempt.fromJson(data) as T;
    }
    if (t == _ie9hxdgh.Room) {
      return _ie9hxdgh.Room.fromJson(data) as T;
    }
    if (t == _isdv16rb.RoomClosure) {
      return _isdv16rb.RoomClosure.fromJson(data) as T;
    }
    if (t == _ikqn1k4z.RoomHours) {
      return _ikqn1k4z.RoomHours.fromJson(data) as T;
    }
    if (t == _is.getType<_i2bomax4.AppException?>()) {
      return (data != null ? _i2bomax4.AppException.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwj0eyzc.BookingException?>()) {
      return (data != null ? _iwj0eyzc.BookingException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_isjupa8c.BookingRequest?>()) {
      return (data != null ? _isjupa8c.BookingRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_imwypi3s.BookingView?>()) {
      return (data != null ? _imwypi3s.BookingView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifjcum2y.DailyUsage?>()) {
      return (data != null ? _ifjcum2y.DailyUsage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_icqqh3tk.HouseholdEvent?>()) {
      return (data != null ? _icqqh3tk.HouseholdEvent.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iwopsbei.MeInfo?>()) {
      return (data != null ? _iwopsbei.MeInfo.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iim79ks6.MemberInfo?>()) {
      return (data != null ? _iim79ks6.MemberInfo.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ia33gi2d.PeakHours?>()) {
      return (data != null ? _ia33gi2d.PeakHours.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i2q5p93n.RoomDetail?>()) {
      return (data != null ? _i2q5p93n.RoomDetail.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ig25z30n.RoomStatus?>()) {
      return (data != null ? _ig25z30n.RoomStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ie893o67.SeriesOccurrence?>()) {
      return (data != null ? _ie893o67.SeriesOccurrence.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixpeu2zq.SeriesRequest?>()) {
      return (data != null ? _ixpeu2zq.SeriesRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iomuimzj.TimeSlot?>()) {
      return (data != null ? _iomuimzj.TimeSlot.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i0ulrzc8.UploadTicket?>()) {
      return (data != null ? _i0ulrzc8.UploadTicket.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifuy3au4.UsageEntry?>()) {
      return (data != null ? _ifuy3au4.UsageEntry.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5j36xpc.UsageStats?>()) {
      return (data != null ? _i5j36xpc.UsageStats.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ix5xerl7.AppErrorCode?>()) {
      return (data != null ? _ix5xerl7.AppErrorCode.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_id5wbqdr.BookingErrorCode?>()) {
      return (data != null ? _id5wbqdr.BookingErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i75mj084.BookingStatus?>()) {
      return (data != null ? _i75mj084.BookingStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ilbz46ft.EditScope?>()) {
      return (data != null ? _ilbz46ft.EditScope.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ieptqvya.HouseholdEventType?>()) {
      return (data != null ? _ieptqvya.HouseholdEventType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_icimtxba.MemberRole?>()) {
      return (data != null ? _icimtxba.MemberRole.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ij5x7qg1.NotificationType?>()) {
      return (data != null ? _ij5x7qg1.NotificationType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iuqv4u9g.RoomType?>()) {
      return (data != null ? _iuqv4u9g.RoomType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikitw31k.StatsPeriod?>()) {
      return (data != null ? _ikitw31k.StatsPeriod.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iavhcq44.AppNotification?>()) {
      return (data != null ? _iavhcq44.AppNotification.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixkbjq1f.AppUser?>()) {
      return (data != null ? _ixkbjq1f.AppUser.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iahyoybt.Booking?>()) {
      return (data != null ? _iahyoybt.Booking.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iy10bu26.BookingSeries?>()) {
      return (data != null ? _iy10bu26.BookingSeries.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ilmi8bdd.DeviceToken?>()) {
      return (data != null ? _ilmi8bdd.DeviceToken.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i2hqha2j.Household?>()) {
      return (data != null ? _i2hqha2j.Household.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_io5ke34u.HouseholdMember?>()) {
      return (data != null ? _io5ke34u.HouseholdMember.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ilu35nbv.Invitation?>()) {
      return (data != null ? _ilu35nbv.Invitation.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i6ut1p8z.InviteAttempt?>()) {
      return (data != null ? _i6ut1p8z.InviteAttempt.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ie9hxdgh.Room?>()) {
      return (data != null ? _ie9hxdgh.Room.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_isdv16rb.RoomClosure?>()) {
      return (data != null ? _isdv16rb.RoomClosure.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikqn1k4z.RoomHours?>()) {
      return (data != null ? _ikqn1k4z.RoomHours.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_ikqn1k4z.RoomHours>) {
      return (data as List)
              .map((e) => deserialize<_ikqn1k4z.RoomHours>(e))
              .toList()
          as T;
    }
    if (t == List<_isdv16rb.RoomClosure>) {
      return (data as List)
              .map((e) => deserialize<_isdv16rb.RoomClosure>(e))
              .toList()
          as T;
    }
    if (t == List<DateTime>) {
      return (data as List).map((e) => deserialize<DateTime>(e)).toList() as T;
    }
    if (t == List<_ifuy3au4.UsageEntry>) {
      return (data as List)
              .map((e) => deserialize<_ifuy3au4.UsageEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_ifjcum2y.DailyUsage>) {
      return (data as List)
              .map((e) => deserialize<_ifjcum2y.DailyUsage>(e))
              .toList()
          as T;
    }
    if (t == List<_iq1afkun.BookingView>) {
      return (data as List)
              .map((e) => deserialize<_iq1afkun.BookingView>(e))
              .toList()
          as T;
    }
    if (t == List<_ict5rtcm.TimeSlot>) {
      return (data as List)
              .map((e) => deserialize<_ict5rtcm.TimeSlot>(e))
              .toList()
          as T;
    }
    if (t == List<_id8f59ik.SeriesOccurrence>) {
      return (data as List)
              .map((e) => deserialize<_id8f59ik.SeriesOccurrence>(e))
              .toList()
          as T;
    }
    if (t == List<_i27s71a0.MemberInfo>) {
      return (data as List)
              .map((e) => deserialize<_i27s71a0.MemberInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_iqa5hkvg.Invitation>) {
      return (data as List)
              .map((e) => deserialize<_iqa5hkvg.Invitation>(e))
              .toList()
          as T;
    }
    if (t == List<_i4mlqc0y.AppNotification>) {
      return (data as List)
              .map((e) => deserialize<_i4mlqc0y.AppNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i3ny064f.RoomDetail>) {
      return (data as List)
              .map((e) => deserialize<_i3ny064f.RoomDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_igrbpelp.RoomStatus>) {
      return (data as List)
              .map((e) => deserialize<_igrbpelp.RoomStatus>(e))
              .toList()
          as T;
    }
    if (t == List<_i3dfjhwo.RoomHours>) {
      return (data as List)
              .map((e) => deserialize<_i3dfjhwo.RoomHours>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2bomax4.AppException => 'AppException',
      _iwj0eyzc.BookingException => 'BookingException',
      _isjupa8c.BookingRequest => 'BookingRequest',
      _imwypi3s.BookingView => 'BookingView',
      _ifjcum2y.DailyUsage => 'DailyUsage',
      _icqqh3tk.HouseholdEvent => 'HouseholdEvent',
      _iwopsbei.MeInfo => 'MeInfo',
      _iim79ks6.MemberInfo => 'MemberInfo',
      _ia33gi2d.PeakHours => 'PeakHours',
      _i2q5p93n.RoomDetail => 'RoomDetail',
      _ig25z30n.RoomStatus => 'RoomStatus',
      _ie893o67.SeriesOccurrence => 'SeriesOccurrence',
      _ixpeu2zq.SeriesRequest => 'SeriesRequest',
      _iomuimzj.TimeSlot => 'TimeSlot',
      _i0ulrzc8.UploadTicket => 'UploadTicket',
      _ifuy3au4.UsageEntry => 'UsageEntry',
      _i5j36xpc.UsageStats => 'UsageStats',
      _ix5xerl7.AppErrorCode => 'AppErrorCode',
      _id5wbqdr.BookingErrorCode => 'BookingErrorCode',
      _i75mj084.BookingStatus => 'BookingStatus',
      _ilbz46ft.EditScope => 'EditScope',
      _ieptqvya.HouseholdEventType => 'HouseholdEventType',
      _icimtxba.MemberRole => 'MemberRole',
      _ij5x7qg1.NotificationType => 'NotificationType',
      _iuqv4u9g.RoomType => 'RoomType',
      _ikitw31k.StatsPeriod => 'StatsPeriod',
      _iavhcq44.AppNotification => 'AppNotification',
      _ixkbjq1f.AppUser => 'AppUser',
      _iahyoybt.Booking => 'Booking',
      _iy10bu26.BookingSeries => 'BookingSeries',
      _ilmi8bdd.DeviceToken => 'DeviceToken',
      _i2hqha2j.Household => 'Household',
      _io5ke34u.HouseholdMember => 'HouseholdMember',
      _ilu35nbv.Invitation => 'Invitation',
      _i6ut1p8z.InviteAttempt => 'InviteAttempt',
      _ie9hxdgh.Room => 'Room',
      _isdv16rb.RoomClosure => 'RoomClosure',
      _ikqn1k4z.RoomHours => 'RoomHours',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('homeslot.', '');
    }

    switch (data) {
      case _i2bomax4.AppException():
        return 'AppException';
      case _iwj0eyzc.BookingException():
        return 'BookingException';
      case _isjupa8c.BookingRequest():
        return 'BookingRequest';
      case _imwypi3s.BookingView():
        return 'BookingView';
      case _ifjcum2y.DailyUsage():
        return 'DailyUsage';
      case _icqqh3tk.HouseholdEvent():
        return 'HouseholdEvent';
      case _iwopsbei.MeInfo():
        return 'MeInfo';
      case _iim79ks6.MemberInfo():
        return 'MemberInfo';
      case _ia33gi2d.PeakHours():
        return 'PeakHours';
      case _i2q5p93n.RoomDetail():
        return 'RoomDetail';
      case _ig25z30n.RoomStatus():
        return 'RoomStatus';
      case _ie893o67.SeriesOccurrence():
        return 'SeriesOccurrence';
      case _ixpeu2zq.SeriesRequest():
        return 'SeriesRequest';
      case _iomuimzj.TimeSlot():
        return 'TimeSlot';
      case _i0ulrzc8.UploadTicket():
        return 'UploadTicket';
      case _ifuy3au4.UsageEntry():
        return 'UsageEntry';
      case _i5j36xpc.UsageStats():
        return 'UsageStats';
      case _ix5xerl7.AppErrorCode():
        return 'AppErrorCode';
      case _id5wbqdr.BookingErrorCode():
        return 'BookingErrorCode';
      case _i75mj084.BookingStatus():
        return 'BookingStatus';
      case _ilbz46ft.EditScope():
        return 'EditScope';
      case _ieptqvya.HouseholdEventType():
        return 'HouseholdEventType';
      case _icimtxba.MemberRole():
        return 'MemberRole';
      case _ij5x7qg1.NotificationType():
        return 'NotificationType';
      case _iuqv4u9g.RoomType():
        return 'RoomType';
      case _ikitw31k.StatsPeriod():
        return 'StatsPeriod';
      case _iavhcq44.AppNotification():
        return 'AppNotification';
      case _ixkbjq1f.AppUser():
        return 'AppUser';
      case _iahyoybt.Booking():
        return 'Booking';
      case _iy10bu26.BookingSeries():
        return 'BookingSeries';
      case _ilmi8bdd.DeviceToken():
        return 'DeviceToken';
      case _i2hqha2j.Household():
        return 'Household';
      case _io5ke34u.HouseholdMember():
        return 'HouseholdMember';
      case _ilu35nbv.Invitation():
        return 'Invitation';
      case _i6ut1p8z.InviteAttempt():
        return 'InviteAttempt';
      case _ie9hxdgh.Room():
        return 'Room';
      case _isdv16rb.RoomClosure():
        return 'RoomClosure';
      case _ikqn1k4z.RoomHours():
        return 'RoomHours';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AppException') {
      return deserialize<_i2bomax4.AppException>(data['data']);
    }
    if (dataClassName == 'BookingException') {
      return deserialize<_iwj0eyzc.BookingException>(data['data']);
    }
    if (dataClassName == 'BookingRequest') {
      return deserialize<_isjupa8c.BookingRequest>(data['data']);
    }
    if (dataClassName == 'BookingView') {
      return deserialize<_imwypi3s.BookingView>(data['data']);
    }
    if (dataClassName == 'DailyUsage') {
      return deserialize<_ifjcum2y.DailyUsage>(data['data']);
    }
    if (dataClassName == 'HouseholdEvent') {
      return deserialize<_icqqh3tk.HouseholdEvent>(data['data']);
    }
    if (dataClassName == 'MeInfo') {
      return deserialize<_iwopsbei.MeInfo>(data['data']);
    }
    if (dataClassName == 'MemberInfo') {
      return deserialize<_iim79ks6.MemberInfo>(data['data']);
    }
    if (dataClassName == 'PeakHours') {
      return deserialize<_ia33gi2d.PeakHours>(data['data']);
    }
    if (dataClassName == 'RoomDetail') {
      return deserialize<_i2q5p93n.RoomDetail>(data['data']);
    }
    if (dataClassName == 'RoomStatus') {
      return deserialize<_ig25z30n.RoomStatus>(data['data']);
    }
    if (dataClassName == 'SeriesOccurrence') {
      return deserialize<_ie893o67.SeriesOccurrence>(data['data']);
    }
    if (dataClassName == 'SeriesRequest') {
      return deserialize<_ixpeu2zq.SeriesRequest>(data['data']);
    }
    if (dataClassName == 'TimeSlot') {
      return deserialize<_iomuimzj.TimeSlot>(data['data']);
    }
    if (dataClassName == 'UploadTicket') {
      return deserialize<_i0ulrzc8.UploadTicket>(data['data']);
    }
    if (dataClassName == 'UsageEntry') {
      return deserialize<_ifuy3au4.UsageEntry>(data['data']);
    }
    if (dataClassName == 'UsageStats') {
      return deserialize<_i5j36xpc.UsageStats>(data['data']);
    }
    if (dataClassName == 'AppErrorCode') {
      return deserialize<_ix5xerl7.AppErrorCode>(data['data']);
    }
    if (dataClassName == 'BookingErrorCode') {
      return deserialize<_id5wbqdr.BookingErrorCode>(data['data']);
    }
    if (dataClassName == 'BookingStatus') {
      return deserialize<_i75mj084.BookingStatus>(data['data']);
    }
    if (dataClassName == 'EditScope') {
      return deserialize<_ilbz46ft.EditScope>(data['data']);
    }
    if (dataClassName == 'HouseholdEventType') {
      return deserialize<_ieptqvya.HouseholdEventType>(data['data']);
    }
    if (dataClassName == 'MemberRole') {
      return deserialize<_icimtxba.MemberRole>(data['data']);
    }
    if (dataClassName == 'NotificationType') {
      return deserialize<_ij5x7qg1.NotificationType>(data['data']);
    }
    if (dataClassName == 'RoomType') {
      return deserialize<_iuqv4u9g.RoomType>(data['data']);
    }
    if (dataClassName == 'StatsPeriod') {
      return deserialize<_ikitw31k.StatsPeriod>(data['data']);
    }
    if (dataClassName == 'AppNotification') {
      return deserialize<_iavhcq44.AppNotification>(data['data']);
    }
    if (dataClassName == 'AppUser') {
      return deserialize<_ixkbjq1f.AppUser>(data['data']);
    }
    if (dataClassName == 'Booking') {
      return deserialize<_iahyoybt.Booking>(data['data']);
    }
    if (dataClassName == 'BookingSeries') {
      return deserialize<_iy10bu26.BookingSeries>(data['data']);
    }
    if (dataClassName == 'DeviceToken') {
      return deserialize<_ilmi8bdd.DeviceToken>(data['data']);
    }
    if (dataClassName == 'Household') {
      return deserialize<_i2hqha2j.Household>(data['data']);
    }
    if (dataClassName == 'HouseholdMember') {
      return deserialize<_io5ke34u.HouseholdMember>(data['data']);
    }
    if (dataClassName == 'Invitation') {
      return deserialize<_ilu35nbv.Invitation>(data['data']);
    }
    if (dataClassName == 'InviteAttempt') {
      return deserialize<_i6ut1p8z.InviteAttempt>(data['data']);
    }
    if (dataClassName == 'Room') {
      return deserialize<_ie9hxdgh.Room>(data['data']);
    }
    if (dataClassName == 'RoomClosure') {
      return deserialize<_isdv16rb.RoomClosure>(data['data']);
    }
    if (dataClassName == 'RoomHours') {
      return deserialize<_ikqn1k4z.RoomHours>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('homeslot', this);
    _iacs.Protocol().registerHostProtocol('homeslot', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _iavhcq44.AppNotification:
        return _iavhcq44.AppNotification.t;
      case _ixkbjq1f.AppUser:
        return _ixkbjq1f.AppUser.t;
      case _iahyoybt.Booking:
        return _iahyoybt.Booking.t;
      case _iy10bu26.BookingSeries:
        return _iy10bu26.BookingSeries.t;
      case _ilmi8bdd.DeviceToken:
        return _ilmi8bdd.DeviceToken.t;
      case _i2hqha2j.Household:
        return _i2hqha2j.Household.t;
      case _io5ke34u.HouseholdMember:
        return _io5ke34u.HouseholdMember.t;
      case _ilu35nbv.Invitation:
        return _ilu35nbv.Invitation.t;
      case _i6ut1p8z.InviteAttempt:
        return _i6ut1p8z.InviteAttempt.t;
      case _ie9hxdgh.Room:
        return _ie9hxdgh.Room.t;
      case _isdv16rb.RoomClosure:
        return _isdv16rb.RoomClosure.t;
      case _ikqn1k4z.RoomHours:
        return _ikqn1k4z.RoomHours.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'homeslot';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
