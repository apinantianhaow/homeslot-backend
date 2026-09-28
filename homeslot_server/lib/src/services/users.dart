import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../util/errors.dart';
import '../util/palette.dart';

/// Resolves the [AppUser] row for the signed-in Serverpod auth user.
abstract final class Users {
  /// Returns the current user, creating the profile on first use.
  static Future<AppUser> current(Session session) async {
    final info = session.authenticated;
    if (info == null) {
      fail(AppErrorCode.notMember, 'Not signed in.');
    }
    final authUserId = info.authUserId;
    final existing = await AppUser.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (existing != null) return existing;

    final profile = await AuthServices.instance.userProfiles
        .maybeFindUserProfileByUserId(session, authUserId);
    var email = profile?.email?.toLowerCase();
    final name = _firstNonEmpty([
      profile?.fullName,
      profile?.userName,
      email?.split('@').first,
    ]);
    // Another profile may already hold this email (e.g. the same person
    // signed up with both email and Google). The email is only a copy for
    // display, so keep the profile without it rather than failing.
    if (email != null &&
        await AppUser.db.count(session, where: (t) => t.email.equals(email)) >
            0) {
      email = null;
    }
    final avatar = profile?.imageUrl?.toString();
    try {
      return await AppUser.db.insertRow(
        session,
        AppUser(
          authUserId: authUserId,
          email: email,
          displayName: name ?? 'User',
          color: randomMemberColor(),
          avatarUrl: avatar != null && avatar.startsWith('http')
              ? avatar
              : null,
        ),
      );
    } on DatabaseQueryException {
      // A concurrent request created the row first.
      final row = await AppUser.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(authUserId),
      );
      if (row != null) return row;
      rethrow;
    }
  }

  static String? _firstNonEmpty(List<String?> values) {
    for (final v in values) {
      if (v != null && v.trim().isNotEmpty) return v.trim();
    }
    return null;
  }

  static Future<Map<int, AppUser>> byIds(
    Session session,
    Iterable<int> ids, {
    Transaction? transaction,
  }) async {
    final set = ids.toSet();
    if (set.isEmpty) return {};
    final rows = await AppUser.db.find(
      session,
      where: (t) => t.id.inSet(set),
      transaction: transaction,
    );
    return {for (final u in rows) u.id!: u};
  }
}
