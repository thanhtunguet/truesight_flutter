import 'package:truesight_flutter/reflection/reflector.dart';

import 'abstract_filter.dart';

@reflector
class StringFilter extends AbstractFilter {
  String? equal;

  String? notEqual;

  String? startWith;

  String? notStartWith;

  String? endWith;

  String? notEndWith;

  String? contain;

  String? notContain;

  StringFilter() : super();

  StringFilter.fromJSON(Map<String, dynamic> json) {
    fromJSON(json);
  }

  @override
  void fromJSON(Map<String, dynamic> json) {
    if (json.containsKey("equal")) {
      equal = json["equal"];
    }
    if (json.containsKey("notEqual")) {
      notEqual = json["notEqual"];
    }
    if (json.containsKey("startWith")) {
      startWith = json["startWith"];
    }
    if (json.containsKey("notStartWith")) {
      notStartWith = json["notStartWith"];
    }
    if (json.containsKey("endWith")) {
      endWith = json["endWith"];
    }
    if (json.containsKey("contain")) {
      contain = json["contain"];
    }
    if (json.containsKey("notContain")) {
      notEqual = json["notContain"];
    }
  }

  @override
  Map<String, dynamic> toJSON() {
    return {
      "equal": equal,
      "notEqual": notEqual,
      "startWith": startWith,
      "notStartWith": notStartWith,
      "contain": contain,
      "notContain": notContain,
      "endWith": endWith,
      "notEndWith": notEndWith,
    };
  }
}
