part of 'json.dart';

base class JsonDouble extends JsonField<double> {
  @override
  double defaultValue = 0.0;

  JsonDouble(
    super.name, {
    super.helper,
    super.isRequired,
    super.defaultValue,
  });
}
