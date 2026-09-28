import 'package:timezone/timezone.dart' as tz;

import '../generated/protocol.dart';
import 'time_zones.dart';

/// Server-side text in Thai and English. Booking errors and notifications are
/// written in the user's language so the app can show them as-is (SRS 4.7).
abstract class Messages {
  const Messages();

  static Messages of(String? locale) =>
      locale == 'en' ? const _EnMessages() : const _ThMessages();

  List<String> get _weekdays;
  List<String> get _months;
  String get formerMember;

  String duration(int minutes);

  /// Formats a time range in the household time zone, e.g. `Fri 3 Oct 19:00–21:00`.
  String range(DateTime start, DateTime end, tz.Location location) {
    final s = TimeZones.local(start, location);
    final e = TimeZones.local(end, location);
    final sameDay =
        s.year == e.year && s.month == e.month && s.day == e.day ||
        (TimeZones.minuteOfDay(e) == 0 &&
            e.difference(s) <= const Duration(days: 1));
    if (sameDay) return '${_day(s)} ${_hm(s)}–${_hm(e, endOfDay: true)}';
    return '${_day(s)} ${_hm(s)} – ${_day(e)} ${_hm(e)}';
  }

  String _day(tz.TZDateTime t) =>
      '${_weekdays[t.weekday - 1]} ${t.day} ${_months[t.month - 1]}';

  String _hm(tz.TZDateTime t, {bool endOfDay = false}) {
    if (endOfDay && t.hour == 0 && t.minute == 0) return '24:00';
    return '${t.hour.toString().padLeft(2, '0')}:'
        '${t.minute.toString().padLeft(2, '0')}';
  }

  String bookingError(BookingErrorCode code, {Room? room, String? detail});

  ({String title, String body}) notification(
    NotificationType type,
    Map<String, String> p,
  );
}

class _ThMessages extends Messages {
  const _ThMessages();

  @override
  List<String> get _weekdays => const [
    'จ.',
    'อ.',
    'พ.',
    'พฤ.',
    'ศ.',
    'ส.',
    'อา.',
  ];

  @override
  List<String> get _months => const [
    'ม.ค.',
    'ก.พ.',
    'มี.ค.',
    'เม.ย.',
    'พ.ค.',
    'มิ.ย.',
    'ก.ค.',
    'ส.ค.',
    'ก.ย.',
    'ต.ค.',
    'พ.ย.',
    'ธ.ค.',
  ];

  @override
  String get formerMember => 'อดีตสมาชิก';

  @override
  String duration(int minutes) {
    final days = minutes ~/ 1440;
    final hours = (minutes % 1440) ~/ 60;
    final mins = minutes % 60;
    return [
      if (days > 0) '$days วัน',
      if (hours > 0) '$hours ชั่วโมง',
      if (mins > 0 || minutes == 0) '$mins นาที',
    ].join(' ');
  }

