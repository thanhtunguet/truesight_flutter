part of '../truesight_flutter.dart';

/// TrueSight's backend order types
enum OrderType {
  /// Ascending order
  asc,

  /// Descending order
  desc,
}

extension OrderTypeExt on OrderType {
  String? asString() {
    if (this == OrderType.asc) {
      return "ASC";
    }
    if (this == OrderType.desc) {
      return "DESC";
    }
    return null;
  }
}

abstract class DataFilter extends DataModel {
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

  /// Convert current filter to json object
  @override
  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> result = super.toJSON();

    result['skip'] = skip;

    result['take'] = take;

    result['orderBy'] = orderBy;

    switch (orderType) {
      case OrderType.asc:
        result['orderType'] = 'ASC';
        break;

      case OrderType.desc:
        result['orderType'] = 'DESC';
        break;

      default:
        result['orderType'] = null;
        break;
    }

    return result;
  }

  @override
  void fromJSON(dynamic json) {
    if (json is Map<String, dynamic>) {
      super.fromJSON(json);
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
    }
    throw Exception(
      "Data passed to DataFilter.fromJSON must be a Map<String, dynamic>",
    );
  }

  /// Convert current filter to JSON string
  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
