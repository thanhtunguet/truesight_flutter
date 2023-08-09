part of 'json.dart';

class JsonDate extends JsonType<DateTime?> {
  JsonDate(
    super.name, {
    super.isRequired,
    super.defaultValue,
  });

  @override
  void fromJSON(dynamic value) {
    if (value is String) {
      this.value = DateTime.parse(value);
      return;
    }
    this.value = DateTime.now();
  }

  @override
  toJSON() {
    return value?.toIso8601String();
  }
}
