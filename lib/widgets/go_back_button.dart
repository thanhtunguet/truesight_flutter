import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  final Color? color;

  final double? size;

  const GoBackButton({
    super.key,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: color,
        size: size,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
