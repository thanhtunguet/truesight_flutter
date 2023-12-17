part of 'truesight_flutter.dart';

final Map<Type, String> _routes = {};

void registerRoute(Type type, String path) {
  _routes[type] = path;
}

String getRoutingKey(
  Type type, {
  Map<String, String>? pathParameters,
  Map<String, String>? queryParameters,
}) {
  String path = _routes[type]!;
  pathParameters?.forEach((key, value) {
    path = path.replaceAll(key, value);
  });
  final uri = Uri(
    path: path,
    queryParameters: queryParameters,
  );
  return uri.toString();
}
