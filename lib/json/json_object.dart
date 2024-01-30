part of 'json.dart';

base class JsonObject<T extends DataModel> extends JsonField<T?>
    implements JsonEntity {
  @override
  Type genericType = T;

  @override
  T? defaultValue;

  JsonObject(
    super.name, {
    super.helper,
    super.isRequired,
    super.defaultValue,
  });

  @override
  void fromJSON(json) {
    final T model = DataModel.getType(genericType).constructor() as T;
    model.fromJSON(json);
    _value = model;
  }

  @override
  toJSON() {
    return _value?.toJSON();
  }
}
