part of 'routes.dart';

Widget createRoutingWidget(Type page) {
  return TrueSightReflector.newInstance<Widget>(page);
}
