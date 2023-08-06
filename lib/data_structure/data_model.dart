part of '../truesight_flutter.dart';

abstract class DataModel {
  List<JsonType> get fields;

  DataModel get newInstance;

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

      if (field is JsonObject) {
        field.value = field.newInstance();
        field.value!.fromJSON(json[field.name]);
        continue;
      }

      if (field is JsonList) {
        field.value = [];
        for (var i = 0; i < json[field.name].length; i++) {
          field.value!.add(field.newInstance());
          field.value![i].fromJSON(json[field.name][i]);
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
        result[field.name] = field.value?.toJSON();
        continue;
      }
      if (field is JsonList) {
        result[field.name] = field.value?.map((e) => e.toJSON()).toList();
        continue;
      }
    }
    return result;
  }
}
