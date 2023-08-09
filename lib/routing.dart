part of 'truesight_flutter.dart';

class UsePageRoute {
  final String path;

  const UsePageRoute(this.path);
}

/// Get routing key of Widget class
String getRoutingKey(Type page) {
  TypeMirror mirror = reflector.reflectType(page);
  var routingKey = "";
  for (var element in mirror.metadata) {
    if (element is UsePageRoute) {
      routingKey = element.path;
      break;
    }
  }
  return routingKey;
}

/// Create routing widget from widget class
///
/// (BuildContext context) => WidgetClass()
GoRoute createRoutingWidget(Type page) {
  return GoRoute(
    path: getRoutingKey(page),
    builder: (BuildContext context, GoRouterState state) =>
        TrueSightReflector.newInstance<Widget>(page),
  );
}
