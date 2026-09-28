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

/// Machine readable reason for a general application error.
enum AppErrorCode implements _isc.SerializableModel {
  notMember,
  notOwner,
  notFound,
  alreadyMember,
  invalidInvite,
  inviteLocked,
  lastOwner,
  limitReached,
  roomHasFutureBookings,
  validation;

  static AppErrorCode fromJson(String name) {
    switch (name) {
      case 'notMember':
        return AppErrorCode.notMember;
      case 'notOwner':
        return AppErrorCode.notOwner;
      case 'notFound':
        return AppErrorCode.notFound;
      case 'alreadyMember':
        return AppErrorCode.alreadyMember;
      case 'invalidInvite':
        return AppErrorCode.invalidInvite;
      case 'inviteLocked':
        return AppErrorCode.inviteLocked;
      case 'lastOwner':
        return AppErrorCode.lastOwner;
      case 'limitReached':
        return AppErrorCode.limitReached;
      case 'roomHasFutureBookings':
        return AppErrorCode.roomHasFutureBookings;
      case 'validation':
        return AppErrorCode.validation;
      default:
        return AppErrorCode.validation;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
