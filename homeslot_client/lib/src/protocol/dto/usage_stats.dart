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
import 'package:homeslot_client/src/protocol/protocol.dart' as _igrvdpfe;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../dto/daily_usage.dart' as _iolqf0pv;
import '../dto/usage_entry.dart' as _ieqxxpud;
import '../enums/stats_period.dart' as _i3o25fsz;

/// Usage statistics for a week or month (SRS 2.6.2).
abstract class UsageStats
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UsageStats._({
    required this.period,
    required this.from,
    required this.to,
    required this.totalMinutes,
    required this.byRoom,
    required this.byMember,
    required this.byDay,
  });

  factory UsageStats({
    required _i3o25fsz.StatsPeriod period,
    required DateTime from,
    required DateTime to,
    required int totalMinutes,
    required List<_ieqxxpud.UsageEntry> byRoom,
    required List<_ieqxxpud.UsageEntry> byMember,
    required List<_iolqf0pv.DailyUsage> byDay,
  }) = _UsageStatsImpl;

  factory UsageStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return UsageStats(
      period: _i3o25fsz.StatsPeriod.fromJson(
        (jsonSerialization['period'] as String),
      ),
      from: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['from']),
      to: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['to']),
      totalMinutes: jsonSerialization['totalMinutes'] as int,
      byRoom: _igrvdpfe.Protocol().deserialize<List<_ieqxxpud.UsageEntry>>(
        jsonSerialization['byRoom'],
      ),
      byMember: _igrvdpfe.Protocol().deserialize<List<_ieqxxpud.UsageEntry>>(
        jsonSerialization['byMember'],
      ),
      byDay: _igrvdpfe.Protocol().deserialize<List<_iolqf0pv.DailyUsage>>(
        jsonSerialization['byDay'],
      ),
    );
  }

  _i3o25fsz.StatsPeriod period;

  DateTime from;

  DateTime to;

  int totalMinutes;

  List<_ieqxxpud.UsageEntry> byRoom;

  List<_ieqxxpud.UsageEntry> byMember;

  List<_iolqf0pv.DailyUsage> byDay;

  /// Returns a shallow copy of this [UsageStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UsageStats copyWith({
    _i3o25fsz.StatsPeriod? period,
    DateTime? from,
    DateTime? to,
    int? totalMinutes,
    List<_ieqxxpud.UsageEntry>? byRoom,
    List<_ieqxxpud.UsageEntry>? byMember,
    List<_iolqf0pv.DailyUsage>? byDay,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UsageStats',
      'period': period.toJson(),
      'from': from.toJson(),
      'to': to.toJson(),
      'totalMinutes': totalMinutes,
      'byRoom': byRoom.toJson(valueToJson: (v) => v.toJson()),
      'byMember': byMember.toJson(valueToJson: (v) => v.toJson()),
      'byDay': byDay.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UsageStats',
      'period': period.toJson(),
      'from': from.toJson(),
      'to': to.toJson(),
      'totalMinutes': totalMinutes,
      'byRoom': byRoom.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'byMember': byMember.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'byDay': byDay.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _UsageStatsImpl extends UsageStats {
  _UsageStatsImpl({
    required _i3o25fsz.StatsPeriod period,
    required DateTime from,
    required DateTime to,
    required int totalMinutes,
    required List<_ieqxxpud.UsageEntry> byRoom,
    required List<_ieqxxpud.UsageEntry> byMember,
    required List<_iolqf0pv.DailyUsage> byDay,
  }) : super._(
         period: period,
         from: from,
         to: to,
         totalMinutes: totalMinutes,
         byRoom: byRoom,
         byMember: byMember,
         byDay: byDay,
       );

  /// Returns a shallow copy of this [UsageStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UsageStats copyWith({
    _i3o25fsz.StatsPeriod? period,
    DateTime? from,
    DateTime? to,
    int? totalMinutes,
    List<_ieqxxpud.UsageEntry>? byRoom,
    List<_ieqxxpud.UsageEntry>? byMember,
    List<_iolqf0pv.DailyUsage>? byDay,
  }) {
    return UsageStats(
      period: period ?? this.period,
      from: from ?? this.from,
      to: to ?? this.to,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      byRoom: byRoom ?? this.byRoom.map((e0) => e0.copyWith()).toList(),
      byMember: byMember ?? this.byMember.map((e0) => e0.copyWith()).toList(),
      byDay: byDay ?? this.byDay.map((e0) => e0.copyWith()).toList(),
    );
  }
}
