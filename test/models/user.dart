import 'package:truesight_flutter/truesight_flutter.dart';

@reflector
class User extends DataModel {
  int id = 0;

  String username = "";

  String email = "";

  DateTime birthday = DateTime.now();

  int age = 0;

  User? manager;

  // For a field of type "List", we will use the DataList class
  // This custom class allow the library to detect data type of the field
  // To initialize and assign value from JSON
  DataList<User> members = DataList<User>();
}
