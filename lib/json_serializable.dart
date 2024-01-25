abstract interface class JsonSerializable {
  void fromJSON(dynamic json);

  dynamic toJSON();
}
