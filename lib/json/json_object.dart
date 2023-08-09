part of 'json.dart';

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
    final TypeMapping typeMapping = typeMappings[genericType]!;
    final T instance = typeMapping.newInstance() as T;
    if (value != null) {
      instance.fromJSON(value);
    }
    this.value = instance;
  }

  @override
  toJSON() {
    return value.toJSON();
  }
}
