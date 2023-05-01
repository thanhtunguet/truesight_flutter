
part of 'data_structure.dart';

/// TrueSight's backend order types
enum OrderType {
  /// Ascending order
  asc,
  /// Descending order
  desc,
}

@reflector
class DataFilter with DataSerialization {
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

  /// Deserialize json data to filter class
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

  /// Convert current filter to json object
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

  /// Convert current filter to JSON string
  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
