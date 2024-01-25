part of 'json.dart';

base class JsonDate extends JsonField<DateTime> {
  @override
  DateTime defaultValue = DateTime.now();

  JsonDate(
    super.name, {
    super.helper,
    super.isRequired,
    super.defaultValue,
  });

  @override
  void fromJSON(json) {
    if (json != null) {
      _value = DateTime.parse(json as String);
    }
  }

  @override
  String toJSON() {
    if (isRequired && _value == null) {
      throw Exception("Field is required but has not been set a value");
    }
    return _value?.toIso8601String() ?? "";
  }

  String format({String dateFormat = "YYYY-MM-DD"}) {
    return DateFormat(dateFormat).format(value);
  }
}
