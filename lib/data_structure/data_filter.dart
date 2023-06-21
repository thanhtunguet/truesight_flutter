part of '../truesight_flutter.dart';

@reflector
class DataFilter {
  /// Skip value for pagination
  int skip = 0;

  /// Take value for pagination
  int take = 10;

  /// Order data by a certain field
  String? orderBy;

  /// Order type of current filter (ascending or descending)
  OrderType? orderType;

  TypeMirror get _abstractFilterReflection {
    return reflector.reflectType(AbstractFilter);
  }

  /// Convert current filter to json object
  dynamic toJSON() {
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

  /// Convert current filter to JSON string
  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
