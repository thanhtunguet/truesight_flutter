part of '../truesight_flutter.dart';

/// Base class for filter classes
abstract interface class AbstractFilter implements DataSerializable {
  final String fieldName;

  AbstractFilter(this.fieldName);

  /// Deserialize data from JSON
  @override
  void fromJSON(dynamic json);

  /// Convert this filter to JSON
  @override
  Map<String, dynamic> toJSON();

  /// Convert this filter directly to JSON string
  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
