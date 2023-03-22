import 'package:objectbox/objectbox.dart';
import 'package:truesight_flutter/repositories/repository.dart';

abstract class ObjectBoxRepository extends Repository {
  Box<T> box<T>();
}
