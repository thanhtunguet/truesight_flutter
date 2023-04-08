import 'package:reflectable/mirrors.dart';
import 'package:truesight_flutter/reflection/reflection.dart';

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
