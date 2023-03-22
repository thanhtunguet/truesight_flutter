mixin DataSerialization {
  dynamic toJSON();

  void fromJSON(dynamic json);
}
