part of 'truesight_flutter.dart';

final Map<Type, String> _routes = {};

// Register a Widget type with a path for go_router
void registerRoute(Type type, String path) {
  _routes[type] = path;
}

// Get the routing path for a given type
String getRoutingKey(
  Type type, {
  Map<String, String>? pathParameters,
  Map<String, String>? queryParameters,
}) {
  String path = _routes[type]!;
  pathParameters?.forEach((key, value) {
    path = path.replaceAll(":$key", value);
  });
  final uri = Uri(
    path: path,
    queryParameters: queryParameters,
  );
  return uri.toString();
}
