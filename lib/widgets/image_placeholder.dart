import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  final double size;

  const ImagePlaceholder({
    super.key,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.grey[400]!,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.image,
          color: Colors.grey[700],
          size: size / 2,
        ),
      ),
    );
  }
}
