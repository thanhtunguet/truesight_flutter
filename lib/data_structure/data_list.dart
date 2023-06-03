part of 'data_structure.dart';

/// DataList is a class used to mark the generic type for a data field
/// in the form of a list (for Mapping and Content tables).
@reflector
class DataList<T extends DataModel> with EquatableMixin {
  late final List<T> _list;

  /// Generic type of this data list
  late final Type genericType = T;

  /// Default constructor
  ///
  /// This constructor make difference: assign the generic type to a property
  /// for later use
  DataList() {
    _list = <T>[];
  }

  /// Indexing operator
  T operator [](int index) {
    return _list[index % length];
  }

  /// Index assignment operator
  void operator []=(int index, T value) {
    _list[index % length] = value;
  }

  /// Length of the list
  int get length {
    return _list.length;
  }

  /// Add a new element (value) to the list
  add(T value) {
    _list.add(value);
  }

  /// Remove a value from the list
  remove(T value) {
    return _list.removeWhere((element) => element == value);
  }

  /// Get raw list instance
  List<T> toList() {
    return _list;
  }

  /// Convert current list to JSON (Dart type: List)
  List<dynamic> toJSON() {
    return _list.map((element) => element.toJSON()).toList();
  }

  /// Named constructor for `.fromJSON` method
  DataList.fromJSON(List<dynamic> json) {
    _list = <T>[];
    fromJSON(json);
  }

  /// Deserialize data from JSON object
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

  /// Equatable props of this list
  @override
  List<Object?> get props => [
        _list,
        ..._list,
      ];
}