  @override
  String bookingError(BookingErrorCode code, {Room? room, String? detail}) {
    switch (code) {
      case BookingErrorCode.overlap:
        return 'ช่วงเวลานี้มีคนจองแล้ว ลองเลือกช่วงว่างที่แนะนำด้านล่าง';
      case BookingErrorCode.outsideHours:
        return 'ห้องไม่เปิดให้จองในช่วงเวลานี้';
      case BookingErrorCode.roomClosed:
        return 'ห้องปิดชั่วคราวในช่วงนี้${detail == null ? '' : ' ($detail)'}';
      case BookingErrorCode.tooShort:
        return 'ต้องจองอย่างน้อย ${duration(room?.minMinutes ?? 0)}';
      case BookingErrorCode.tooLong:
        return 'จองได้ครั้งละไม่เกิน ${duration(room?.maxMinutes ?? 0)}';
      case BookingErrorCode.notAligned:
        return 'เวลาเริ่มและสิ้นสุดต้องลงช่องละ ${room?.slotMinutes ?? 15} นาที';
      case BookingErrorCode.inPast:
        return 'จองย้อนหลังไม่ได้ กรุณาเลือกเวลาในอนาคต';
      case BookingErrorCode.tooFarAhead:
        return 'จองล่วงหน้าได้ไม่เกิน ${room?.advanceDays ?? 0} วัน';
      case BookingErrorCode.quotaExceeded:
        return 'เกินโควตาห้องนี้ ${duration(room?.weeklyQuotaMinutes ?? 0)} ต่อสัปดาห์'
            '${detail == null ? '' : ' (ใช้ไปแล้ว $detail)'}';
      case BookingErrorCode.invalidRange:
        return 'เวลาสิ้นสุดต้องอยู่หลังเวลาเริ่ม';
      case BookingErrorCode.notAllowed:
        return 'คุณไม่มีสิทธิ์ทำรายการนี้';
      case BookingErrorCode.notFound:
        return 'ไม่พบการจองหรือห้องนี้';
      case BookingErrorCode.invalidState:
        return detail ?? 'การจองนี้เปลี่ยนแปลงไม่ได้แล้ว';
      case BookingErrorCode.seriesConflict:
        return 'บางสัปดาห์จองไม่ได้ เลือกข้ามวันที่ชนหรือยกเลิกทั้งชุด';
    }
  }

  @override
  ({String title, String body}) notification(
    NotificationType type,
    Map<String, String> p,
  ) {
    final room = p['room'] ?? '';
    final time = p['time'] ?? '';
    final reason = p['reason'];
    switch (type) {
      case NotificationType.bookingReminder:
        return (
          title: 'อีก ${p['minutes']} นาทีถึงเวลาใช้$room',
          body: time,
        );
      case NotificationType.approvalRequested:
        return (
          title: 'คำขอจองใหม่: $room',
          body: '${p['user']} ขอจอง $time',
        );
      case NotificationType.bookingApproved:
        return (title: 'อนุมัติการจอง$room แล้ว', body: time);
      case NotificationType.bookingRejected:
        return (
          title: 'คำขอจอง$room ถูกปฏิเสธ',
          body: '$time${reason == null ? '' : ' · เหตุผล: $reason'}',
        );
      case NotificationType.bookingExpired:
        return (
          title: 'คำขอจอง$room หมดอายุ',
          body: 'ผู้ดูแลยังไม่ได้ตัดสินก่อนถึงเวลาเริ่ม ($time)',
        );
      case NotificationType.bookingCancelledByOther:
        return (
          title: 'การจอง$room ถูกยกเลิก',
          body:
              '${p['user']} ยกเลิกการจอง $time'
              '${reason == null ? '' : ' · เหตุผล: $reason'}',
        );
      case NotificationType.roomClosed:
        return (
          title: '$room ปิดชั่วคราว',
          body: p['shortened'] == 'true'
              ? 'การจองของคุณสิ้นสุดเร็วขึ้นเป็น $time${reason == null ? '' : ': $reason'}'
              : 'การจอง $time ถูกยกเลิก${reason == null ? '' : ': $reason'}',
        );
      case NotificationType.memberRemoved:
        return (
          title: 'คุณถูกนำออกจากบ้าน ${p['household']}',
          body: 'การจองในอนาคตของคุณถูกยกเลิกแล้ว',
        );
      case NotificationType.roleChanged:
        return (
          title: 'บทบาทของคุณเปลี่ยนแล้ว',
          body:
              'ตอนนี้คุณเป็น${p['role'] == 'owner' ? 'ผู้ดูแลบ้าน' : 'สมาชิก'}ของ ${p['household']}',
        );
      case NotificationType.general:
        return (title: p['title'] ?? 'HomeSlot', body: p['body'] ?? '');
    }
  }
}

class _EnMessages extends Messages {
  const _EnMessages();

  @override
  List<String> get _weekdays => const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  List<String> get _months => const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  String get formerMember => 'Former member';

