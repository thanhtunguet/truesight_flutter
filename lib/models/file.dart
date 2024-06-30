part of 'models.dart';

class File extends IdentifiedModel {
  @override
  List<JsonField> get fields => [
        ...super.fields,
        id,
        globalUserId,
        name,
        mimeType,
        size,
        url,
        createdAt,
      ];

  JsonInteger globalUserId = JsonInteger("globalUserId");

  JsonString name = JsonString("name");

  JsonString mimeType = JsonString("mimeType");

  JsonInteger size = JsonInteger("size");

  JsonString url = JsonString("url");

  JsonDate createdAt = JsonDate("createdAt");
}
