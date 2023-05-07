part of 'routes.dart';

/// Create routing widget from widget class
///
/// (BuildContext context) => WidgetClass()
GoRoute createRoutingWidget(Type page) {
  return GoRoute(
    path: getRoutingKey(page),
    builder: (context, state) => TrueSightReflector.newInstance<Widget>(page),
  );
}
