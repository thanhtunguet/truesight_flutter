part of 'models.dart';

class TruesightAppUser extends IdentifiedModel {
  @override
  List<JsonField> get fields => [
        id,
        email,
        username,
        displayName,
        password,
        globalUserId,
        avatar,
      ];

  JsonString email = JsonString('email');

  JsonString username = JsonString('username');

  JsonString displayName = JsonString('displayName');

  JsonString password = JsonString('password');

  JsonInteger globalUserId = JsonInteger('globalUserId');

  JsonString avatar = JsonString('avatar');
}
