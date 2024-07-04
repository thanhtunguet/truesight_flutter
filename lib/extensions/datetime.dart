part of 'extensions.dart';

extension DateTimeFormatter on DateTime {
  String format({
    String dateFormat = DateTimeFormatsVN.dateOnly,
  }) {
    return DateFormat(dateFormat).format(toLocal());
  }
}
