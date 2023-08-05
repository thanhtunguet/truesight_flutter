part of 'json.dart';

class JsonList<T extends DataModel> extends JsonType<List<T>> {
  DataModelNewInstance newInstance;

  JsonList(
    super.name, {
    required this.newInstance,
    super.isRequired,
    super.defaultValue,
  }) {
    genericType = T;
  }

  @override
  List<T>? deserialize(dynamic value) {
    if (value is List<JsonType>) {
      return value.map((e) => e.deserialize(value) as T).toList();
    }
    return [];
  }
}
