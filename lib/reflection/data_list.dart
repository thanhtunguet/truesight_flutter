import 'dart:convert';

import 'package:truesight_flutter/truesight_flutter.dart';

@reflector
class DataList<T extends DataModel> {
  final List<T> list = [];

  late final Type genericType;

  DataList() {
    genericType = T;
  }

  T? operator [](int index) {
    if (index < 0) {
      return null;
    }
    if (length <= index) {
      return null;
    }
    return list[index];
  }

  void operator []=(int index, T value) {
    list[index] = value;
  }

  int get length {
    return list.length;
  }

  add(T value) {
    list.add(value);
  }

  remove(T value) {
    return list.removeWhere((element) => element == value);
  }

  List<T> toList() {
    return list;
  }

  List<dynamic> toJSON() {
    return list.map((e) => e.toJSON()).toList();
  }

  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
