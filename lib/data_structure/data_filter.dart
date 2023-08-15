part of '../truesight_flutter.dart';

/// TrueSight's backend order types
enum OrderType {
  /// Ascending order
  asc,

  /// Descending order
  desc,
}

abstract class DataFilter {
  List<AbstractFilter> get fields;

  /// Skip value for pagination
  int skip = 0;

  /// Take value for pagination
  int take = 10;

  /// Order data by a certain field
  String? orderBy;

  /// Order type of current filter (ascending or descending)
  OrderType? orderType;

  OrderType? fromString(String orderType) {
    if (orderType.toLowerCase() == "desc") {
      return OrderType.desc;
    }
    if (orderType.toLowerCase() == "asc") {
      return OrderType.asc;
    }
    return null;
  }

  String? orderTypeAsString() {
    if (orderType == OrderType.asc) {
      return "ASC";
    }
    if (orderType == OrderType.desc) {
      return "DESC";
    }
    return null;
  }

  /// Convert current filter to json object
  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> result = {
      'skip': skip,
      'take': take,
      'orderBy': orderBy,
      'orderType': orderTypeAsString(),
    };

    for (final field in fields) {
      result[field.fieldName] = field.toJSON();
    }

    return result;
  }

  void fromJSON(dynamic json) {
    if (json is! Map<String, dynamic>) {
      throw Exception(
        "Data passed to DataFilter.fromJSON must be a Map<String, dynamic>",
      );
    }

    if (json.containsKey("skip")) {
      skip = json["skip"];
    }
    if (json.containsKey("take")) {
      take = json["take"];
    }
    if (json.containsKey("orderBy")) {
      orderBy = json["orderBy"];
    }
    if (json.containsKey("orderType")) {
      orderType = fromString(json["orderType"]);
    }
    for (final field in fields) {
      if (json.containsKey(field.fieldName)) {
        field.fromJSON(json[field.fieldName]);
      }
    }
  }

  /// Convert current filter to JSON string
  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
