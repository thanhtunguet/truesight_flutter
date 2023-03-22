import 'package:truesight_flutter/reflection/reflector.dart';

import 'abstract_filter.dart';

@reflector
class GuidFilter extends AbstractFilter {
  List<String>? inList;

  List<String>? notInList;

  String? equal;

  String? notEqual;

  GuidFilter() : super();

  GuidFilter.fromJSON(Map<String, dynamic> json) {
    fromJSON(json);
  }

  @override
  void fromJSON(Map<String, dynamic> json) {
    if (json.containsKey("in")) {
      inList = json["in"];
    }
    if (json.containsKey("notIn")) {
      notInList = json["notIn"];
    }
    if (json.containsKey("equal")) {
      equal = json["equal"];
    }
    if (json.containsKey("notEqual")) {
      notEqual = json["notEqual"];
    }
  }

  @override
  Map<String, dynamic> toJSON() {
    return {
      "in": inList,
      "notIn": notInList,
      "equal": equal,
      "notEqual": notEqual,
    };
  }
}
