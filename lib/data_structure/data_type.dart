part of '../truesight_flutter.dart';

interface class DataType<T> {
  final String name;

  final Type type = T;

  Type? genericType;

  late T? value;

  late T? defaultValue;

  bool isRequired;

  DataType(
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

class JsonString extends DataType<String> {
  JsonString(
    super.name, {
    super.isRequired,
    super.defaultValue,
  });
}

class JsonNumber extends DataType<num> {
  JsonNumber(
    super.name, {
    super.isRequired,
    super.defaultValue,
  });
}

class JsonBoolean extends DataType<bool> {
  JsonBoolean(
    super.name, {
    super.isRequired,
    super.defaultValue,
  });
}

class JsonDate extends DataType<DateTime> {
  JsonDate(
    super.name, {
    super.isRequired,
    super.defaultValue,
  });

  @override
  DateTime? deserialize(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    }
    return null;
  }
}

class JsonList<T extends DataType> extends DataType<List<T>> {
  JsonList(
    super.name, {
    super.isRequired,
    super.defaultValue,
  }) {
    genericType = T;
  }

  @override
  List<T>? deserialize(dynamic value) {
    if (value is List<DataType>) {
      return value.map((e) => e.deserialize(value) as T).toList();
    }
    return [];
  }
}
