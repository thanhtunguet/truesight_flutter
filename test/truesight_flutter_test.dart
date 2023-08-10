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

  JsonNumber id = JsonNumber("id");

  JsonString email = JsonString("email");

  JsonDate birthday = JsonDate("birthday");

  JsonList<AppUser> members = JsonList<AppUser>("members");

  JsonObject<AppUser> manager = JsonObject<AppUser>("manager");
}

configureModels() {
  DataModel.setType(AppUser, AppUser.new);
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
        'manager': {
          'id': 3,
          'email': 'high_level_manager@example.com',
          'birthday': '2023-08-01T19:00:00Z',
          'members': [],
          'manager': null,
        },
      },
    };

    final AppUser user = AppUser();
    user.fromJSON(json);

    final AppUser manager = user.manager.value!;

    final AppUser highLevelManager = manager.manager.value!;

    expect(user.email.value, "email@example.com");

    expect(manager.email.value, 'manager@example.com');

    expect(highLevelManager.email.value, "high_level_manager@example.com");
  });
}
