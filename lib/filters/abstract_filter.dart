part of '../truesight_flutter.dart';

/// Base class for filter classes
abstract interface class AbstractFilter {
  AbstractFilter();

  /// Deserialize data from JSON
  void fromJSON(Map<String, dynamic> json);

  /// Convert this filter to JSON
  Map<String, dynamic> toJSON();

  /// Convert this filter directly to JSON string
  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
