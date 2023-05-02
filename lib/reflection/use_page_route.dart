part of 'reflection.dart';

/// Define routing key for a widget that be used as a screen (page)
///
/// Each class should have an unique routing key
///
/// Each class should represent only one page and have only one instance
class UsePageRoute with EquatableMixin {
  final String route;

  const UsePageRoute(this.route);

  @override
  List<Object?> get props => [
        route,
      ];
}
