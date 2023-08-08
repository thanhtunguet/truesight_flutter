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

  late T value;

  late T? defaultValue;

  String? error;

  String? warning;

  String? information;

  String? helper;

  bool isRequired;

  JsonType(
    this.name, {
    this.isRequired = false,
    this.defaultValue,
    this.helper,
  });

  void operator <<(dynamic newValue) {
    final deserializedValue = deserialize(newValue);
    if (deserializedValue != null) {
      value = deserializedValue;
    }
  }

  T? deserialize(dynamic value) {
    return value;
  }

  dynamic serialize() {
    return value;
  }

  dynamic toJSON() {
    return serialize();
  }

  void fromJSON(dynamic value) {
    this << value;
  }
}
