import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truesight_flutter/truesight_flutter.dart';

import 'models/app_user.dart';
import 'models/app_user_filter.dart';

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
    if (kDebugMode) {
      print(x.asMoney());
      print(x.asMoney(hasDecimals: true));
    }
  });
}
