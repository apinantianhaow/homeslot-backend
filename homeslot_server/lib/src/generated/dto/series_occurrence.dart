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
import 'package:serverpod/serverpod.dart' as _is;
import '../enums/booking_error_code.dart' as _itbchq5x;

/// One occurrence of a recurring booking and whether it can be booked.
abstract class SeriesOccurrence
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SeriesOccurrence._({
    required this.startAt,
    required this.endAt,
    required this.ok,
    this.code,
    this.message,
  });

  factory SeriesOccurrence({
    required DateTime startAt,
    required DateTime endAt,
    required bool ok,
    _itbchq5x.BookingErrorCode? code,
    String? message,
  }) = _SeriesOccurrenceImpl;

  factory SeriesOccurrence.fromJson(Map<String, dynamic> jsonSerialization) {
    return SeriesOccurrence(
      startAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['startAt']),
      endAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['endAt']),
      ok: _is.BoolJsonExtension.fromJson(jsonSerialization['ok']),
      code: jsonSerialization['code'] == null
          ? null
          : _itbchq5x.BookingErrorCode.fromJson(
              (jsonSerialization['code'] as String),
            ),
      message: jsonSerialization['message'] as String?,
    );
  }

  DateTime startAt;

  DateTime endAt;

  bool ok;

  _itbchq5x.BookingErrorCode? code;

  String? message;

  /// Returns a shallow copy of this [SeriesOccurrence]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SeriesOccurrence copyWith({
    DateTime? startAt,
    DateTime? endAt,
    bool? ok,
    _itbchq5x.BookingErrorCode? code,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SeriesOccurrence',
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      'ok': ok,
      if (code != null) 'code': code?.toJson(),
      if (message != null) 'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SeriesOccurrence',
      'startAt': startAt.toJson(),
      'endAt': endAt.toJson(),
      'ok': ok,
      if (code != null) 'code': code?.toJson(),
      if (message != null) 'message': message,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SeriesOccurrenceImpl extends SeriesOccurrence {
  _SeriesOccurrenceImpl({
    required DateTime startAt,
    required DateTime endAt,
    required bool ok,
    _itbchq5x.BookingErrorCode? code,
    String? message,
  }) : super._(
         startAt: startAt,
         endAt: endAt,
         ok: ok,
         code: code,
         message: message,
       );

  /// Returns a shallow copy of this [SeriesOccurrence]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SeriesOccurrence copyWith({
    DateTime? startAt,
    DateTime? endAt,
    bool? ok,
    Object? code = _Undefined,
    Object? message = _Undefined,
  }) {
    return SeriesOccurrence(
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      ok: ok ?? this.ok,
      code: code is _itbchq5x.BookingErrorCode? ? code : this.code,
      message: message is String? ? message : this.message,
    );
  }
}
