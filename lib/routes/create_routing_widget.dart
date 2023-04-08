import 'package:flutter/widgets.dart';
import 'package:truesight_flutter/reflection/reflection.dart';

Widget createRoutingWidget(Type page) {
  return TrueSightReflector.newInstance<Widget>(page);
}
