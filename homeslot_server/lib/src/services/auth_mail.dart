import 'dart:async';

import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart';

/// Sends the email verification and password reset codes (SRS 2.1.1, 2.1.2).
///
/// Uses SMTP when `smtpHost`, `smtpUsername` and `smtpPassword` are set in
/// `config/passwords.yaml` (optional: `smtpPort`, `smtpFrom`). Otherwise the
/// code is written to the server log, which is handy during development.
abstract final class AuthMail {
  static Future<void> sendRegistrationCode(
    Session session, {
    required String email,
    required UuidValue accountRequestId,
    required String verificationCode,
    required Transaction? transaction,
  }) => _send(
    session,
    to: email,
    subject: 'HomeSlot: ยืนยันอีเมล / Verify your email',
    text:
        'รหัสยืนยันของคุณคือ $verificationCode\n'
        'Your verification code is $verificationCode\n',
    logLabel: 'Registration',
    code: verificationCode,
  );

  static Future<void> sendPasswordResetCode(
    Session session, {
    required String email,
    required UuidValue passwordResetRequestId,
    required String verificationCode,
    required Transaction? transaction,
  }) => _send(
    session,
    to: email,
    subject: 'HomeSlot: รีเซ็ตรหัสผ่าน / Reset your password',
    text:
        'รหัสสำหรับตั้งรหัสผ่านใหม่คือ $verificationCode\n'
        'Your password reset code is $verificationCode\n'
        'ถ้าคุณไม่ได้ขอรีเซ็ตรหัสผ่าน ให้เพิกเฉยอีเมลนี้ / '
        'If you did not ask for this, ignore this email.\n',
    logLabel: 'Password reset',
    code: verificationCode,
  );

  static Future<void> _send(
    Session session, {
    required String to,
    required String subject,
    required String text,
    required String logLabel,
    required String code,
  }) async {
    String? setting(String key) {
      final value = session.passwords[key]?.trim();
      return value == null || value.isEmpty ? null : value;
    }

    final host = setting('smtpHost');
    final username = setting('smtpUsername');
    final password = setting('smtpPassword');
    if (host == null || username == null || password == null) {
      session.log('$logLabel code for $to: $code', level: LogLevel.info);
      return;
    }
    final server = SmtpServer(
      host,
      port: int.tryParse(setting('smtpPort') ?? '') ?? 587,
      username: username,
      password: password,
    );
    final message = mailer.Message()
      ..from = mailer.Address(setting('smtpFrom') ?? username, 'HomeSlot')
      ..recipients.add(to)
      ..subject = subject
      ..text = text;
    // Sent in the background: the sign-up or reset request, and the auth
    // transaction it runs in, do not wait for the mail server.
    unawaited(_deliver(session.serverpod, message, server, logLabel));
  }

  static Future<void> _deliver(
    Serverpod pod,
    mailer.Message message,
    SmtpServer server,
    String logLabel,
  ) async {
    try {
      await mailer.send(message, server, timeout: const Duration(seconds: 30));
    } catch (e, stackTrace) {
      // Never reveal to the caller whether sending failed; that would leak
      // whether the account exists. The request's session is closed by now.
      try {
        await pod.withSession(
          (session) async => session.log(
            'Failed to send $logLabel email: $e',
            level: LogLevel.error,
            exception: e,
            stackTrace: stackTrace,
          ),
        );
      } catch (_) {
        // Nothing else to report to.
      }
    }
  }
}
