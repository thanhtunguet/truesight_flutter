part of '../truesight_flutter.dart';

abstract class DataModel {
  List<JsonType> get fields;

  static addModel(Type className, NewInstanceFunction newInstance) {
    modelMappings[className] = TypeMapping(newInstance: newInstance);
  }

  void fromJSON(Map<String, dynamic> json) {
    final Map<String, String> errors =
        json.containsKey("errors") ? json["errors"] : {};

    final Map<String, String> warnings =
        json.containsKey("warnings") ? json["warnings"] : {};

    final Map<String, String> informations =
        json.containsKey("informations") ? json["informations"] : {};

    for (final field in fields) {
      if (errors.containsKey(field.name)) {
        field.error = errors[field.name];
      }

      if (warnings.containsKey(field.name)) {
        field.warning = warnings[field.name];
      }

      if (informations.containsKey(field.name)) {
        field.information = informations[field.name];
      }

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
          final length = json[field.name].length;

          for (var i = 0; i < length; i++) {
            final instance = type.newInstance();
            instance.fromJSON(json[field.name][i]);
            field.value[i] = instance;
          }
        } else {
          field.value = [];
        }
        continue;
      }
    }
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> result = {};
    for (final field in fields) {
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
