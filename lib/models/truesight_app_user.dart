part of 'models.dart';

class TruesightAppUser extends IdentifiedModel {
  @override
  List<JsonField> get fields => [
        id,
        globalUserId,
        code,
        username,
        displayName,
        email,
        password,
        avatar,
        address,
        phone,
      ];

  JsonInteger globalUserId = JsonInteger('globalUserId');

  JsonString code = JsonString('code');

  JsonString username = JsonString('username');

  JsonString displayName = JsonString('displayName');

  JsonString email = JsonString('email');

  JsonString password = JsonString('password');

  JsonString avatar = JsonString('avatar');

  JsonString address = JsonString('address');

  JsonString phone = JsonString('phone');
}
