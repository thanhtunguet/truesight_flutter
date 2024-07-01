part of 'json.dart';

base class JsonBoolean extends JsonField<bool> {
  JsonBoolean(
    super.name, {
    super.helper,
    super.isRequired,
  }) : super(
          defaultValue: false,
        );
}
