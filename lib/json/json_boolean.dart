part of 'json.dart';

base class JsonBoolean extends JsonField<bool> {
  @override
  bool defaultValue = false;

  JsonBoolean(
    super.name, {
    super.helper,
    super.isRequired,
    super.defaultValue = false,
  });
}
