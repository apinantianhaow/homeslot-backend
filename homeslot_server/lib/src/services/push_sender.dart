import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:googleapis_auth/auth_io.dart' as gauth;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Sends push notifications through Firebase Cloud Messaging (HTTP v1 API).
///
/// Configure it with a Firebase service account key, either as the
/// `firebaseServiceAccount` entry in `config/passwords.yaml` (JSON string) or
/// as the file `config/firebase_service_account_key.json` (or
/// `secrets/firebase_service_account_key.json` in Docker). Without a key,
/// push is disabled and notifications are only stored in the app.
class PushSender {
  PushSender._();

  static PushSender instance = PushSender._();

  static const _scope = 'https://www.googleapis.com/auth/firebase.messaging';
  static const _keyFiles = [
    'config/firebase_service_account_key.json',
    'secrets/firebase_service_account_key.json',
  ];

  /// Upper bound for one FCM request, so a stalled connection cannot keep
  /// background deliveries piling up.
  static const _sendTimeout = Duration(seconds: 10);

  Future<void>? _loading;
  gauth.AutoRefreshingAuthClient? _client;
  String? _projectId;

  bool get enabled => _client != null;

  /// Loads the FCM credentials once. Called at startup so the first push
  /// does not wait for the OAuth token; concurrent callers share one load.
  Future<void> init(Session session) => _loading ??= _load(session);

  Future<void> _load(Session session) async {
    try {
      var json = session.passwords['firebaseServiceAccount'];
      if (json != null && json.trim().isEmpty) json = null;
      for (final path in _keyFiles) {
        final file = File(path);
        if (json == null && file.existsSync()) {
          json = await file.readAsString();
        }
      }
      if (json == null) {
        session.log(
          'FCM is not configured; push notifications are disabled.',
          level: LogLevel.info,
        );
        return;
      }
      final map = jsonDecode(json) as Map<String, dynamic>;
      _projectId = map['project_id'] as String?;
      _client = await gauth.clientViaServiceAccount(
        gauth.ServiceAccountCredentials.fromJson(map),
        [_scope],
        baseClient: IOClient(
          HttpClient()..connectionTimeout = const Duration(seconds: 5),
        ),
      );
    } catch (e, stackTrace) {
      // Try again on the next push instead of staying disabled until the
      // server restarts (e.g. no network while booting).
      _loading = null;
      session.log(
        'Failed to initialise FCM: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Pushes to every device of [userId].
  ///
  /// Only the token lookup runs in the caller's request. Delivery continues
  /// in the background, so booking actions never wait for FCM, and a failed
  /// delivery can never fail an action whose changes are already saved.
  Future<void> send(
    Session session, {
    required int userId,
    required String title,
    required String body,
    Map<String, String> data = const {},
  }) async {
    await init(session);
    final client = _client;
    if (client == null) return;

    final tokens = await DeviceToken.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
    if (tokens.isEmpty) return;
    unawaited(
      _deliver(
        session.serverpod,
        client,
        tokens,
        title: title,
        body: body,
        data: data,
      ),
    );
  }

  Future<void> _deliver(
    Serverpod pod,
    http.Client client,
    List<DeviceToken> tokens, {
    required String title,
    required String body,
    required Map<String, String> data,
  }) async {
    final stale = <int>{};
    final problems = <String>[];
    await Future.wait([
      for (final token in tokens)
        () async {
          try {
            final response = await client
                .post(
                  Uri.parse(
                    'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send',
                  ),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'message': {
                      'token': token.token,
                      'notification': {'title': title, 'body': body},
                      'data': data,
                      'android': {'priority': 'high'},
                      'apns': {
                        'payload': {
                          'aps': {'sound': 'default'},
                        },
                      },
                    },
                  }),
                )
                .timeout(_sendTimeout);
            if (response.statusCode == 404 ||
                response.body.contains('UNREGISTERED')) {
              stale.add(token.id!);
            } else if (response.statusCode >= 400) {
              problems.add(
                'FCM send failed (${response.statusCode}): ${response.body}',
              );
            }
          } catch (e) {
            problems.add('FCM send failed: $e');
          }
        }(),
    ]);
    if (stale.isEmpty && problems.isEmpty) return;

    // The request's session is closed by now, so record the outcome in a
    // session of its own.
    try {
      await pod.withSession((session) async {
        if (stale.isNotEmpty) {
          await DeviceToken.db.deleteWhere(
            session,
            where: (t) => t.id.inSet(stale),
          );
        }
        for (final problem in problems) {
          session.log(problem, level: LogLevel.warning);
        }
      });
    } catch (_) {
      // Push is best effort; there is nobody left to report this to.
    }
  }
}
