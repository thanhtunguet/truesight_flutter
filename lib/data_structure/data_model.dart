part of '../truesight_flutter.dart';

abstract class DataModel {
  List<JsonType> get fields;

  fromJSON(Map<String, dynamic> json) {
    for (var field in fields) {
      if (field is JsonString || field is JsonBoolean || field is JsonNumber) {
        field.value = json[field.name];
        continue;
      }

      if (field is JsonDate) {
        if (json.containsKey(field.name) && json[field.name] != null) {
          field.value = DateTime.parse(json[field.name]);
        } else {
          field.value = null;
        }
        continue;
      }

      final TypeMapping type = modelMappings[field.genericType]!;

      if (field is JsonObject) {
        field.value = type.newInstance();
        if (json.containsKey(field.name) && json[field.name] != null) {
          field.deserialize(json[field.name]);
        }
        continue;
      }

      if (field is JsonList) {
        if (json.containsKey(field.name) && json[field.name] is List) {
          final length = (json[field.name] as List).length;
          field.value = type.newList(length);
          for (var i = 0; i < length; i++) {
            field.value[i].fromJSON(json[field.name][i]);
          }
        } else {
          field.value = type.newList(0);
        }
        continue;
      }
    }
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> result = {};
    for (var field in fields) {
      if (field is JsonString || field is JsonNumber || field is JsonBoolean) {
        result[field.name] = field.value;
        continue;
      }
      if (field is JsonDate) {
        result[field.name] = field.value?.toIso8601String();
        continue;
      }
      if (field is JsonObject) {
        result[field.name] = field.value.toJSON();
        continue;
      }
      if (field is JsonList) {
        result[field.name] =
            field.value.map((element) => element.toJSON()).toList();
        continue;
      }
    }
    return result;
  }
}
