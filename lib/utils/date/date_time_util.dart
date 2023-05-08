// ignore_for_file: depend_on_referenced_packages

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' ;
import 'package:logger/logger.dart';

class DateUtility {
  static bool isArabicLang() {
    return true;
  }

  static String getChatTime(String date) {
    initializeDateFormatting(isArabicLang() ? 'ar' : 'en');
    try {
      if (date.isEmpty) {
        return '';
      }
      String msg = '';
      var dt = DateTime.parse(date).toLocal();
      if (DateTime.now().toLocal().isBefore(dt)) {
        return DateFormat.jm()
            .format(DateTime.parse(date).toLocal())
            .toString();
      }
      var dur = DateTime.now().toLocal().difference(dt);
      if (dur.inDays > 0) {
        msg = '${dur.inDays} يوم';
        return dur.inDays == 1
            ? 'منذ 1 يوم'
            : DateFormat("dd MMM", isArabicLang() ? 'ar' : 'en').format(dt);
      } else if (dur.inHours > 0) {
        msg = 'منذ ${dur.inHours} ساعة';
      } else if (dur.inMinutes > 0) {
        msg = 'منذ ${dur.inMinutes} دقيقة';
      } else if (dur.inSeconds > 0) {
        msg = 'منذ ${dur.inSeconds} ثانية';
      } else {
        msg = 'منذ ثواني';
      }
      return msg;
    } catch (e) {
      Logger().d(e);
      return "";
    }
  }

  static Duration getReminingTime() {
    return const Duration(seconds: 1);
  }

  // get the difference between two dates
  Duration getDifference({required DateTime endDate}) {
    try {
      DateTime currentDate = /*Timestamp.now().toDate() */ DateTime.now();
      // Duration diff = endDate.difference(currentDate);
      Duration diff = endDate.difference(currentDate);
      if (currentDate.isBefore(endDate)) {
        int days = diff.inDays;
        int hours = diff.inHours;
        int minutes = diff.inMinutes;
        int seconds = diff.inSeconds;
        Logger().e(
            "days: $days, hours: $hours, minutes: $minutes, seconds: $seconds");
        return Duration(
            days: days,
            hours: hours,
            minutes: (minutes) ~/ 2,
            seconds: (seconds) ~/ 2);
      } else {
        return const Duration(seconds: 0);
      }
    } catch (e) {
      return const Duration(seconds: 0);
    }
  }
}
