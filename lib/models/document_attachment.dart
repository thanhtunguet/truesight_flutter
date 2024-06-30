part of 'models.dart';

abstract class DocumentAttachment extends IdentifiedModel {
  @override
  List<JsonField> get fields => [
        id,
        name,
        path,
        fileId,
        file,
        isFile,
        link,
      ];

  JsonString name = JsonString('name');

  JsonString path = JsonString('path');

  JsonInteger fileId = JsonInteger('fileId');

  JsonObject<File> file = JsonObject<File>('file');

  JsonBoolean isFile = JsonBoolean('isFile');

  JsonString link = JsonString('link');
}
