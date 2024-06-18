abstract interface class JsonSerializable with JsonSerializableMixin {
  ///
}

abstract interface class JsonSerializableField extends JsonSerializable {
  abstract String name;
}

mixin JsonSerializableMixin {
  void fromJSON(dynamic json);

  dynamic toJSON();
}
