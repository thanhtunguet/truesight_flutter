part of 'data_structure.dart';

/// DataList is a class used to mark the generic type for a data field in the form of a list (for Mapping and Content tables).
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

  /// Convert current list to JSON string
  @override
  String toString() {
    return jsonEncode(toJSON());
  }

  /// Clone all field's values from otherList to current list
  operator <<(List<T> otherList) {
    _list.clear();
    for (var element in otherList) {
      _list.add(element);
    }
  }

  /// Assign all fields from this list instance to other list
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
