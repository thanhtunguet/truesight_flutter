part of 'json.dart';

base class JsonList<T extends DataModel> extends JsonField<List<T>>
    implements JsonEntity {
  @override
  Type genericType = T;

  @override
  List<T> defaultValue = <T>[];

  JsonList(
    super.name, {
    super.defaultValue = const [],
    super.helper,
    super.isRequired,
  }) {
    _value = [];
  }

  @override
  void fromJSON(json) {
    if (json is List) {
      _value = json.map((element) {
        final T entity = DataModel.getType(genericType).constructor() as T;
        return entity..fromJSON(element);
      }).toList();
    }
  }

  @override
  toJSON() {
    return _value?.map((element) {
      return element.toJSON();
    }).toList();
  }

  // Override the [] operator
  T operator [](int index) {
    return value[index];
  }

  // Override the []= operator for setting values
  void operator []=(int index, T value) {
    this.value[index] = value;
  }

  List<T> map(T Function(T e) toElement) {
    return value.map(toElement).toList();
  }

  forEach(Function(T e) toElement) {
    value.forEach(toElement);
  }
}
