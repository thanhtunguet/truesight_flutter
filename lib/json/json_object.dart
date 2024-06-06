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
  T get value {
    if (_value != null) {
      return _value!;
    }
    return DataModel.getType(genericType).constructor() as T;
  }

  @override
  void fromJSON(json) {
    if (json != null) {
      final T model = DataModel.getType(genericType).constructor() as T;
      model.fromJSON(json);
      _value = model;
    }
  }

  @override
  toJSON() {
    return _value?.toJSON();
  }
}
