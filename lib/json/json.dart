part of '../truesight_flutter.dart';

typedef DataModelNewInstance = DataModel Function();

interface class JsonType<T> implements DataSerializable {
  final String name;

  final Type type = T;

  Type? genericType;

  bool isRequired;

  T? value;

  T? defaultValue;

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

  @override
  dynamic toJSON() {
    return value;
  }

  @override
  void fromJSON(dynamic value) {
    this.value = value ?? defaultValue;
  }
}
