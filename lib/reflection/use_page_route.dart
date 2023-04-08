import 'package:equatable/equatable.dart';

class UsePageRoute with EquatableMixin {
  final String route;

  const UsePageRoute(this.route);

  @override
  List<Object?> get props => [
        route,
      ];
}
