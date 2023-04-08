import 'package:objectbox/objectbox.dart';
import 'package:truesight_flutter/reflection/reflection.dart';
import 'package:truesight_flutter/repositories/repository.dart';

@reflector
class ObjectBoxRepository extends Repository {
  late final Store _store;

  late final Admin? _admin;

  Box<T> box<T>() {
    return _store.box<T>();
  }

  close() {
    _admin?.close();
  }

  ObjectBoxRepository.create(this._store) {
    if (Admin.isAvailable()) {
      _admin = Admin(_store);
    }
  }
}
