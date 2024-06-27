part of 'models.dart';

abstract class IdentifiedModel extends DataModel with EquatableMixin {
  @override
  List<dynamic> get props => [
        id.rawValue,
      ];

  @override
  List<JsonField> get fields => [
        id,
      ];

  JsonInteger id = JsonInteger('id');
}
