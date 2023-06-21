part of '../truesight_flutter.dart';

/// Define serialization methods for all data classes
mixin DataSerialization {
  /// Convert current class instance to JSON (Dart type: Map)
  dynamic toJSON();

  /// Map data from a JSON (Dart type: Map) to current class instances field by field
  void fromJSON(dynamic json);
}
