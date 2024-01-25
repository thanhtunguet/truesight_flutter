import 'package:truesight_flutter/truesight_flutter.dart';

class AppUser extends DataModel {
  @override
  List<JsonField> get fields => [
        username,
        password,
        email,
        isAdmin,
        dateOfBirth,
        age,
        level,
        manager,
        members,
      ];

  JsonString username = JsonString('username', isRequired: false, helper: 'Username of the user');

  JsonString password = JsonString('password', isRequired: false, helper: 'Password of the user');

  JsonString email = JsonString('email', isRequired: false, helper: 'Email of the user');

  JsonBoolean isAdmin = JsonBoolean('isAdmin', isRequired: false, helper: 'Is the user an admin');

  JsonDate dateOfBirth = JsonDate('dateOfBirth', isRequired: false, helper: 'User\'s date of birth');

  JsonInteger age = JsonInteger('age', isRequired: false, helper: 'Age of the user');

  JsonDouble level = JsonDouble('level', isRequired: false, helper: 'Level of the user');

  JsonObject<AppUser> manager = JsonObject('manager', isRequired: false, helper: 'Manager of the user');

  JsonList<AppUser> members = JsonList<AppUser>('members', isRequired: false, helper: 'Members that this user manages');
}
