part of 'json.dart';

abstract base class JsonField<T> implements JsonSerializable {
  /// Type of the JsonField
  late Type type;

  /// Field name
  String name;

  /// internal value
  T? _value;

  /// Default value for the field
  abstract T defaultValue;

  /// If this field is required or not
  bool isRequired;

  /// Helper text when the field is displayed in a form
  String? helper;

  /// Field message: information
  String? information;

  /// Field message: warning
  String? warning;

  /// Field message: error
  String? error;

  /// value getter
  T get value {
    if (_value != null) {
      return _value!;
    }
    return defaultValue;
  }

  /// value setter
  set value(T value) {
    _value = value;
  }

  JsonField(
    this.name, {
    this.helper,
    this.isRequired = false,
    T? defaultValue,
  }) {
    type = T;
    if (defaultValue != null) {
      this.defaultValue = defaultValue;
    }
  }

  @override
  toJSON() {
    return _value;
  }

  @override
  void fromJSON(json) {
    _value = json;
  }

  /// Convert this field to String
  @override
  String toString() {
    return jsonEncode(toJSON());
  }

  String? validate() {
    if (error != null) {
      return error;
    }
    if (isRequired) {
      if (_value == null) {
        return "Field $name is required";
      }
    }
    return null;
  }

  bool get hasError => error != null && error!.isNotEmpty;
}
