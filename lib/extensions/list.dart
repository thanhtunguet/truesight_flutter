part of 'extensions.dart';

extension CyclicIndexing<T> on List<T> {
  int nextIndexOf(int index) {
    return (index + 1) % length;
  }

  int prevIndexOf(int index) {
    return (index - 1) % length;
  }

  T next(int index) {
    return this[nextIndexOf(index)];
  }

  T prev(int index) {
    return this[prevIndexOf(index)];
  }
}

extension DataListCyclicIndexing<T extends DataModel> on DataList<T> {
  int nextIndexOf(int index) {
    return (index + 1) % length;
  }

  int prevIndexOf(int index) {
    return (index - 1) % length;
  }

  T next(int index) {
    return this[nextIndexOf(index)];
  }

  T prev(int index) {
    return this[prevIndexOf(index)];
  }
}
