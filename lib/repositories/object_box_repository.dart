part of 'repositories.dart';

/// Repository for Objectbox database
@reflector
class ObjectBoxRepository extends Repository {
  late final Store _store;

  late final Admin? _admin;

  /// Get the box store of T entity class
  Box<T> box<T>() {
    return _store.box<T>();
  }

  /// Close current objectbox
  close() {
    _store.close();
    _admin?.close();
  }

  /// Create
  ObjectBoxRepository.create(this._store) {
    if (Admin.isAvailable()) {
      _admin = Admin(_store);
    }
  }
}
