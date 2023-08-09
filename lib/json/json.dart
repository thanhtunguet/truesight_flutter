import 'dart:js_interop';

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

  bool isRequired;

  late T value;

  late T? defaultValue;

  String? helper;

  String? information;

  String? warning;

  String? error;

  JsonType(
    this.name, {
    this.isRequired = false,
    this.defaultValue,
    this.helper,
  });

  dynamic toJSON() {
    return value;
  }

  void fromJSON(dynamic value) {
    this.value = value ?? defaultValue;
  }
}
