part of '../truesight_flutter.dart';

typedef DataModelNewInstance = DataModel Function();

interface class JsonType<T> {
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

  dynamic toJSON() {
    return value;
  }

  void fromJSON(dynamic value) {
    this.value = value ?? defaultValue;
  }
}
