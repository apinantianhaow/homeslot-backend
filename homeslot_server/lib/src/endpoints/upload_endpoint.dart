import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/membership.dart';
import '../services/users.dart';
import '../util/errors.dart';

/// Image uploads for profile pictures and room photos (SRS 2.1.8, 2.2.1).
class UploadEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const _storage = 'public';
  static const _extensions = {'jpg', 'jpeg', 'png', 'webp'};
  static final _random = Random.secure();

  /// [kind] is `avatar` or `room` (owners only).
  Future<UploadTicket> createUpload(
    Session session,
    String kind,
    String extension,
  ) async {
    final ext = extension.toLowerCase().replaceAll('.', '');
    if (!_extensions.contains(ext)) {
      fail(AppErrorCode.validation, 'Only JPG, PNG or WebP images.');
    }
    final name =
        '${DateTime.now().millisecondsSinceEpoch}-'
        '${_random.nextInt(1 << 32).toRadixString(36)}.$ext';
    final String path;
    if (kind == 'room') {
      final actor = await Membership.requireOwner(session);
      path = 'rooms/${actor.householdId}/$name';
    } else if (kind == 'avatar') {
      final user = await Users.current(session);
      path = 'avatars/${user.id}/$name';
    } else {
      fail(AppErrorCode.validation, 'Unknown upload kind.');
    }
    final description = await session.storage.createUploadDescription(
      storageId: _storage,
      path: path,
    );
    return UploadTicket(path: path, description: description);
  }

  /// Confirms the upload and returns the public URL of the image.
  Future<String> verifyUpload(Session session, String path) async {
    final user = await Users.current(session);
    final member = await Membership.memberOf(session, user.id!);
    final allowed =
        path.startsWith('avatars/${user.id}/') ||
        (member != null && path.startsWith('rooms/${member.householdId}/'));
    if (!allowed) fail(AppErrorCode.notOwner, 'Not your upload.');
    final ok = await session.storage.verifyUpload(
      storageId: _storage,
      path: path,
    );
    if (!ok) fail(AppErrorCode.validation, 'Upload failed.');
    final url = await session.storage.publicDownloadUrl(
      storageId: _storage,
      path: path,
    );
    return url.toString();
  }
}
