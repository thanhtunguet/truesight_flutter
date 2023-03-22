import 'dart:convert';

import 'package:reflectable/mirrors.dart';
import 'package:truesight_flutter/data_structure/data_serialization.dart';
import 'package:truesight_flutter/filters/abstract_filter.dart';
import 'package:truesight_flutter/reflection/reflector.dart';

enum OrderType {
  asc,
  desc,
}

@reflector
class DataFilter with DataSerialization {
  int skip = 0;

  int take = 10;

  String? orderBy;

  OrderType? orderType;

  TypeMirror get _abstractFilterReflection {
    return reflector.reflectType(AbstractFilter);
  }

  @override
  void fromJSON(json) {
    var instanceMirror = reflector.reflect(this);
    instanceMirror.type.declarations.forEach((memberName, memberMirror) {
      if (memberMirror is VariableMirror) {
        switch (memberName) {
          case 'skip':
            skip = json['skip'];
            break;

          case 'take':
            take = json['take'];
            break;

          case 'orderBy':
            orderBy = json['orderBy'];
            break;

          case 'orderType':
            String? rawOrderType = json['orderType'];

            switch (rawOrderType?.toLowerCase()) {
              case 'asc':
                orderType = OrderType.asc;
                break;

              case 'desc':
                orderType = OrderType.desc;
                break;

              default:
                orderType = null;
                break;
            }
            break;

          default:
            var reflectedType = memberMirror.reflectedType;
            // Is abstract filter
            if (reflector
                .reflectType(reflectedType)
                .isSubtypeOf(_abstractFilterReflection)) {
              var rawValue = json[memberName];
              if (rawValue == null) {
                return;
              }
              AbstractFilter? fieldValue =
                  instanceMirror.invokeGetter(memberName) as AbstractFilter?;
              fieldValue ??= TrueSightReflector.newInstance(reflectedType);
              fieldValue?.fromJSON(rawValue);
              return;
            }
            break;
        }
        return;
      }
    });
  }

  @override
  toJSON() {
    var instanceMirror = reflector.reflect(this);
    var result = {};
    result['skip'] = skip;
    result['take'] = take;
    result['orderBy'] = orderBy;
    switch (orderType) {
      case OrderType.asc:
        result['orderType'] = 'ASC';
        break;

      case OrderType.desc:
        result['orderType'] = 'DESC';
        break;

      default:
        result['orderType'] = null;
        break;
    }
    instanceMirror.type.declarations.forEach((memberName, memberMirror) {
      if (memberMirror is VariableMirror) {
        var reflectedType = memberMirror.reflectedType;
        if (reflector
            .reflectType(reflectedType)
            .isSubtypeOf(_abstractFilterReflection)) {
          AbstractFilter? filter =
              instanceMirror.invokeGetter(memberName) as AbstractFilter?;
          result[memberName] = filter?.toJSON();
        }
      }
    });
    return result;
  }

  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
