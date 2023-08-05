part of '../truesight_flutter.dart';

abstract class DataModel {
  List<JsonType> get fields;

  DataModel get newInstance;

  fromJSON(Map<String, dynamic> json) {
    for (var field in fields) {
      if (field is JsonString || field is JsonBoolean || field is JsonNumber) {
        field.value = json[field.name];
        break;
      }

      if (field is JsonDate) {
        if (json.containsKey(field.name) && json[field.name] != null) {
          field.value = DateTime.parse(json[field.name]);
        } else {
          field.value = null;
        }
        break;
      }

      if (field is JsonObject) {
        //
        break;
      }
    }
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> result = {};

    return result;
  }
}
