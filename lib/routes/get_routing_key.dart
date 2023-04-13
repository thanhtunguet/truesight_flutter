part of 'routes.dart';

/// Read the routing key of current widget (page)
/// Pass the Widget class as parameter
String getRoutingKey(Type page) {
  TypeMirror mirror = reflector.reflectType(page);
  var routingKey = "";
  for (var element in mirror.metadata) {
    if (element is UsePageRoute) {
      routingKey = element.route;
      break;
    }
  }
  return routingKey;
}
