import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  static const large = 'large';
  static const medium = 'medium';
  static const small = 'small';

  final String text;
  final String level;

  const BodyText({
    super.key,
    required this.text,
    this.level = medium,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    TextStyle? bodyTextStyle;
    switch (level) {
      case medium:
        bodyTextStyle = textTheme.bodyMedium;
        break;
      case small:
        bodyTextStyle = textTheme.bodySmall;
        break;
      case large:
      default:
        bodyTextStyle = textTheme.bodyLarge;
    }
    return Text(
      text,
      style: bodyTextStyle,
    );
  }
}
