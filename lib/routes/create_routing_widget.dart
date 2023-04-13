part of 'routes.dart';

/// Create routing widget from widget class
/// (BuildContext context) => WidgetClass()
Widget createRoutingWidget(Type page) {
  return TrueSightReflector.newInstance<Widget>(page);
}
