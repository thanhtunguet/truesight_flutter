part of 'models.dart';

abstract class IdentifiedModel extends DataModel with EquatableMixin {
  @override
  List<dynamic> get props => [
        id.rawValue,
      ];

  JsonInteger id = JsonInteger('id');
}
