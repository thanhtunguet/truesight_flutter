import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
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

  JsonString username =
      JsonString('username', isRequired: false, helper: 'Username of the user');

  JsonString password =
      JsonString('password', isRequired: false, helper: 'Password of the user');

  JsonString email =
      JsonString('email', isRequired: false, helper: 'Email of the user');

  JsonBoolean isAdmin =
      JsonBoolean('isAdmin', isRequired: false, helper: 'Is the user an admin');

  JsonDate dateOfBirth = JsonDate('dateOfBirth',
      isRequired: false, helper: 'User\'s date of birth');

  JsonInteger age =
      JsonInteger('age', isRequired: false, helper: 'Age of the user');

  JsonDouble level =
      JsonDouble('level', isRequired: false, helper: 'Level of the user');

  JsonObject<AppUser> manager =
      JsonObject('manager', isRequired: false, helper: 'Manager of the user');

  JsonList<AppUser> members = JsonList<AppUser>('members',
      isRequired: false, helper: 'Members that this user manages');
}

class AppUserFilter extends DataFilter {
  @override
  List<FilterField> get fields => [
        username,
        age,
      ];

  StringFilter username = StringFilter("username");

  IntFilter age = IntFilter("age");

  DateFilter dateOfBirth = DateFilter("dateOfBirth");
}

void configureModels() {
  DataModel.setType(AppUser, AppUser.new);
}

final sampleMember = {
  'username': 'member',
  'password': 'memberPasswordxxx',
  'email': 'member@example.com',
  'dateOfBirth': '2024-01-01T00:00:00.123Z',
  'age': 21,
  'level': 1.1,
};

final sampleManager = {
  'username': 'manager',
  'password': 'managerPasswordxxx',
  'email': 'manager@example.com',
  'dateOfBirth': '2024-01-01T00:00:00.123Z',
  'age': 24,
  'level': 1.3,
  'members': [
    sampleMember,
  ],
};

final sampleFilter = {
  'username': {
    'equal': 'test_username',
  },
  'age': {
    'lessEqual': 12,
  },
};

void main() {
  configureModels();

  test('model serialization', () {
    final user = AppUser();
    user.fromJSON(sampleManager);

    expect(user.username.value, sampleManager['username']);
    expect(user.password.value, sampleManager['password']);
    expect(user.email.value, sampleManager['email']);
    expect(user.dateOfBirth.toJSON(), sampleManager['dateOfBirth']);
    expect(user.age.value, sampleManager['age']);
    expect(user.level.value, sampleManager['level']);

    expect(user.members.value[0].username.value, sampleMember['username']);
    expect(user.members.value[0].password.value, sampleMember['password']);
    expect(user.members.value[0].email.value, sampleMember['email']);
    expect(user.members.value[0].dateOfBirth.toJSON(),
        sampleMember['dateOfBirth']);
    expect(user.members.value[0].age.value, sampleMember['age']);
    expect(user.members.value[0].level.value, sampleMember['level']);

    if (kDebugMode) {
      print(user.toString());
    }
  });

  test('filter serialization', () {
    AppUserFilter filter = AppUserFilter();
    filter.fromJSON(sampleFilter);

    expect(filter.username.equal, sampleFilter["username"]!["equal"]);
    expect(filter.age.lessEqual, sampleFilter["age"]!["lessEqual"]);

    if (kDebugMode) {
      print(filter.toString());
    }
  });

  test('empty serialization', () {
    AppUser appUser = AppUser();
    if (kDebugMode) {
      print(appUser.toString());
    }
    expect(appUser.toString(), '{}');
  });

  test('number format', () {
    const num x = 16660066600000;
    print(x.asMoney());
    print(x.asMoney(hasDecimals: true));
  });
}
