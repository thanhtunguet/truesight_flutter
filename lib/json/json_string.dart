part of 'json.dart';

base class JsonString extends JsonField<String> {
  @override
  String defaultValue = "";

  JsonString(
    super.name, {
    super.helper,
    super.isRequired,
    super.defaultValue,
  });
}
