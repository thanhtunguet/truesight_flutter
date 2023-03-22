import 'package:flutter/widgets.dart';
import 'package:reflectable/mirrors.dart';
import 'package:truesight_flutter/reflection/use_page_route.dart';

import '../reflection/reflector.dart';

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

Widget createRoutingWidget(Type page) {
  return TrueSightReflector.newInstance<Widget>(page);
}
