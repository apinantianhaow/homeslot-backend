import 'package:serverpod/serverpod.dart';

import '../services/maintenance.dart';

/// Runs [Maintenance] every minute (scheduled in `server.dart`).
class MaintenanceCall extends FutureCall {
  Future<void> sweep(Session session) async {
    final result = await Maintenance.run(session);
    if (result.expired + result.completed + result.reminded > 0) {
      session.log(
        'Maintenance: expired ${result.expired}, completed '
        '${result.completed}, reminders ${result.reminded}',
      );
    }
  }
}
