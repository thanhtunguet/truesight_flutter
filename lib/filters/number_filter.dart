part of '../truesight_flutter.dart';

/// This class defines filter operations for all Dart's number types
/// (including int, double or generic num)
///
/// This class also be used as interface of DateFilter
class NumberFilter<T> extends AbstractFilter {
  /// Query all records that has its field's value is greater than or equal to this property's value
  T? greaterEqual;

  /// Query all records that has its field's value is less than or equal to this property's value
  T? lessEqual;

  /// Query all records that has its field's value is greater than this property's value
  T? greater;

  /// Query all records that has its field's value is less than this property's value
  T? less;

  /// Query all records that has its field's value is equal to this property's value
  T? equal;

  /// Query all records that has its field's value is not equal to this property's value
  T? notEqual;

  /// Initialize new NumberFilter instance
  NumberFilter() : super();

  /// Initialize new NumberFilter instance from JSON
  NumberFilter.fromJSON(Map<String, dynamic> json) {
    fromJSON(json);
  }

  /// Deserialize a JSON object to map values to this NumberFilter
  @override
  void fromJSON(Map<String, dynamic> json) {
    if (json.containsKey("greaterEqual")) {
      greaterEqual = json["greaterEqual"];
    }
    if (json.containsKey("lessEqual")) {
      lessEqual = json["lessEqual"];
    }
    if (json.containsKey("greater")) {
      greater = json["greater"];
    }
    if (json.containsKey("less")) {
      less = json["less"];
    }
    if (json.containsKey("equal")) {
      equal = json["equal"];
    }
    if (json.containsKey("notEqual")) {
      notEqual = json["notEqual"];
    }
  }

  /// Convert this NumberFilter to JSON
  @override
  Map<String, dynamic> toJSON() {
    return {
      "greaterEqual": greaterEqual,
      "lessEqual": lessEqual,
      "greater": greater,
      "less": less,
      "equal": equal,
      "notEqual": notEqual,
    };
  }
}
