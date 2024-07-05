part of 'json.dart';

base class JsonInteger extends JsonField<int> {
  JsonInteger(
    super.name, {
    super.helper,
    super.isRequired,
  }) : super(
          defaultValue: 0,
        );

  @override
  List<Object?> get props => [
        rawValue,
      ];
}
