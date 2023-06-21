part of '../truesight_flutter.dart';

/// This class defines filter operations for ID (primary key, foreign key) fields
/// that is in string type (GUID, UUID, ...)
class GuidFilter extends AbstractFilter {
  /// Query all records that has id is in this list
  List<String>? inList;

  /// Query all records that has id is not in this list
  List<String>? notInList;

  /// Query all records that has a specific id
  String? equal;

  /// Query all records that have id is different from this value
  String? notEqual;

  /// Initialize new GuidFilter instance
  GuidFilter() : super();

  /// Initialize new GuidFilter instance from JSON
  GuidFilter.fromJSON(Map<String, dynamic> json) {
    fromJSON(json);
  }

  /// Deserialize fields from JSON
  @override
  void fromJSON(Map<String, dynamic> json) {
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

  /// Convert this GuidFilter to JSON
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
