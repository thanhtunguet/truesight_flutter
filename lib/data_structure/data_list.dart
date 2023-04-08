import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:truesight_flutter/truesight_flutter.dart';

@reflector
class DataList<T extends DataModel> with EquatableMixin {
  late final List<T> _list;

  late final Type genericType = T;

  DataList() {
    _list = <T>[];
  }

  T operator [](int index) {
    return _list[index % length];
  }

  void operator []=(int index, T value) {
    _list[index % length] = value;
  }

  int get length {
    return _list.length;
  }

  add(T value) {
    _list.add(value);
  }

  remove(T value) {
    return _list.removeWhere((element) => element == value);
  }

  List<T> toList() {
    return _list;
  }

  List<dynamic> toJSON() {
    return _list.map((element) => element.toJSON()).toList();
  }

  DataList.fromJSON(List<dynamic> json) {
    _list = <T>[];
    fromJSON(json);
  }

  void fromJSON(List<dynamic> json) {
    for (var value in json) {
      T element = TrueSightReflector.newInstance(genericType);
      element.fromJSON(value);
      _list.add(element);
    }
  }

  @override
  String toString() {
    return jsonEncode(toJSON());
  }

  operator <<(List<T> otherList) {
    _list.clear();
    for (var element in otherList) {
      _list.add(element);
    }
  }

  operator >>(List<T> otherList) {
    otherList.clear();
    for (var element in _list) {
      otherList.add(element);
    }
  }

  @override
  List<Object?> get props => [
        _list,
        ..._list,
      ];
}
