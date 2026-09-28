import 'package:serverpod_auth_idp_server/providers/google.dart';

/// Google sign-in (SRS 2.1.1). Active when `googleClientSecret` is set in
/// `config/passwords.yaml`; the app shows the button when built with
/// `GOOGLE_CLIENT_ID` / `GOOGLE_SERVER_CLIENT_ID`.
class GoogleIdpEndpoint extends GoogleIdpBaseEndpoint {}
