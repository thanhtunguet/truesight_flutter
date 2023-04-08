import 'dart:convert';
import 'dart:core';

import 'package:reflectable/mirrors.dart';
import 'package:truesight_flutter/data_structure/data_list.dart';
import 'package:truesight_flutter/data_structure/data_serialization.dart';
import 'package:truesight_flutter/reflection/reflector.dart';

@reflector
class DataModel with DataSerialization {
  @override
  void fromJSON(json) {
    if (json is String) {
      fromJSON(jsonDecode(json));
      return;
    }
    var instanceMirror = reflector.reflect(this);
    instanceMirror.type.declarations.forEach((memberName, memberMirror) {
      if (memberMirror is VariableMirror &&
          (json as Map).containsKey(memberName)) {
        var reflectedType = memberMirror.reflectedType;

        /// If this field is primitive types: String, bool, num, int, double
        if (reflectedType == bool ||
            reflectedType == String ||
            reflectedType == int ||
            reflectedType == double) {
          var rawValue = json[memberName];
          instanceMirror.invokeSetter(memberName, rawValue);
          return;
        }

        /// If this field is datetime
        if (reflectedType == DateTime) {
          var rawValue = json[memberName];
          if (rawValue == null) {
            instanceMirror.invokeSetter(memberName, null);
          } else {
            instanceMirror.invokeSetter(memberName, DateTime.parse(rawValue));
          }
          return;
        }

        var initValue = instanceMirror.invokeGetter(memberName);

        if (initValue != null && initValue is DataList) {
          var memberValue = instanceMirror.invokeGetter(memberName) as DataList;
          Type genericType = memberValue.genericType;

          var rawList = json[memberName];
          if (rawList == null) {
            return;
          }
          for (var element in (rawList as List)) {
            var typedValue =
                TrueSightReflector.newInstance<DataModel>(genericType);
            typedValue.fromJSON(element);
            initValue.add(typedValue);
          }
          return;
        }

        /// If this field is a DataModel
        var classMirror = reflector.reflectType(reflectedType);
        var modelMirror = reflector.reflectType(DataModel);

        if (classMirror.isSubtypeOf(modelMirror)) {
          var rawValue = json[memberName];
          if (rawValue == null) {
            instanceMirror.invokeSetter(memberName, null);
            return;
          }
          var typedValue = TrueSightReflector.newInstance<DataModel>(
              memberMirror.reflectedType);
          typedValue.fromJSON(rawValue);
          instanceMirror.invokeSetter(memberName, typedValue);
          return;
        }
      }
    });
  }

  bool _isSerialized(
      {required List<DataModel> serialized, required DataModel element}) {
    if (serialized.contains(element)) {
      return true;
    }
    serialized.add(element);
    return false;
  }

  @override
  toJSON({List<DataModel>? serialized}) {
    serialized ??= [];
    InstanceMirror instanceMirror = reflector.reflect(this);
    Map<String, dynamic> result = {};
    instanceMirror.type.declarations.forEach((memberName, memberMirror) {
      if (memberMirror is VariableMirror) {
        var reflectedType = memberMirror.reflectedType;

        /// If this field is primitive types: String, bool, num, int, double
        if (reflectedType == bool ||
            reflectedType == String ||
            reflectedType == int ||
            reflectedType == double) {
          result[memberName] = instanceMirror.invokeGetter(memberName);
          return;
        }

        /// If this field is datetime
        if (reflectedType == DateTime) {
          var fieldValue = instanceMirror.invokeGetter(memberName);
          result[memberName] = (fieldValue as DateTime?)?.toIso8601String();
          return;
        }

        /// If this field is a list
        var originalValue = instanceMirror.invokeGetter(memberName);
        if (originalValue is DataList) {
          result[memberName] = [];
          var originalList = originalValue.toList();
          for (var element in originalList) {
            var isSerialized =
                _isSerialized(serialized: serialized!, element: element);
            if (isSerialized) {
              break;
            }
            (result[memberName] as List)
                .add(element.toJSON(serialized: serialized));
          }
          return;
        }

        /// If this field is a DataModel
        var classMirror = reflector.reflectType(reflectedType);
        var modelMirror = reflector.reflectType(DataModel);

        if (classMirror.isSubtypeOf(modelMirror)) {
          DataModel? originalValue =
              instanceMirror.invokeGetter(memberName) as DataModel?;
          if (originalValue == null) {
            result[memberName] = null;
            return;
          }
          var isSerialized =
              _isSerialized(serialized: serialized!, element: originalValue);
          if (isSerialized) {
            return;
          }
          result[memberName] = originalValue.toJSON(serialized: serialized);
        }
      }
    });
    return result;
  }

  DataModel operator <<(DataModel model) {
    InstanceMirror instanceMirror = reflector.reflect(this);
    InstanceMirror modelMirror = reflector.reflect(model);
    instanceMirror.type.declarations.forEach((memberName, memberMirror) {
      if (memberMirror is VariableMirror) {
        instanceMirror.invokeSetter(
            memberName, modelMirror.invokeGetter(memberName));
      }
    });
    return this;
  }

  DataModel operator >>(DataModel model) {
    InstanceMirror instanceMirror = reflector.reflect(this);
    InstanceMirror modelMirror = reflector.reflect(model);
    instanceMirror.type.declarations.forEach((memberName, memberMirror) {
      if (memberMirror is VariableMirror) {
        modelMirror.invokeSetter(
            memberName, instanceMirror.invokeGetter(memberName));
      }
    });
    return this;
  }

  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
