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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../enums/app_error_code.dart' as _ijxjrbf5;

/// Thrown for permission, membership and validation errors.
abstract class AppException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  AppException._({
    required this.code,
    required this.message,
  });

  factory AppException({
    required _ijxjrbf5.AppErrorCode code,
    required String message,
  }) = _AppExceptionImpl;

  factory AppException.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppException(
      code: _ijxjrbf5.AppErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
      message: jsonSerialization['message'] as String,
    );
  }

  _ijxjrbf5.AppErrorCode code;

  String message;

  /// Returns a shallow copy of this [AppException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AppException copyWith({
    _ijxjrbf5.AppErrorCode? code,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppException',
      'code': code.toJson(),
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppException',
      'code': code.toJson(),
      'message': message,
    };
  }

  @override
  String toString() {
    return 'AppException(code: $code, message: $message)';
  }
}

class _AppExceptionImpl extends AppException {
  _AppExceptionImpl({
    required _ijxjrbf5.AppErrorCode code,
    required String message,
  }) : super._(
         code: code,
         message: message,
       );

  /// Returns a shallow copy of this [AppException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AppException copyWith({
    _ijxjrbf5.AppErrorCode? code,
    String? message,
  }) {
    return AppException(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}
