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
