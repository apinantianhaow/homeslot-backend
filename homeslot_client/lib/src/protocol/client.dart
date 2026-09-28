/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:homeslot_client/src/protocol/dto/booking_request.dart'
    as _isfb0o4x;
import 'package:homeslot_client/src/protocol/dto/booking_view.dart'
    as _icffuni7;
import 'package:homeslot_client/src/protocol/dto/household_event.dart'
    as _ipgjhykx;
import 'package:homeslot_client/src/protocol/dto/me_info.dart' as _io23026z;
import 'package:homeslot_client/src/protocol/dto/member_info.dart' as _i0yqsv6q;
import 'package:homeslot_client/src/protocol/dto/peak_hours.dart' as _ijm9ev13;
import 'package:homeslot_client/src/protocol/dto/room_detail.dart' as _i36hieap;
import 'package:homeslot_client/src/protocol/dto/room_status.dart' as _igj6zjny;
import 'package:homeslot_client/src/protocol/dto/series_occurrence.dart'
    as _iap69c70;
import 'package:homeslot_client/src/protocol/dto/series_request.dart'
    as _iab5kvj1;
import 'package:homeslot_client/src/protocol/dto/time_slot.dart' as _izgdjs28;
import 'package:homeslot_client/src/protocol/dto/upload_ticket.dart'
    as _iuurqjrn;
import 'package:homeslot_client/src/protocol/dto/usage_stats.dart' as _iifvugvt;
import 'package:homeslot_client/src/protocol/enums/edit_scope.dart'
    as _imo863gj;
import 'package:homeslot_client/src/protocol/enums/member_role.dart'
    as _io18svz2;
import 'package:homeslot_client/src/protocol/enums/stats_period.dart'
    as _i4gz8lej;
import 'package:homeslot_client/src/protocol/tables/app_notification.dart'
    as _i4rx8r8t;
import 'package:homeslot_client/src/protocol/tables/app_user.dart' as _iiaywhlq;
import 'package:homeslot_client/src/protocol/tables/household.dart'
    as _iyj1xxw0;
import 'package:homeslot_client/src/protocol/tables/invitation.dart'
    as _ibsj7tgw;
import 'package:homeslot_client/src/protocol/tables/room.dart' as _iluzwuxs;
import 'package:homeslot_client/src/protocol/tables/room_closure.dart'
    as _i86vmq27;
import 'package:homeslot_client/src/protocol/tables/room_hours.dart'
    as _imnuvide;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// Google sign-in (SRS 2.1.1). Active when `googleClientSecret` is set in
/// `config/passwords.yaml`; the app shows the button when built with
/// `GOOGLE_CLIENT_ID` / `GOOGLE_SERVER_CLIENT_ID`.
/// {@category Endpoint}
class EndpointGoogleIdp extends _iaic.EndpointGoogleIdpBase {
  EndpointGoogleIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'googleIdp';

