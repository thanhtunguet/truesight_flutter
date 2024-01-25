import 'dart:convert';

import 'package:truesight_flutter/json_serializable.dart';

part 'abstract_id_filter.dart';
part 'date_filter.dart';
part 'double_filter.dart';
part 'filter_field.dart';
part 'guid_filter.dart';
part 'id_filter.dart';
part 'int_filter.dart';
part 'abstract_number_filter.dart';
part 'string_filter.dart';
part 'number_filter.dart';

abstract class DataFilter implements JsonSerializable {
  static const ORDER_ASC = "ASC";

  static const ORDER_DESC = "DESC";

  int? skip = 0;

  int? take = 10;

  String? orderBy;

  String? orderType;

  List<FilterField> get fields;

  @override
  toJSON() {
    final Map<String, dynamic> json = {};
    json["skip"] = skip;
    json["take"] = take;
    json["orderBy"] = orderBy;
    json["orderType"] = orderType;

    for (final field in fields) {
      json[field.name] = field.toJSON();
    }

    return json;
  }

  @override
  void fromJSON(dynamic json) {
    if (json is Map<String, dynamic>) {
      if (json.containsKey("skip") && json["skip"] is int?) {
        skip = json["skip"];
      }
      if (json.containsKey("take") && json["take"] is int?) {
        take = json["take"];
      }
      if (json.containsKey("orderBy") && json["orderBy"] is String?) {
        take = json["orderBy"];
      }
      if (json.containsKey("orderType") && json["orderType"] is String?) {
        take = json["orderType"];
      }

      for (final field in fields) {
        if (json.containsKey(field.name) && json[field.name] != null) {
          field.fromJSON(json[field.name]);
        }
      }
    }
  }

  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
