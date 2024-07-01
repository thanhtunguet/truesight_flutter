part of 'json.dart';

base class JsonNumber extends JsonField<num> {
  JsonNumber(
    super.name, {
    super.helper,
    super.isRequired,
  }) : super(
          defaultValue: 0,
        );
}
