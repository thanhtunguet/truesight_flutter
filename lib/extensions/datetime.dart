import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String format({
    String dateFormat = "YYYY-MM-DD",
  }) {
    return DateFormat(dateFormat).format(toLocal());
  }
}
