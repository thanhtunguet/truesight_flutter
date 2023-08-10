part of '../truesight_flutter.dart';

class JsonObject<T extends DataModel> extends JsonType<T> {
  JsonObject(
    super.name, {
    super.isRequired,
    super.defaultValue,
  }) {
    genericType = T;
  }

  @override
  void fromJSON(dynamic value) {
    final _ModelType typeMapping = DataModel._getType(genericType!);
    final T instance = typeMapping.constructor() as T;
    if (value != null) {
      instance.fromJSON(value);
    }
    this.value = instance;
  }

  @override
  toJSON() {
    return value?.toJSON();
  }
}
