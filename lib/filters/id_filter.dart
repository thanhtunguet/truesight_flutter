part of 'filters.dart';

@reflector
class IdFilter extends AbstractFilter {
  List<int>? inList;

  List<int>? notInList;

  int? equal;

  int? notEqual;

  IdFilter() : super();

  IdFilter.fromJSON(Map<String, dynamic> json) {
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
