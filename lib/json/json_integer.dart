part of 'json.dart';

base class JsonInteger extends JsonField<int> {
  JsonInteger(
    super.name, {
    super.helper,
    super.isRequired,
  }) : super(
          defaultValue: 0,
        );
}
