part of '../truesight_flutter.dart';

/// This class defines filter operations for ID (primary key, foreign key) fields
/// that is in int type
class IdFilter extends AbstractFilter {
  /// Query all records that has id is in this list
  List<int>? inList;

  /// Query all records that has id is not in this list
  List<int>? notInList;

  /// Query all records that has a specific id
  int? equal;

  /// Query all records that have id is different from this value
  int? notEqual;

  /// Initialize new IdFilter instance
  IdFilter(super.fieldName);

  /// Initialize new IdFilter instance from JSON
  IdFilter.fromJSON(super.fieldName, Map<String, dynamic> json) {
    fromJSON(json);
  }

  /// Deserialize data from JSON to assign to this instance's fields
  @override
  void fromJSON(dynamic json) {
    if (json is! Map<String, dynamic>) {
      return;
    }

    if (json.containsKey("in")) {
      inList = json["in"];
    }
    if (json.containsKey("notIn")) {
      notInList = json["notIn"];
    }
    if (json.containsKey("equal")) {
      equal = json["equal"];
    }
    if (json.containsKey("notEqual")) {
      notEqual = json["notEqual"];
    }
  }

  /// Convert this IdFilter to JSON
  @override
  Map<String, dynamic> toJSON() {
    return {
      "in": inList,
      "notIn": notInList,
      "equal": equal,
      "notEqual": notEqual,
    };
  }
}
