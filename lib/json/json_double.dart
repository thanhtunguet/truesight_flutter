part of 'json.dart';

base class JsonDouble extends JsonField<double> {
  JsonDouble(
    super.name, {
    super.helper,
    super.isRequired,
  }) : super(
          defaultValue: 0.0,
        );
}
