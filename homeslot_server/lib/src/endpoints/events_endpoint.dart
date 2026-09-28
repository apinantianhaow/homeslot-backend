import 'package:async/async.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/membership.dart';
import '../services/realtime.dart';
import '../services/users.dart';

/// Real-time updates over WebSocket (SRS 2.3.8, 3.3). The app refreshes the
/// affected data when an event arrives, so no manual refresh is needed.
class EventsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Stream<HouseholdEvent> subscribe(Session session) async* {
    final user = await Users.current(session);
    final member = await Membership.memberOf(session, user.id!);
    yield* StreamGroup.merge([
      session.messages.createStream<HouseholdEvent>(
        Realtime.userChannel(user.id!),
      ),
      if (member != null)
        session.messages.createStream<HouseholdEvent>(
          Realtime.householdChannel(member.householdId),
        ),
    ]);
  }
}
