part of 'json.dart';

class JsonDate extends JsonType<DateTime> {
  JsonDate(
    super.name, {
    super.isRequired,
    super.defaultValue,
  });

  @override
  DateTime? deserialize(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    }
    return null;
  }
}
