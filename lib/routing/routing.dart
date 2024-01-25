final Map<Type, String> _routes = {};

String getRoutingKey(Type type) {
  if (!_routes.containsKey(type)) {
    throw Exception("Routing key not found for type $type");
  }
  return _routes[type]!;
}

void addRoutingKey(Type type, String path) {
  _routes[type] = path;
}
