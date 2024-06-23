part of 'json.dart';

final _defaultDateTime = DateTime(1970, 1, 1);

base class JsonDate extends JsonField<DateTime> {
  @override
  DateTime defaultValue = _defaultDateTime;

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
  String? toJSON() {
    if (isRequired && _value == null) {
      throw Exception("Field is required but has not been set a value");
    }
    return _value?.toIso8601String();
  }

  String format({String dateFormat = "YYYY-MM-DD"}) {
    if (rawValue == null) {
      return '';
    }
    return value.format(dateFormat: dateFormat);
  }
}
