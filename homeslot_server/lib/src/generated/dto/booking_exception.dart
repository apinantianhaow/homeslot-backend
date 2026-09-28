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
import 'package:homeslot_server/src/generated/protocol.dart' as _ig62mdor;
import 'package:serverpod/serverpod.dart' as _is;
import '../dto/series_occurrence.dart' as _itf4kjuy;
import '../dto/time_slot.dart' as _irjj1v9k;
import '../enums/booking_error_code.dart' as _itbchq5x;

/// Thrown when a booking breaks a rule. Carries alternatives when available.
abstract class BookingException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  BookingException._({
    required this.code,
    required this.message,
    this.suggestions,
    this.conflicts,
  });

  factory BookingException({
    required _itbchq5x.BookingErrorCode code,
    required String message,
    List<_irjj1v9k.TimeSlot>? suggestions,
    List<_itf4kjuy.SeriesOccurrence>? conflicts,
  }) = _BookingExceptionImpl;

  factory BookingException.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookingException(
      code: _itbchq5x.BookingErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
      message: jsonSerialization['message'] as String,
      suggestions: jsonSerialization['suggestions'] == null
          ? null
          : _ig62mdor.Protocol().deserialize<List<_irjj1v9k.TimeSlot>>(
              jsonSerialization['suggestions'],
            ),
      conflicts: jsonSerialization['conflicts'] == null
          ? null
          : _ig62mdor.Protocol().deserialize<List<_itf4kjuy.SeriesOccurrence>>(
              jsonSerialization['conflicts'],
            ),
    );
  }

  _itbchq5x.BookingErrorCode code;

  String message;

  List<_irjj1v9k.TimeSlot>? suggestions;

  List<_itf4kjuy.SeriesOccurrence>? conflicts;

  /// Returns a shallow copy of this [BookingException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookingException copyWith({
    _itbchq5x.BookingErrorCode? code,
    String? message,
    List<_irjj1v9k.TimeSlot>? suggestions,
    List<_itf4kjuy.SeriesOccurrence>? conflicts,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookingException',
      'code': code.toJson(),
      'message': message,
      if (suggestions != null)
        'suggestions': suggestions?.toJson(valueToJson: (v) => v.toJson()),
      if (conflicts != null)
        'conflicts': conflicts?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookingException',
      'code': code.toJson(),
      'message': message,
      if (suggestions != null)
        'suggestions': suggestions?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (conflicts != null)
        'conflicts': conflicts?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return 'BookingException(code: $code, message: $message, suggestions: $suggestions, conflicts: $conflicts)';
  }
}

class _Undefined {}

class _BookingExceptionImpl extends BookingException {
  _BookingExceptionImpl({
    required _itbchq5x.BookingErrorCode code,
    required String message,
    List<_irjj1v9k.TimeSlot>? suggestions,
    List<_itf4kjuy.SeriesOccurrence>? conflicts,
  }) : super._(
         code: code,
         message: message,
         suggestions: suggestions,
         conflicts: conflicts,
       );

  /// Returns a shallow copy of this [BookingException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookingException copyWith({
    _itbchq5x.BookingErrorCode? code,
    String? message,
    Object? suggestions = _Undefined,
    Object? conflicts = _Undefined,
  }) {
    return BookingException(
      code: code ?? this.code,
      message: message ?? this.message,
      suggestions: suggestions is List<_irjj1v9k.TimeSlot>?
          ? suggestions
          : this.suggestions?.map((e0) => e0.copyWith()).toList(),
      conflicts: conflicts is List<_itf4kjuy.SeriesOccurrence>?
          ? conflicts
          : this.conflicts?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
