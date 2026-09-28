import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/membership.dart';
import '../services/stats_service.dart';

/// Usage statistics for owners (SRS 2.6.2, 2.6.3).
class StatsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<UsageStats> usage(
    Session session,
    StatsPeriod period,
    DateTime anchor,
  ) async => StatsService.usage(
    session,
    await Membership.requireOwner(session),
    period: period,
    anchor: anchor,
  );

  Future<PeakHours> peakHours(Session session, int? roomId, int days) async =>
      StatsService.peakHours(
        session,
        await Membership.requireOwner(session),
        roomId: roomId,
        days: days,
      );
}
