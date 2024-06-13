import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  static const large = 'large';

  static const medium = 'medium';

  static const small = 'small';

  final String title;

  final String level;

  const AppTitle({
    super.key,
    required this.title,
    this.level = medium,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    TextStyle? titleTheme;
    switch (level) {
      case medium:
        titleTheme = textTheme.titleMedium;
        break;
      case small:
        titleTheme = textTheme.titleSmall;
        break;
      case large:
      default:
        titleTheme = textTheme.titleLarge;
    }
    return Text(
      title,
      style: titleTheme,
    );
  }
}
