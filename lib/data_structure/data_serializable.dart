part of '../truesight_flutter.dart';

abstract class DataSerializable {
  void fromJSON(dynamic json);

  dynamic toJSON();
}