  /// Validates a Google ID token and either logs in the associated user or
  /// creates a new user account if the Google account ID is not yet known.
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String idToken,
    required String? accessToken,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'googleIdp',
    'login',
    {
      'idToken': idToken,
      'accessToken': accessToken,
    },
  );

  /// Validates a Google authorization code from the web OAuth2 PKCE flow and
  /// either logs in the associated user or creates a new account.
  ///
  /// This is the web counterpart of [login], which accepts an ID token directly
  /// (used on native platforms via the `google_sign_in` package).
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _ida.Future<_iacc.AuthSuccess> loginWithCode({
    required String code,
    required String codeVerifier,
    required String redirectUri,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'googleIdp',
    'loginWithCode',
    {
      'code': code,
      'codeVerifier': codeVerifier,
      'redirectUri': redirectUri,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'googleIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// The signed-in user's own profile, settings and devices (SRS 2.1.8, 2.5.1).
/// {@category Endpoint}
class EndpointAccount extends _isc.EndpointRef {
  EndpointAccount(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'account';

  _ida.Future<_io23026z.MeInfo> me() =>
      caller.callServerEndpoint<_io23026z.MeInfo>(
        'account',
        'me',
        {},
      );

  _ida.Future<_iiaywhlq.AppUser> updateProfile(
    String displayName,
    String color,
    String? avatarUrl,
  ) => caller.callServerEndpoint<_iiaywhlq.AppUser>(
    'account',
    'updateProfile',
    {
      'displayName': displayName,
      'color': color,
      'avatarUrl': avatarUrl,
    },
  );

  _ida.Future<_iiaywhlq.AppUser> updateSettings(
    bool reminderEnabled,
    int reminderMinutes,
    String locale,
  ) => caller.callServerEndpoint<_iiaywhlq.AppUser>(
    'account',
    'updateSettings',
    {
      'reminderEnabled': reminderEnabled,
      'reminderMinutes': reminderMinutes,
      'locale': locale,
    },
  );

  /// Registers this device's FCM token for push notifications.
  _ida.Future<void> registerDevice(
    String token,
    String platform,
  ) => caller.callServerEndpoint<void>(
    'account',
    'registerDevice',
    {
      'token': token,
      'platform': platform,
    },
  );

  _ida.Future<void> unregisterDevice(String token) =>
      caller.callServerEndpoint<void>(
        'account',
        'unregisterDevice',
        {'token': token},
      );

  /// Deletes the account and its personal data (PDPA).
  _ida.Future<void> deleteAccount() => caller.callServerEndpoint<void>(
    'account',
    'deleteAccount',
    {},
  );
}

/// Calendar, booking and approval (SRS 2.3, 2.4).
/// {@category Endpoint}
class EndpointBooking extends _isc.EndpointRef {
  EndpointBooking(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'booking';

  /// Bookings in the household (or one room) overlapping [from, to).
  _ida.Future<List<_icffuni7.BookingView>> list(
    DateTime from,
    DateTime to,
    int? roomId,
  ) => caller.callServerEndpoint<List<_icffuni7.BookingView>>(
    'booking',
    'list',
    {
      'from': from,
      'to': to,
      'roomId': roomId,
    },
  );

  _ida.Future<_icffuni7.BookingView> create(_isfb0o4x.BookingRequest request) =>
      caller.callServerEndpoint<_icffuni7.BookingView>(
        'booking',
        'create',
        {'request': request},
      );

  /// Free slots near the requested time, same length.
  _ida.Future<List<_izgdjs28.TimeSlot>> suggest(
    int roomId,
    DateTime startAt,
    DateTime endAt,
  ) => caller.callServerEndpoint<List<_izgdjs28.TimeSlot>>(
    'booking',
    'suggest',
    {
      'roomId': roomId,
      'startAt': startAt,
      'endAt': endAt,
    },
  );

  _ida.Future<List<_iap69c70.SeriesOccurrence>> previewSeries(
    _iab5kvj1.SeriesRequest request,
  ) => caller.callServerEndpoint<List<_iap69c70.SeriesOccurrence>>(
    'booking',
    'previewSeries',
    {'request': request},
  );

  _ida.Future<List<_icffuni7.BookingView>> createSeries(
    _iab5kvj1.SeriesRequest request,
  ) => caller.callServerEndpoint<List<_icffuni7.BookingView>>(
    'booking',
    'createSeries',
    {'request': request},
  );

  _ida.Future<List<_icffuni7.BookingView>> update(
    int bookingId,
    DateTime startAt,
    DateTime endAt,
    String? purpose,
    String? note,
    _imo863gj.EditScope scope,
  ) => caller.callServerEndpoint<List<_icffuni7.BookingView>>(
    'booking',
    'update',
    {
      'bookingId': bookingId,
      'startAt': startAt,
      'endAt': endAt,
      'purpose': purpose,
      'note': note,
      'scope': scope,
    },
  );

  /// Returns how many bookings were cancelled.
  _ida.Future<int> cancel(
    int bookingId,
    _imo863gj.EditScope scope,
    String? reason,
  ) => caller.callServerEndpoint<int>(
    'booking',
    'cancel',
    {
      'bookingId': bookingId,
      'scope': scope,
      'reason': reason,
    },
  );

  _ida.Future<_icffuni7.BookingView> release(int bookingId) =>
      caller.callServerEndpoint<_icffuni7.BookingView>(
        'booking',
        'release',
        {'bookingId': bookingId},
      );

  _ida.Future<List<_icffuni7.BookingView>> mine(
    bool upcoming,
    int limit,
    int offset,
  ) => caller.callServerEndpoint<List<_icffuni7.BookingView>>(
    'booking',
    'mine',
    {
      'upcoming': upcoming,
      'limit': limit,
      'offset': offset,
    },
  );

  _ida.Future<List<_icffuni7.BookingView>> pending() =>
      caller.callServerEndpoint<List<_icffuni7.BookingView>>(
        'booking',
        'pending',
        {},
      );

  _ida.Future<List<_icffuni7.BookingView>> approve(
    int bookingId,
    _imo863gj.EditScope scope,
  ) => caller.callServerEndpoint<List<_icffuni7.BookingView>>(
    'booking',
    'approve',
    {
      'bookingId': bookingId,
      'scope': scope,
    },
  );

  _ida.Future<List<_icffuni7.BookingView>> reject(
    int bookingId,
    String? reason,
    _imo863gj.EditScope scope,
  ) => caller.callServerEndpoint<List<_icffuni7.BookingView>>(
    'booking',
    'reject',
    {
      'bookingId': bookingId,
      'reason': reason,
      'scope': scope,
    },
  );
}

/// Real-time updates over WebSocket (SRS 2.3.8, 3.3). The app refreshes the
/// affected data when an event arrives, so no manual refresh is needed.
/// {@category Endpoint}
class EndpointEvents extends _isc.EndpointRef {
  EndpointEvents(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'events';

  _ida.Stream<_ipgjhykx.HouseholdEvent> subscribe() =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ipgjhykx.HouseholdEvent>,
        _ipgjhykx.HouseholdEvent
      >(
        'events',
        'subscribe',
        {},
        {},
      );
}

/// Household, invitations and members (SRS 2.1.3 - 2.1.7).
/// {@category Endpoint}
class EndpointHousehold extends _isc.EndpointRef {
  EndpointHousehold(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'household';

  _ida.Future<_io23026z.MeInfo> create(
    String name,
    String timezone,
  ) => caller.callServerEndpoint<_io23026z.MeInfo>(
    'household',
    'create',
    {
      'name': name,
      'timezone': timezone,
    },
  );

  _ida.Future<_iyj1xxw0.Household> update(
    String name,
    String timezone,
  ) => caller.callServerEndpoint<_iyj1xxw0.Household>(
    'household',
    'update',
    {
      'name': name,
      'timezone': timezone,
    },
  );

  _ida.Future<List<_i0yqsv6q.MemberInfo>> members() =>
      caller.callServerEndpoint<List<_i0yqsv6q.MemberInfo>>(
        'household',
        'members',
        {},
      );

  _ida.Future<_ibsj7tgw.Invitation> createInvite() =>
      caller.callServerEndpoint<_ibsj7tgw.Invitation>(
        'household',
        'createInvite',
        {},
      );

  _ida.Future<List<_ibsj7tgw.Invitation>> activeInvites() =>
      caller.callServerEndpoint<List<_ibsj7tgw.Invitation>>(
        'household',
        'activeInvites',
        {},
      );

  _ida.Future<void> revokeInvite(int invitationId) =>
      caller.callServerEndpoint<void>(
        'household',
        'revokeInvite',
        {'invitationId': invitationId},
      );

  _ida.Future<_io23026z.MeInfo> join(String code) =>
      caller.callServerEndpoint<_io23026z.MeInfo>(
        'household',
        'join',
        {'code': code},
      );

  _ida.Future<_i0yqsv6q.MemberInfo> changeRole(
    int userId,
    _io18svz2.MemberRole role,
  ) => caller.callServerEndpoint<_i0yqsv6q.MemberInfo>(
    'household',
    'changeRole',
    {
      'userId': userId,
      'role': role,
    },
  );

  _ida.Future<void> removeMember(int userId) => caller.callServerEndpoint<void>(
    'household',
    'removeMember',
    {'userId': userId},
  );

  _ida.Future<void> leave() => caller.callServerEndpoint<void>(
    'household',
    'leave',
    {},
  );
}

/// In-app notification history, last 30 days (SRS 2.5.4).
/// {@category Endpoint}
class EndpointNotification extends _isc.EndpointRef {
  EndpointNotification(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  _ida.Future<List<_i4rx8r8t.AppNotification>> list() =>
      caller.callServerEndpoint<List<_i4rx8r8t.AppNotification>>(
        'notification',
        'list',
        {},
      );

  _ida.Future<int> unreadCount() => caller.callServerEndpoint<int>(
    'notification',
    'unreadCount',
    {},
  );

  _ida.Future<void> markRead(int notificationId) =>
      caller.callServerEndpoint<void>(
        'notification',
        'markRead',
        {'notificationId': notificationId},
      );

  _ida.Future<void> markAllRead() => caller.callServerEndpoint<void>(
    'notification',
    'markAllRead',
    {},
  );
}

/// Rooms, opening hours, booking rules and closures (SRS 2.2).
/// {@category Endpoint}
class EndpointRoom extends _isc.EndpointRef {
  EndpointRoom(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'room';

  _ida.Future<List<_i36hieap.RoomDetail>> list() =>
      caller.callServerEndpoint<List<_i36hieap.RoomDetail>>(
        'room',
        'list',
        {},
      );

  _ida.Future<_i36hieap.RoomDetail> get(int roomId) =>
      caller.callServerEndpoint<_i36hieap.RoomDetail>(
        'room',
        'get',
        {'roomId': roomId},
      );

  _ida.Future<List<_igj6zjny.RoomStatus>> statusNow() =>
      caller.callServerEndpoint<List<_igj6zjny.RoomStatus>>(
        'room',
        'statusNow',
        {},
      );

  _ida.Future<_i36hieap.RoomDetail> create(
    _iluzwuxs.Room room,
    List<_imnuvide.RoomHours> hours,
  ) => caller.callServerEndpoint<_i36hieap.RoomDetail>(
    'room',
    'create',
    {
      'room': room,
      'hours': hours,
    },
  );

  _ida.Future<_i36hieap.RoomDetail> update(
    _iluzwuxs.Room room,
    List<_imnuvide.RoomHours> hours,
  ) => caller.callServerEndpoint<_i36hieap.RoomDetail>(
    'room',
    'update',
    {
      'room': room,
      'hours': hours,
    },
  );

  _ida.Future<void> delete(int roomId) => caller.callServerEndpoint<void>(
    'room',
    'delete',
    {'roomId': roomId},
  );

  _ida.Future<_i86vmq27.RoomClosure> close(
    int roomId,
    DateTime startAt,
    DateTime endAt,
    String reason,
  ) => caller.callServerEndpoint<_i86vmq27.RoomClosure>(
    'room',
    'close',
    {
      'roomId': roomId,
      'startAt': startAt,
      'endAt': endAt,
      'reason': reason,
    },
  );

  _ida.Future<void> removeClosure(int closureId) =>
      caller.callServerEndpoint<void>(
        'room',
        'removeClosure',
        {'closureId': closureId},
      );
}

/// Usage statistics for owners (SRS 2.6.2, 2.6.3).
/// {@category Endpoint}
class EndpointStats extends _isc.EndpointRef {
  EndpointStats(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'stats';

  _ida.Future<_iifvugvt.UsageStats> usage(
    _i4gz8lej.StatsPeriod period,
    DateTime anchor,
  ) => caller.callServerEndpoint<_iifvugvt.UsageStats>(
    'stats',
    'usage',
    {
      'period': period,
      'anchor': anchor,
    },
  );

  _ida.Future<_ijm9ev13.PeakHours> peakHours(
    int? roomId,
    int days,
  ) => caller.callServerEndpoint<_ijm9ev13.PeakHours>(
    'stats',
    'peakHours',
    {
      'roomId': roomId,
      'days': days,
    },
  );
}

/// Image uploads for profile pictures and room photos (SRS 2.1.8, 2.2.1).
/// {@category Endpoint}
class EndpointUpload extends _isc.EndpointRef {
  EndpointUpload(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'upload';

  /// [kind] is `avatar` or `room` (owners only).
  _ida.Future<_iuurqjrn.UploadTicket> createUpload(
    String kind,
    String extension,
  ) => caller.callServerEndpoint<_iuurqjrn.UploadTicket>(
    'upload',
    'createUpload',
    {
      'kind': kind,
      'extension': extension,
    },
  );

  /// Confirms the upload and returns the public URL of the image.
  _ida.Future<String> verifyUpload(String path) =>
      caller.callServerEndpoint<String>(
        'upload',
        'verifyUpload',
        {'path': path},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    googleIdp = EndpointGoogleIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    account = EndpointAccount(this);
    booking = EndpointBooking(this);
    events = EndpointEvents(this);
    household = EndpointHousehold(this);
    notification = EndpointNotification(this);
    room = EndpointRoom(this);
    stats = EndpointStats(this);
    upload = EndpointUpload(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointGoogleIdp googleIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAccount account;

  late final EndpointBooking booking;

  late final EndpointEvents events;

  late final EndpointHousehold household;

  late final EndpointNotification notification;

  late final EndpointRoom room;

  late final EndpointStats stats;

  late final EndpointUpload upload;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'googleIdp': googleIdp,
    'jwtRefresh': jwtRefresh,
    'account': account,
    'booking': booking,
    'events': events,
    'household': household,
    'notification': notification,
    'room': room,
    'stats': stats,
    'upload': upload,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
