import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart';
import 'package:serverpod_cloud_storage/serverpod_cloud_storage.dart';

import 'src/db/constraints.dart';
import 'src/generated/serverpod.dart';
import 'src/services/auth_mail.dart';
import 'src/util/time_zones.dart';

/// Identifier of the recurring maintenance future call.
const maintenanceCallId = 'homeslot-maintenance';

/// The starting point of the HomeSlot server.
void run(List<String> args) async {
  TimeZones.init();

  final pod = Serverpod(args);

  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // JWT access tokens with automatic refresh.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Email + password, with verification and password reset codes sent by
      // SMTP (or logged to the console when SMTP is not configured).
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: AuthMail.sendRegistrationCode,
        sendPasswordResetVerificationCode: AuthMail.sendPasswordResetCode,
      ),
      // Google sign-in, enabled when the client secret is configured.
      if (pod.getPassword('googleClientSecret') != null)
        GoogleIdpConfigFromPasswords(),
    ],
  );

  // Room photos and profile pictures. Stored in PostgreSQL when self-hosted.
  pod.addCloudStorage(
    await ServerpodCloudProvider.private(
      fallback: () => DatabaseCloudStorage('private'),
    ),
  );
  pod.addCloudStorage(
    await ServerpodCloudProvider.public(
      fallback: () => DatabaseCloudStorage('public'),
    ),
  );

  await pod.start();

  final session = await pod.createSession(enableLogging: false);
  try {
    // Guarantee the overlap exclusion constraint exists (SRS 4.4, 4.8).
    await DbConstraints.ensure(session);
  } finally {
    await session.close();
  }

  // Expire pending requests, complete ended bookings and send reminders.
  await pod.futureCalls.cancel(maintenanceCallId);
  await pod.futureCalls
      .callRecurring(identifier: maintenanceCallId)
      .every(const Duration(minutes: 1))
      .maintenanceCall
      .sweep();
}
