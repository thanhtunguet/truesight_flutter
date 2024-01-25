part of 'json.dart';

base class JsonInteger extends JsonField<int> {
  @override
  int defaultValue = 0;

  JsonInteger(
    super.name, {
    super.helper,
    super.isRequired,
    super.defaultValue,
  });
}
