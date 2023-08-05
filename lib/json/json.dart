import 'package:truesight_flutter/truesight_flutter.dart';

part 'json_boolean.dart';

part 'json_date.dart';

part 'json_list.dart';

part 'json_number.dart';

part 'json_object.dart';

part 'json_string.dart';

typedef DataModelNewInstance = DataModel Function();

interface class JsonType<T> {
  final String name;

  final Type type = T;

  Type? genericType;

  late T? value;

  late T? defaultValue;

  bool isRequired;

  JsonType(
    this.name, {
    this.isRequired = false,
    this.defaultValue,
  });

  setRequired(bool isRequired) {
    this.isRequired = isRequired;
  }

  void operator <<(dynamic newValue) {
    if (newValue == null) {
      value = defaultValue;
      return;
    }
    value = deserialize(newValue);
  }

  T? deserialize(dynamic value) {
    return value;
  }

  dynamic serialize() {
    return value;
  }

  toJSON() {
    return serialize();
  }

  fromJSON(dynamic value) {
    this << value;
  }
}
