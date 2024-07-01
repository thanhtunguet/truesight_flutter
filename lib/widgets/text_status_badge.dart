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

class TextStatusBadge extends StatefulWidget {
  final String status;

  final Color color;

  const TextStatusBadge({
    super.key,
    required this.status,
    this.color = const Color(0xFFFDDC69),
  });

  @override
  State<StatefulWidget> createState() {
    return _TextStatusBadgeState();
  }
}

class _TextStatusBadgeState extends State<TextStatusBadge> {
  late Color _textColor;

  @override
  void initState() {
    super.initState();
    _textColor = _findTextColor(widget.color, 3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: ShapeDecoration(
        color: widget.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.status,
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
