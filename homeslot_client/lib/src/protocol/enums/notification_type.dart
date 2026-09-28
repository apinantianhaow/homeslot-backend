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

/// Kind of notification sent to a user.
enum NotificationType implements _isc.SerializableModel {
  bookingReminder,
  approvalRequested,
  bookingApproved,
  bookingRejected,
  bookingExpired,
  bookingCancelledByOther,
  roomClosed,
  memberRemoved,
  roleChanged,
  general;

  static NotificationType fromJson(String name) {
    switch (name) {
      case 'bookingReminder':
        return NotificationType.bookingReminder;
      case 'approvalRequested':
        return NotificationType.approvalRequested;
      case 'bookingApproved':
        return NotificationType.bookingApproved;
      case 'bookingRejected':
        return NotificationType.bookingRejected;
      case 'bookingExpired':
        return NotificationType.bookingExpired;
      case 'bookingCancelledByOther':
        return NotificationType.bookingCancelledByOther;
      case 'roomClosed':
        return NotificationType.roomClosed;
      case 'memberRemoved':
        return NotificationType.memberRemoved;
      case 'roleChanged':
        return NotificationType.roleChanged;
      case 'general':
        return NotificationType.general;
      default:
        return NotificationType.general;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
