import 'package:flutter_test/flutter_test.dart';
import 'package:truesight_flutter/truesight_flutter.dart';

class AppUser extends DataModel {
  @override
  List<JsonType> get fields => [
        id,
        email,
        birthday,
        members,
        manager,
      ];

  @override
  AppUser get newInstance => AppUser();

  JsonNumber id = JsonNumber("id");

  JsonString email = JsonString("email");

  JsonDate birthday = JsonDate("birthday");

  JsonList<AppUser> members = JsonList<AppUser>("members");

  JsonObject<AppUser> manager = JsonObject<AppUser>("manager");
}

configureModels() {
  modelMappings[AppUser] = TypeMapping(
      newInstance: AppUser.new,
      newList: (int length) => List<AppUser>.generate(
            length,
            (index) => AppUser(),
          ));
}

void main() {
  configureModels();

  test('json serialization', () {
    var json = {
      'id': 1,
      'email': 'email@example.com',
      'birthday': '2023-08-01T19:00:00Z',
      'members': [],
      'manager': {
        'id': 2,
        'email': 'manager@example.com',
        'birthday': '2023-08-01T19:00:00Z',
        'members': [],
        'manager': null,
      },
    };
    var user = AppUser();
    user.fromJSON(json);
    expect(user.email.value, "email@example.com");
  });
}

final types = {
  'AppUser': {
    'newInstance': () => AppUser(),
    'newList': (int length) {
      var result = <AppUser>[];
      for (var i = 0; i < length; i++) {
        result[i] = AppUser();
      }
      return result;
    }
  },
};
