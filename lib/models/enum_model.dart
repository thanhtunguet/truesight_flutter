part of 'models.dart';

class EnumModel extends IdentifiedModel {
  @override
  List<JsonField> get fields => [
        id,
        code,
        name,
        color,
      ];

  JsonString code = JsonString('code');

  JsonString name = JsonString('name');

  JsonString color = JsonString('color');
}
