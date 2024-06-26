import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:truesight_flutter/json/json.dart';
import 'package:truesight_flutter/json_serializable.dart';

part 'enum_model.dart';
part 'identified_model.dart';

typedef InstanceConstructor<T extends DataModel> = T Function();

class ModelType<T extends DataModel> {
  final InstanceConstructor<T> constructor;

  const ModelType({
    required this.constructor,
  });
}

abstract class DataModel implements JsonSerializable {
  static const String informationKey = "informations";

  static const String warningKey = "warnings";

  static const String errorKey = "errors";

  final _logger = Logger('ModelLogger');

  List<JsonField> get fields;

  static final Map<Type, ModelType> _modelTypes = {};

  static setType(Type className, InstanceConstructor constructor) {
    _modelTypes[className] = ModelType(constructor: constructor);
  }

  static ModelType getType(Type type) {
    if (!_modelTypes.containsKey(type)) {
      throw Exception(
        "Can not find type $type, may be you have not registered the model class with `DataModel.setType`",
      );
    }
    return _modelTypes[type]!;
  }

  static create<T extends DataModel>(Type type) {
    final ModelType modelType = _modelTypes[type]!;
    final T instance = modelType.constructor() as T;
    return instance;
  }

  @override
  void fromJSON(json) {
    if (json is Map<String, dynamic>) {
      final Map<String, dynamic> errors =
          json.containsKey(errorKey) && json[errorKey] is Map
              ? json[errorKey]
              : {};

      final Map<String, dynamic> warnings =
          json.containsKey(warningKey) && json[warningKey] is Map
              ? json[warningKey]
              : {};

      final Map<String, dynamic> informations =
          json.containsKey(informationKey) && json[informationKey] is Map
              ? json[informationKey]
              : {};

      for (final field in fields) {
        try {
          if (errors.containsKey(field.name)) {
            field.error = errors[field.name];
          }

          if (warnings.containsKey(field.name)) {
            field.warning = warnings[field.name];
          }

          if (informations.containsKey(field.name)) {
            field.information = informations[field.name];
          }

          if (field is JsonString ||
              field is JsonBoolean ||
              field is JsonNumber ||
              field is JsonInteger ||
              field is JsonDouble) {
            field.value = json[field.name];
            continue;
          }

          if (field is JsonDate) {
            if (json.containsKey(field.name) && json[field.name] != null) {
              field.value = DateTime.parse(json[field.name]);
            }
            continue;
          }

          if (field is JsonObject) {
            field.value = create<DataModel>(field.genericType);
            if (json.containsKey(field.name) && json[field.name] != null) {
              field.fromJSON(json[field.name]);
            }
            continue;
          }

          if (field is JsonList) {
            if (json.containsKey(field.name) && json[field.name] is List) {
              field.fromJSON(json[field.name]);
            }
            continue;
          }
        } catch (error) {
          _logger.severe(
              "Error while parsing field ${field.name}: ${error.toString()}");
        }
      }
      return;
    }
    throw Exception(
      "Data passed to DataModel.fromJSON must be a Map<String, dynamic>",
    );
  }

  @override
  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> result = {};

    for (final field in fields) {
      if (field.isNull) {
        continue;
      }
      if (field is JsonString ||
          field is JsonNumber ||
          field is JsonBoolean ||
          field is JsonInteger ||
          field is JsonDouble) {
        result[field.name] = field.value;
        continue;
      }
      if (field is JsonDate) {
        result[field.name] = field.value.toIso8601String();
        continue;
      }
      if (field is JsonObject) {
        result[field.name] = field.rawValue?.toJSON();
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

  @override
  String toString() {
    return jsonEncode(toJSON());
  }

  operator [](String fieldName) {
    return fields.firstWhere((field) => field.name == fieldName).value;
  }

  void operator []=(String fieldName, dynamic value) {
    fields.firstWhere((field) => field.name == fieldName).value = value;
  }
}
