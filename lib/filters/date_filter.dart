part of 'filters.dart';

@reflector
class DateFilter extends NumberFilter<DateTime> {
  DateFilter() : super();

  DateFilter.fromJSON(Map<String, dynamic> json) : super.fromJSON(json) {
    fromJSON(json);
  }

  @override
  Map<String, dynamic> toJSON() {
    return {
      "greaterEqual": greaterEqual?.toIso8601String(),
      "lessEqual": lessEqual?.toIso8601String(),
      "greater": greater?.toIso8601String(),
      "less": less?.toIso8601String(),
      "equal": equal?.toIso8601String(),
      "notEqual": notEqual?.toIso8601String(),
    };
  }

  @override
  void fromJSON(Map<String, dynamic> json) {
    if (json.containsKey("greaterEqual")) {
      greaterEqual = DateTime.parse(json["greaterEqual"]);
    }
    if (json.containsKey("lessEqual")) {
      lessEqual = DateTime.parse(json["lessEqual"]);
    }
    if (json.containsKey("greater")) {
      greater = DateTime.parse(json["greater"]);
    }
    if (json.containsKey("less")) {
      less = DateTime.parse(json["less"]);
    }
    if (json.containsKey("equal")) {
      equal = DateTime.parse(json["equal"]);
    }
    if (json.containsKey("notEqual")) {
      notEqual = DateTime.parse(json["notEqual"]);
    }
  }
}
