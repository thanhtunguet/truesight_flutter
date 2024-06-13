import 'dart:async';

import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  final Color? color;

  final double? size;

  final FutureOr<void> Function(BuildContext)? onGoBack;

  const GoBackButton({
    super.key,
    this.color,
    this.size,
    this.onGoBack,
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
        if (onGoBack != null) {
          onGoBack!(context);
        }
        Navigator.of(context).pop();
      },
    );
  }
}
