import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/maintenance.dart';
import '../services/users.dart';
import '../util/clock.dart';

/// In-app notification history, last 30 days (SRS 2.5.4).
class NotificationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<AppNotification>> list(Session session) async {
    final user = await Users.current(session);
    return AppNotification.db.find(
      session,
      where: (t) =>
          t.userId.equals(user.id) &
          (t.createdAt >
              clock.now().subtract(Maintenance.notificationRetention)),
      orderBy: (t) => t.createdAt.desc(),
      limit: 200,
    );
  }

  Future<int> unreadCount(Session session) async {
    final user = await Users.current(session);
    return AppNotification.db.count(
      session,
      where: (t) => t.userId.equals(user.id) & t.readAt.equals(null),
    );
  }

  Future<void> markRead(Session session, int notificationId) async {
    final user = await Users.current(session);
    await AppNotification.db.updateWhere(
      session,
      columnValues: (t) => [t.readAt(clock.now())],
      where: (t) => t.id.equals(notificationId) & t.userId.equals(user.id),
    );
  }

  Future<void> markAllRead(Session session) async {
    final user = await Users.current(session);
    await AppNotification.db.updateWhere(
      session,
      columnValues: (t) => [t.readAt(clock.now())],
      where: (t) => t.userId.equals(user.id) & t.readAt.equals(null),
    );
  }
}
