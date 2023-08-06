part of 'json.dart';

class JsonObject<T extends DataModel> extends JsonType<T> {
  JsonObject(
    super.name, {
    super.isRequired,
    super.defaultValue,
  }) {
    genericType = T;
  }
}
