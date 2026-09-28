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
import '../tables/booking.dart' as _isap1638;

/// A booking with the display data needed by the calendar.
abstract class BookingView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  BookingView._({
    required this.booking,
    required this.roomName,
    required this.userName,
    required this.userColor,
  });

  factory BookingView({
    required _isap1638.Booking booking,
    required String roomName,
    required String userName,
    required String userColor,
  }) = _BookingViewImpl;

  factory BookingView.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookingView(
      booking: _ig62mdor.Protocol().deserialize<_isap1638.Booking>(
        jsonSerialization['booking'],
      ),
      roomName: jsonSerialization['roomName'] as String,
      userName: jsonSerialization['userName'] as String,
      userColor: jsonSerialization['userColor'] as String,
    );
  }

  _isap1638.Booking booking;

  String roomName;

  String userName;

  String userColor;

  /// Returns a shallow copy of this [BookingView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookingView copyWith({
    _isap1638.Booking? booking,
    String? roomName,
    String? userName,
    String? userColor,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookingView',
      'booking': booking.toJson(),
      'roomName': roomName,
      'userName': userName,
      'userColor': userColor,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookingView',
      'booking': booking.toJsonForProtocol(),
      'roomName': roomName,
      'userName': userName,
      'userColor': userColor,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _BookingViewImpl extends BookingView {
  _BookingViewImpl({
    required _isap1638.Booking booking,
    required String roomName,
    required String userName,
    required String userColor,
  }) : super._(
         booking: booking,
         roomName: roomName,
         userName: userName,
         userColor: userColor,
       );

  /// Returns a shallow copy of this [BookingView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookingView copyWith({
    _isap1638.Booking? booking,
    String? roomName,
    String? userName,
    String? userColor,
  }) {
    return BookingView(
      booking: booking ?? this.booking.copyWith(),
      roomName: roomName ?? this.roomName,
      userName: userName ?? this.userName,
      userColor: userColor ?? this.userColor,
    );
  }
}
