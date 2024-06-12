import 'package:intl/intl.dart';

abstract class DateTimeFormatsVN {
  static const String dateTime = 'dd/MM/yyyy HH:mm:ss';
  static const String dateTimeWithoutSeconds = 'dd/MM/yyyy HH:mm';
  static const String dateOnly = 'dd/MM/yyyy';
  static const String timeOnly = 'HH:mm:ss';
  static const String dateWithDayAndMonthOnly = 'dd/MM';
  static const String yearOnly = 'yyyy';

  // Additional formats can be added as needed
  static const String dateWithDayName =
      'EEEE, dd/MM/yyyy'; // Example: Thứ Hai, 01/01/2024
  static const String dateWithMonthName =
      'dd MMMM yyyy'; // Example: 01 Tháng Giêng 2024
  static const String shortDateWithMonthName = 'dd MMM'; // Example: 01 Thg 01

  // Helper function to format a DateTime using one of the above formats
  static String format(DateTime dateTime, String format) {
    return DateFormat(format, 'vi').format(dateTime);
  }
}

extension DateTimeFormatter on DateTime {
  String format({
    String dateFormat = DateTimeFormatsVN.dateOnly,
  }) {
    return DateFormat(dateFormat).format(toLocal());
  }
}
