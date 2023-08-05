part of 'json.dart';

class JsonObject<T extends DataModel> extends JsonType<T> {
  DataModelNewInstance newInstance;

  JsonObject(
    super.name, {
    required this.newInstance,
    super.isRequired,
    super.defaultValue,
  }) {
    genericType = T;
  }
}
