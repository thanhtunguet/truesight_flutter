import 'package:flutter_test/flutter_test.dart';
import 'package:truesight_flutter/json/json.dart';
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

  JsonList<AppUser> members = JsonList<AppUser>(
    "members",
    newInstance: AppUser.new,
  );

  JsonObject<AppUser> manager = JsonObject<AppUser>(
    "manager",
    newInstance: AppUser.new,
  );
}

void main() {
  test('json serialization', () {
    //
  });
}
