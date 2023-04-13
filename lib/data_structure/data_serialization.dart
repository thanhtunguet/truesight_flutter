part of 'data_structure.dart';

mixin DataSerialization {
  dynamic toJSON();

  void fromJSON(dynamic json);
}