  @override
  String duration(int minutes) {
    final days = minutes ~/ 1440;
    final hours = (minutes % 1440) ~/ 60;
    final mins = minutes % 60;
    return [
      if (days > 0) '$days ${days == 1 ? 'day' : 'days'}',
      if (hours > 0) '$hours h',
      if (mins > 0 || minutes == 0) '$mins min',
    ].join(' ');
  }

  @override
  String bookingError(BookingErrorCode code, {Room? room, String? detail}) {
    switch (code) {
      case BookingErrorCode.overlap:
        return 'Someone has already booked this time. Try one of the free slots below.';
      case BookingErrorCode.outsideHours:
        return 'The room is not open for booking at this time.';
      case BookingErrorCode.roomClosed:
        return 'The room is temporarily closed${detail == null ? '' : ' ($detail)'}.';
      case BookingErrorCode.tooShort:
        return 'Bookings must be at least ${duration(room?.minMinutes ?? 0)}.';
      case BookingErrorCode.tooLong:
        return 'Bookings can be at most ${duration(room?.maxMinutes ?? 0)}.';
      case BookingErrorCode.notAligned:
        return 'Start and end must be on ${room?.slotMinutes ?? 15}-minute steps.';
      case BookingErrorCode.inPast:
        return 'You cannot book a time in the past.';
      case BookingErrorCode.tooFarAhead:
        return 'You can book at most ${room?.advanceDays ?? 0} days ahead.';
      case BookingErrorCode.quotaExceeded:
        return 'This exceeds your weekly quota of '
            '${duration(room?.weeklyQuotaMinutes ?? 0)} for this room'
            '${detail == null ? '' : ' (already used $detail)'}.';
      case BookingErrorCode.invalidRange:
        return 'The end time must be after the start time.';
      case BookingErrorCode.notAllowed:
        return 'You are not allowed to do this.';
      case BookingErrorCode.notFound:
        return 'The booking or room was not found.';
      case BookingErrorCode.invalidState:
        return detail ?? 'This booking can no longer be changed.';
      case BookingErrorCode.seriesConflict:
        return 'Some weeks cannot be booked. Skip the conflicting dates or cancel the series.';
    }
  }

  @override
  ({String title, String body}) notification(
    NotificationType type,
    Map<String, String> p,
  ) {
    final room = p['room'] ?? '';
    final time = p['time'] ?? '';
    final reason = p['reason'];
    switch (type) {
      case NotificationType.bookingReminder:
        return (title: '$room starts in ${p['minutes']} min', body: time);
      case NotificationType.approvalRequested:
        return (
          title: 'New booking request: $room',
          body: '${p['user']} requested $time',
        );
      case NotificationType.bookingApproved:
        return (title: 'Your $room booking was approved', body: time);
      case NotificationType.bookingRejected:
        return (
          title: 'Your $room request was rejected',
          body: '$time${reason == null ? '' : ' · Reason: $reason'}',
        );
      case NotificationType.bookingExpired:
        return (
          title: 'Your $room request expired',
          body: 'No owner decided before it started ($time).',
        );
      case NotificationType.bookingCancelledByOther:
        return (
          title: 'Your $room booking was cancelled',
          body:
              '${p['user']} cancelled $time'
              '${reason == null ? '' : ' · Reason: $reason'}',
        );
      case NotificationType.roomClosed:
        return (
          title: '$room is temporarily closed',
          body: p['shortened'] == 'true'
              ? 'Your booking now ends earlier: $time${reason == null ? '' : ' ($reason)'}'
              : 'Your booking $time was cancelled${reason == null ? '' : ': $reason'}',
        );
      case NotificationType.memberRemoved:
        return (
          title: 'You were removed from ${p['household']}',
          body: 'Your upcoming bookings were cancelled.',
        );
      case NotificationType.roleChanged:
        return (
          title: 'Your role changed',
          body:
              'You are now ${p['role'] == 'owner' ? 'an owner' : 'a member'} of ${p['household']}.',
        );
      case NotificationType.general:
        return (title: p['title'] ?? 'HomeSlot', body: p['body'] ?? '');
    }
  }
}
