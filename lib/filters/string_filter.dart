part of '../truesight_flutter.dart';

/// This class defines filter operations for String type
class StringFilter extends AbstractFilter {
  /// Query all records that has its field's value equals to this property's value
  String? equal;

  /// Query all records that has its field's value different from this property's value
  String? notEqual;

  /// Query all records that has its field's value starts with this property's value
  String? startWith;

  /// Query all records that has its field's value does not start with this property's value
  String? notStartWith;

  /// Query all records that has its field's value ends with this property's value
  String? endWith;

  /// Query all records that has its field's value does not end with this property's value
  String? notEndWith;

  /// Query all records that has its field's value contains this property's value
  String? contain;

  /// Query all records that has its field's value does not contain this property's value
  String? notContain;

  /// Initialize new StringFilter instance
  StringFilter() : super();

  /// Initialize new StringFilter instance from a JSON value
  StringFilter.fromJSON(Map<String, dynamic> json) {
    fromJSON(json);
  }

  /// Convert this filter from JSON
  @override
  void fromJSON(dynamic json) {
    if (json is! Map<String, dynamic>) {
      return;
    }

    if (json.containsKey("equal")) {
      equal = json["equal"];
    }
    if (json.containsKey("notEqual")) {
      notEqual = json["notEqual"];
    }
    if (json.containsKey("startWith")) {
      startWith = json["startWith"];
    }
    if (json.containsKey("notStartWith")) {
      notStartWith = json["notStartWith"];
    }
    if (json.containsKey("endWith")) {
      endWith = json["endWith"];
    }
    if (json.containsKey("contain")) {
      contain = json["contain"];
    }
    if (json.containsKey("notContain")) {
      notEqual = json["notContain"];
    }
  }

  /// Convert this filter to JSON
  @override
  Map<String, dynamic> toJSON() {
    return {
      "equal": equal,
      "notEqual": notEqual,
      "startWith": startWith,
      "notStartWith": notStartWith,
      "contain": contain,
      "notContain": notContain,
      "endWith": endWith,
      "notEndWith": notEndWith,
    };
  }
}
