import '../generated/protocol.dart';

AppException appError(AppErrorCode code, String message) =>
    AppException(code: code, message: message);

Never fail(AppErrorCode code, String message) => throw appError(code, message);

/// Trims [value] and returns null when empty. Throws when longer than [max].
String? cleanOptional(String? value, {required int max, String field = ''}) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) return null;
  if (trimmed.length > max) {
    fail(AppErrorCode.validation, '$field is too long (max $max characters).');
  }
  return trimmed;
}

String cleanRequired(String value, {required int max, String field = ''}) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    fail(AppErrorCode.validation, '$field is required.');
  }
  if (trimmed.length > max) {
    fail(AppErrorCode.validation, '$field is too long (max $max characters).');
  }
  return trimmed;
}

final _hexColor = RegExp(r'^#[0-9A-Fa-f]{6}$');

bool isHexColor(String value) => _hexColor.hasMatch(value);

/// Trims an optional image URL and accepts only http(s) URLs.
String? cleanUrl(String? value, {String field = 'URL'}) {
  final url = cleanOptional(value, max: 1000, field: field);
  if (url == null) return null;
  final uri = Uri.tryParse(url);
  if (uri == null ||
      !(uri.isScheme('http') || uri.isScheme('https')) ||
      uri.host.isEmpty) {
    fail(AppErrorCode.validation, '$field must be an http(s) URL.');
  }
  return url;
}
