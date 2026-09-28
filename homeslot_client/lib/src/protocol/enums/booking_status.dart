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

/// Lifecycle status of a booking (SRS 2.4, 6 states).
///
/// Only [pending] and [confirmed] hold the time slot; the exclusion
/// constraint `bookings_no_overlap` enforces this in the database.
enum BookingStatus implements _isc.SerializableModel {
  pending,
  confirmed,
  rejected,
  expired,
  cancelled,
  completed;

  static BookingStatus fromJson(String name) {
    switch (name) {
      case 'pending':
        return BookingStatus.pending;
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'rejected':
        return BookingStatus.rejected;
      case 'expired':
        return BookingStatus.expired;
      case 'cancelled':
        return BookingStatus.cancelled;
      case 'completed':
        return BookingStatus.completed;
      default:
        return BookingStatus.pending;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
