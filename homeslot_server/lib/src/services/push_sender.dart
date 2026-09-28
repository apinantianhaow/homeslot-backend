import 'dart:convert';
import 'dart:io';

import 'package:googleapis_auth/auth_io.dart' as gauth;
import 'package:http/http.dart' as http;
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

  bool _loaded = false;
  gauth.AutoRefreshingAuthClient? _client;
  String? _projectId;

  bool get enabled => _client != null;

  Future<void> _load(Session session) async {
    if (_loaded) return;
    _loaded = true;
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
      );
    } catch (e, stackTrace) {
      session.log(
        'Failed to initialise FCM: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> send(
    Session session, {
    required int userId,
    required String title,
    required String body,
    Map<String, String> data = const {},
  }) async {
    await _load(session);
    final client = _client;
    if (client == null) return;

    final tokens = await DeviceToken.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
    for (final token in tokens) {
      try {
        final response = await client.post(
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
        );
        if (response.statusCode == 404 ||
            response.body.contains('UNREGISTERED')) {
          await DeviceToken.db.deleteRow(session, token);
        } else if (response.statusCode >= 400) {
          session.log(
            'FCM send failed (${response.statusCode}): ${response.body}',
            level: LogLevel.warning,
          );
        }
      } on http.ClientException catch (e) {
        session.log('FCM send failed: $e', level: LogLevel.warning);
      }
    }
  }
}
