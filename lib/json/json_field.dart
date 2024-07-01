part of 'json.dart';

abstract base class JsonField<T> implements JsonSerializableField {
  /// Type of the JsonField
  late Type type;

  /// Field name
  @override
  String name;

  /// internal value
  T? _value;

  /// Raw value (nullable)
  T? get rawValue => _value;

  /// Default value for the field
  T? defaultValue;

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
    assert(_value != null || defaultValue != null);
    if (_value != null) {
      return _value!;
    }
    return defaultValue!;
  }

  /// value setter
  set value(T value) {
    _value = value;
  }

  /// Check if the data is null
  bool get isNull {
    return _value == null;
  }

  /// Check if the data is not null
  bool get isNotNull {
    return _value != null;
  }

  JsonField(
    this.name, {
    this.helper,
    this.isRequired = false,
    this.defaultValue,
  });

  @override

  /// Converts the internal value of the field to a JSON representation.
  ///
  /// Returns:
  ///   A JSON representation of the internal value of the field.
  dynamic toJSON() {
    return _value;
  }

  @override
  // Parse the input JSON data and assign it to the internal value of the field.
  void fromJSON(json) {
    _value = json;
  }

  /// Convert this field to String
  @override
  String toString() {
    return jsonEncode(toJSON());
  }

  // Validates the field based on error conditions and requirements.
  String? validate() {
    if (hasError) {
      return error;
    }
    if (isRequired && isNull) {
      return "Field $name is required";
    }
    return null;
  }

  bool get hasError => error != null && error!.isNotEmpty;
}
