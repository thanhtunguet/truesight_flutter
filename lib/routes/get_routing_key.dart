part of 'routes.dart';

/// Get routing key of Widget class
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
