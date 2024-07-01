part of 'json.dart';

base class JsonString extends JsonField<String> {
  JsonString(
    super.name, {
    super.helper,
    super.isRequired,
  }) : super(
          defaultValue: '',
        );
}
