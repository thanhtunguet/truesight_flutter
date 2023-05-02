part of 'extensions.dart';

/// Cyclic extension for List
///
/// Use methods of this class to avoid `index-out-of-range` exceptions
extension CyclicIndexing<T> on List<T> {
  /// Next index value of `index`
  /// If the `index` is the last position of the list, return the first
  int nextIndexOf(int index) {
    return (index + 1) % length;
  }

  /// Previous index value of `index`
  /// If the `index` is the first position of the list, return the last
  int prevIndexOf(int index) {
    return (index - 1) % length;
  }

  /// Next element of current index
  T next(int index) {
    return this[nextIndexOf(index)];
  }

  /// Previous element of current index
  T prev(int index) {
    return this[prevIndexOf(index)];
  }
}

/// The cyclic extension for DataList (similar to cyclic extension for List)
extension DataListCyclicIndexing<T extends DataModel> on DataList<T> {
  /// Next index value of `index`
  /// If the `index` is the last position of the list, return the first
  int nextIndexOf(int index) {
    return (index + 1) % length;
  }

  /// Previous index value of `index`
  /// If the `index` is the first position of the list, return the last
  int prevIndexOf(int index) {
    return (index - 1) % length;
  }

  /// Next element of current index
  T next(int index) {
    return this[nextIndexOf(index)];
  }

  /// Previous element of current index
  T prev(int index) {
    return this[prevIndexOf(index)];
  }
}
