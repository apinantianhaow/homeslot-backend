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
import 'package:homeslot_server/src/generated/dto/booking_request.dart'
    as _ipfpndb7;
import 'package:homeslot_server/src/generated/dto/series_request.dart'
    as _ilqhasg8;
import 'package:homeslot_server/src/generated/enums/edit_scope.dart'
    as _i1qteodz;
import 'package:homeslot_server/src/generated/enums/member_role.dart'
    as _i83j7v5z;
import 'package:homeslot_server/src/generated/enums/stats_period.dart'
    as _i1q74uto;
import 'package:homeslot_server/src/generated/future_calls.dart' as _ihc8avwy;
import 'package:homeslot_server/src/generated/tables/room.dart' as _iuxh3451;
import 'package:homeslot_server/src/generated/tables/room_hours.dart'
    as _i3dfjhwo;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/google_idp_endpoint.dart' as _i71axiz0;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/account_endpoint.dart' as _iaho7ul5;
import '../endpoints/booking_endpoint.dart' as _im4chbds;
import '../endpoints/events_endpoint.dart' as _iwck6i2z;
import '../endpoints/household_endpoint.dart' as _izqmqbob;
import '../endpoints/notification_endpoint.dart' as _ihb11yhk;
import '../endpoints/room_endpoint.dart' as _io7erjyw;
import '../endpoints/stats_endpoint.dart' as _ii1l42ti;
import '../endpoints/upload_endpoint.dart' as _ik1hmt14;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'googleIdp': _i71axiz0.GoogleIdpEndpoint()
        ..initialize(
          server,
          'googleIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'account': _iaho7ul5.AccountEndpoint()
        ..initialize(
          server,
          'account',
          null,
        ),
      'booking': _im4chbds.BookingEndpoint()
        ..initialize(
          server,
          'booking',
          null,
        ),
      'events': _iwck6i2z.EventsEndpoint()
        ..initialize(
          server,
          'events',
          null,
        ),
      'household': _izqmqbob.HouseholdEndpoint()
        ..initialize(
          server,
          'household',
          null,
        ),
      'notification': _ihb11yhk.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'room': _io7erjyw.RoomEndpoint()
        ..initialize(
          server,
          'room',
          null,
        ),
      'stats': _ii1l42ti.StatsEndpoint()
        ..initialize(
          server,
          'stats',
          null,
        ),
      'upload': _ik1hmt14.UploadEndpoint()
        ..initialize(
          server,
          'upload',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['googleIdp'] = _is.EndpointConnector(
      name: 'googleIdp',
      endpoint: endpoints['googleIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'idToken': _is.ParameterDescription(
              name: 'idToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint).login(
                    session,
                    idToken: params['idToken'],
                    accessToken: params['accessToken'],
                  ),
        ),
        'loginWithCode': _is.MethodConnector(
          name: 'loginWithCode',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'codeVerifier': _is.ParameterDescription(
              name: 'codeVerifier',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'redirectUri': _is.ParameterDescription(
              name: 'redirectUri',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint)
                  .loginWithCode(
                    session,
                    code: params['code'],
                    codeVerifier: params['codeVerifier'],
                    redirectUri: params['redirectUri'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['account'] = _is.EndpointConnector(
      name: 'account',
      endpoint: endpoints['account']!,
      methodConnectors: {
        'me': _is.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _iaho7ul5.AccountEndpoint).me(
                session,
              ),
        ),
        'updateProfile': _is.MethodConnector(
          name: 'updateProfile',
          params: {
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'color': _is.ParameterDescription(
              name: 'color',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'avatarUrl': _is.ParameterDescription(
              name: 'avatarUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _iaho7ul5.AccountEndpoint)
                  .updateProfile(
                    session,
                    params['displayName'],
                    params['color'],
                    params['avatarUrl'],
                  ),
        ),
        'updateSettings': _is.MethodConnector(
          name: 'updateSettings',
          params: {
            'reminderEnabled': _is.ParameterDescription(
              name: 'reminderEnabled',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'reminderMinutes': _is.ParameterDescription(
              name: 'reminderMinutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'locale': _is.ParameterDescription(
              name: 'locale',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _iaho7ul5.AccountEndpoint)
                  .updateSettings(
                    session,
                    params['reminderEnabled'],
                    params['reminderMinutes'],
                    params['locale'],
                  ),
        ),
        'registerDevice': _is.MethodConnector(
          name: 'registerDevice',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'platform': _is.ParameterDescription(
              name: 'platform',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _iaho7ul5.AccountEndpoint)
                  .registerDevice(
                    session,
                    params['token'],
                    params['platform'],
                  ),
        ),
        'unregisterDevice': _is.MethodConnector(
          name: 'unregisterDevice',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _iaho7ul5.AccountEndpoint)
                  .unregisterDevice(
                    session,
                    params['token'],
                  ),
        ),
        'deleteAccount': _is.MethodConnector(
          name: 'deleteAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _iaho7ul5.AccountEndpoint)
                  .deleteAccount(session),
        ),
      },
    );
    connectors['booking'] = _is.EndpointConnector(
      name: 'booking',
      endpoint: endpoints['booking']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _im4chbds.BookingEndpoint).list(
                    session,
                    params['from'],
                    params['to'],
                    params['roomId'],
                  ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ipfpndb7.BookingRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _im4chbds.BookingEndpoint).create(
                    session,
                    params['request'],
                  ),
        ),
        'suggest': _is.MethodConnector(
          name: 'suggest',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'startAt': _is.ParameterDescription(
              name: 'startAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'endAt': _is.ParameterDescription(
              name: 'endAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _im4chbds.BookingEndpoint).suggest(
                    session,
                    params['roomId'],
                    params['startAt'],
                    params['endAt'],
                  ),
        ),
        'previewSeries': _is.MethodConnector(
          name: 'previewSeries',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ilqhasg8.SeriesRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['booking'] as _im4chbds.BookingEndpoint)
                  .previewSeries(
                    session,
                    params['request'],
                  ),
        ),
        'createSeries': _is.MethodConnector(
          name: 'createSeries',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ilqhasg8.SeriesRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['booking'] as _im4chbds.BookingEndpoint)
                  .createSeries(
                    session,
                    params['request'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'startAt': _is.ParameterDescription(
              name: 'startAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'endAt': _is.ParameterDescription(
              name: 'endAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'purpose': _is.ParameterDescription(
              name: 'purpose',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'scope': _is.ParameterDescription(
              name: 'scope',
              type: _is.getType<_i1qteodz.EditScope>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _im4chbds.BookingEndpoint).update(
                    session,
                    params['bookingId'],
                    params['startAt'],
                    params['endAt'],
                    params['purpose'],
                    params['note'],
                    params['scope'],
                  ),
        ),
        'cancel': _is.MethodConnector(
          name: 'cancel',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'scope': _is.ParameterDescription(
              name: 'scope',
              type: _is.getType<_i1qteodz.EditScope>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _im4chbds.BookingEndpoint).cancel(
                    session,
                    params['bookingId'],
                    params['scope'],
                    params['reason'],
                  ),
        ),
        'release': _is.MethodConnector(
          name: 'release',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _im4chbds.BookingEndpoint).release(
                    session,
                    params['bookingId'],
                  ),
        ),
        'mine': _is.MethodConnector(
          name: 'mine',
          params: {
            'upcoming': _is.ParameterDescription(
              name: 'upcoming',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _im4chbds.BookingEndpoint).mine(
                    session,
                    params['upcoming'],
                    params['limit'],
                    params['offset'],
                  ),
        ),
        'pending': _is.MethodConnector(
          name: 'pending',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['booking'] as _im4chbds.BookingEndpoint)
                  .pending(session),
        ),
        'approve': _is.MethodConnector(
          name: 'approve',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'scope': _is.ParameterDescription(
              name: 'scope',
              type: _is.getType<_i1qteodz.EditScope>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _im4chbds.BookingEndpoint).approve(
                    session,
                    params['bookingId'],
                    params['scope'],
                  ),
        ),
        'reject': _is.MethodConnector(
          name: 'reject',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'scope': _is.ParameterDescription(
              name: 'scope',
              type: _is.getType<_i1qteodz.EditScope>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _im4chbds.BookingEndpoint).reject(
                    session,
                    params['bookingId'],
                    params['reason'],
                    params['scope'],
                  ),
        ),
      },
    );
    connectors['events'] = _is.EndpointConnector(
      name: 'events',
      endpoint: endpoints['events']!,
      methodConnectors: {
        'subscribe': _is.MethodStreamConnector(
          name: 'subscribe',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['events'] as _iwck6i2z.EventsEndpoint).subscribe(
                session,
              ),
        ),
      },
    );
    connectors['household'] = _is.EndpointConnector(
      name: 'household',
      endpoint: endpoints['household']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'timezone': _is.ParameterDescription(
              name: 'timezone',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['household'] as _izqmqbob.HouseholdEndpoint)
                  .create(
                    session,
                    params['name'],
                    params['timezone'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'timezone': _is.ParameterDescription(
              name: 'timezone',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['household'] as _izqmqbob.HouseholdEndpoint)
                  .update(
                    session,
                    params['name'],
                    params['timezone'],
                  ),
        ),
        'members': _is.MethodConnector(
          name: 'members',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['household'] as _izqmqbob.HouseholdEndpoint)
                  .members(session),
        ),
        'createInvite': _is.MethodConnector(
          name: 'createInvite',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['household'] as _izqmqbob.HouseholdEndpoint)
                  .createInvite(session),
        ),
        'activeInvites': _is.MethodConnector(
          name: 'activeInvites',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['household'] as _izqmqbob.HouseholdEndpoint)
                  .activeInvites(session),
        ),
        'revokeInvite': _is.MethodConnector(
          name: 'revokeInvite',
          params: {
            'invitationId': _is.ParameterDescription(
              name: 'invitationId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['household'] as _izqmqbob.HouseholdEndpoint)
                  .revokeInvite(
                    session,
                    params['invitationId'],
                  ),
        ),
        'join': _is.MethodConnector(
          name: 'join',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['household'] as _izqmqbob.HouseholdEndpoint).join(
                    session,
                    params['code'],
                  ),
        ),
        'changeRole': _is.MethodConnector(
          name: 'changeRole',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<_i83j7v5z.MemberRole>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['household'] as _izqmqbob.HouseholdEndpoint)
                  .changeRole(
                    session,
                    params['userId'],
                    params['role'],
                  ),
        ),
        'removeMember': _is.MethodConnector(
          name: 'removeMember',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['household'] as _izqmqbob.HouseholdEndpoint)
                  .removeMember(
                    session,
                    params['userId'],
                  ),
        ),
        'leave': _is.MethodConnector(
          name: 'leave',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['household'] as _izqmqbob.HouseholdEndpoint)
                  .leave(session),
        ),
      },
    );
    connectors['notification'] = _is.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .list(session),
        ),
        'unreadCount': _is.MethodConnector(
          name: 'unreadCount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .unreadCount(session),
        ),
        'markRead': _is.MethodConnector(
          name: 'markRead',
          params: {
            'notificationId': _is.ParameterDescription(
              name: 'notificationId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .markRead(
                        session,
                        params['notificationId'],
                      ),
        ),
        'markAllRead': _is.MethodConnector(
          name: 'markAllRead',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .markAllRead(session),
        ),
      },
    );
    connectors['room'] = _is.EndpointConnector(
      name: 'room',
      endpoint: endpoints['room']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['room'] as _io7erjyw.RoomEndpoint).list(session),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _io7erjyw.RoomEndpoint).get(
                session,
                params['roomId'],
              ),
        ),
        'statusNow': _is.MethodConnector(
          name: 'statusNow',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _io7erjyw.RoomEndpoint)
                  .statusNow(session),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'room': _is.ParameterDescription(
              name: 'room',
              type: _is.getType<_iuxh3451.Room>(),
              nullable: false,
            ),
            'hours': _is.ParameterDescription(
              name: 'hours',
              type: _is.getType<List<_i3dfjhwo.RoomHours>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _io7erjyw.RoomEndpoint).create(
                session,
                params['room'],
                params['hours'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'room': _is.ParameterDescription(
              name: 'room',
              type: _is.getType<_iuxh3451.Room>(),
              nullable: false,
            ),
            'hours': _is.ParameterDescription(
              name: 'hours',
              type: _is.getType<List<_i3dfjhwo.RoomHours>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _io7erjyw.RoomEndpoint).update(
                session,
                params['room'],
                params['hours'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _io7erjyw.RoomEndpoint).delete(
                session,
                params['roomId'],
              ),
        ),
        'close': _is.MethodConnector(
          name: 'close',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'startAt': _is.ParameterDescription(
              name: 'startAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'endAt': _is.ParameterDescription(
              name: 'endAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _io7erjyw.RoomEndpoint).close(
                session,
                params['roomId'],
                params['startAt'],
                params['endAt'],
                params['reason'],
              ),
        ),
        'removeClosure': _is.MethodConnector(
          name: 'removeClosure',
          params: {
            'closureId': _is.ParameterDescription(
              name: 'closureId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['room'] as _io7erjyw.RoomEndpoint).removeClosure(
                    session,
                    params['closureId'],
                  ),
        ),
      },
    );
    connectors['stats'] = _is.EndpointConnector(
      name: 'stats',
      endpoint: endpoints['stats']!,
      methodConnectors: {
        'usage': _is.MethodConnector(
          name: 'usage',
          params: {
            'period': _is.ParameterDescription(
              name: 'period',
              type: _is.getType<_i1q74uto.StatsPeriod>(),
              nullable: false,
            ),
            'anchor': _is.ParameterDescription(
              name: 'anchor',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['stats'] as _ii1l42ti.StatsEndpoint).usage(
                session,
                params['period'],
                params['anchor'],
              ),
        ),
        'peakHours': _is.MethodConnector(
          name: 'peakHours',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'days': _is.ParameterDescription(
              name: 'days',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['stats'] as _ii1l42ti.StatsEndpoint).peakHours(
                    session,
                    params['roomId'],
                    params['days'],
                  ),
        ),
      },
    );
    connectors['upload'] = _is.EndpointConnector(
      name: 'upload',
      endpoint: endpoints['upload']!,
      methodConnectors: {
        'createUpload': _is.MethodConnector(
          name: 'createUpload',
          params: {
            'kind': _is.ParameterDescription(
              name: 'kind',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'extension': _is.ParameterDescription(
              name: 'extension',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['upload'] as _ik1hmt14.UploadEndpoint)
                  .createUpload(
                    session,
                    params['kind'],
                    params['extension'],
                  ),
        ),
        'verifyUpload': _is.MethodConnector(
          name: 'verifyUpload',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['upload'] as _ik1hmt14.UploadEndpoint)
                  .verifyUpload(
                    session,
                    params['path'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _ihc8avwy.FutureCalls();
  }
}
