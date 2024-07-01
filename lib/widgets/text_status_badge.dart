import 'dart:math';

import 'package:flutter/material.dart';

/// Calculate the luminance of an [Color] object.
double _calculateLuminance(Color color) {
  double? r = color.red / 255.0;
  double? g = color.green / 255.0;
  double? b = color.blue / 255.0;

  // Apply gamma correction
  r = (r <= 0.03928 ? r / 12.92 : pow(2.4, (r + 0.055) / 1.055) as double?);
  g = (g <= 0.03928 ? g / 12.92 : pow((g + 0.055) / 1.055, 2.4)) as double?;
  b = (b <= 0.03928 ? b / 12.92 : pow((b + 0.055) / 1.055, 2.4)) as double?;

  return 0.2126 * r! + 0.7152 * g! + 0.0722 * b!;
}

/// Calculate the contrast ratio between two [Color] objects.
double _contrastRatio(Color textColor, Color backgroundColor) {
  double textLuminance = _calculateLuminance(textColor);
  double backgroundLuminance = _calculateLuminance(backgroundColor);
  double lighter =
      textLuminance > backgroundLuminance ? textLuminance : backgroundLuminance;
  double darker =
      textLuminance > backgroundLuminance ? backgroundLuminance : textLuminance;

  return (lighter + 0.05) / (darker + 0.05);
}

/// Determine a background color that meets the contrast ratio constraint.
Color _findTextColor(Color textColor, double minContrastRatio) {
  // Start with a high luminance background color (white)
  Color backgroundColor = Colors.white;
  double backgroundLuminance = _calculateLuminance(backgroundColor);
  double currentContrastRatio = _contrastRatio(textColor, backgroundColor);

  // Adjust the background color luminance to meet the minimum contrast ratio
  while (currentContrastRatio < minContrastRatio) {
    backgroundLuminance -= 0.01;
    if (backgroundLuminance < 0) {
      backgroundLuminance = 0;
      break;
    }

    int newR = (backgroundLuminance * 255).round();
    backgroundColor = Color.fromARGB(255, newR, newR, newR);
    currentContrastRatio = _contrastRatio(textColor, backgroundColor);
  }

  return backgroundColor;
}

class TextStatusBadge extends StatelessWidget {
  final String status;

  final Color _color;

  final Color _textColor;

  final String? hexColor;

  static Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  TextStatusBadge({
    super.key,
    required this.status,
    Color? color,
    this.hexColor,
  }) {
    if (color != null) {
      this.color = color;
      return;
    }
    if (hexColor != null && hexColor.isNotEmpty) {
      this.color = _hexToColor(hexColor!);
      return;
    }
    this.color =  const Color(0xFFFDDC69);
  };

  set Color color(Color color) {
    _color = color;
    _textColor = _findTextColor(color, 2.4);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: ShapeDecoration(
        color: _color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            status,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: _textColor,
                ),
          ),
        ],
      ),
    );
  }
}
