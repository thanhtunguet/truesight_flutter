part of 'models.dart';

class Tenant extends IdentifiedModel {
  @override
  List<JsonField> get fields => [
        id,
        name,
        defaultPath,
        ownerId,
        isAlreadyGettingStarted,
        isOwner,
        tenantStatusId,
        tenantStatus,
        requestProperty,
      ];

  JsonString name = JsonString('name');

  JsonString defaultPath = JsonString('defaultPath');

  JsonInteger ownerId = JsonInteger('ownerId');

  JsonBoolean isAlreadyGettingStarted = JsonBoolean('isAlreadyGettingStarted');

  JsonBoolean isOwner = JsonBoolean('isOwner');

  JsonInteger tenantStatusId = JsonInteger('tenantStatusId');

  JsonObject<EnumModel> tenantStatus = JsonObject<EnumModel>('tenantStatus');

  JsonString requestProperty = JsonString('requestProperty');
}
