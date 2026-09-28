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

/// Machine readable reason for a rejected booking (SRS 2.3.4).
enum BookingErrorCode implements _is.SerializableModel {
  overlap,
  outsideHours,
  roomClosed,
  tooShort,
  tooLong,
  notAligned,
  inPast,
  tooFarAhead,
  quotaExceeded,
  invalidRange,
  notAllowed,
  notFound,
  invalidState,
  seriesConflict;

  static BookingErrorCode fromJson(String name) {
    switch (name) {
      case 'overlap':
        return BookingErrorCode.overlap;
      case 'outsideHours':
        return BookingErrorCode.outsideHours;
      case 'roomClosed':
        return BookingErrorCode.roomClosed;
      case 'tooShort':
        return BookingErrorCode.tooShort;
      case 'tooLong':
        return BookingErrorCode.tooLong;
      case 'notAligned':
        return BookingErrorCode.notAligned;
      case 'inPast':
        return BookingErrorCode.inPast;
      case 'tooFarAhead':
        return BookingErrorCode.tooFarAhead;
      case 'quotaExceeded':
        return BookingErrorCode.quotaExceeded;
      case 'invalidRange':
        return BookingErrorCode.invalidRange;
      case 'notAllowed':
        return BookingErrorCode.notAllowed;
      case 'notFound':
        return BookingErrorCode.notFound;
      case 'invalidState':
        return BookingErrorCode.invalidState;
      case 'seriesConflict':
        return BookingErrorCode.seriesConflict;
      default:
        return BookingErrorCode.invalidRange;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
