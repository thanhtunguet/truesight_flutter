import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

final Map<Type, String> _routes = {};

String getRoutingKey(Type type) {
  if (kDebugMode) {
    Logger("test").warning("Deprecated getRoutingKey");
  }
  if (!_routes.containsKey(type)) {
    throw Exception("Routing key not found for type $type");
  }
  return _routes[type]!;
}

void addRoutingKey(Type type, String path) {
  _routes[type] = path;
}

abstract class BaseRouter {
  static const String root = '/';

  abstract List<GoRoute> routes;

  abstract List<GoRoute> guestRoutes;

  late GoRouter routerConfig;

  late GoRouter guestRouterConfig;

  BaseRouter() {
    routerConfig = GoRouter(
      routes: routes,
    );
    guestRouterConfig = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: guestRoutes,
      initialLocation: root,
    );
  }
}
