part of 'json.dart';

base class JsonNumber extends JsonField<num> {
  @override
  num defaultValue = 0;

  JsonNumber(
    super.name, {
    super.helper,
    super.isRequired,
    super.defaultValue,
  });
}
