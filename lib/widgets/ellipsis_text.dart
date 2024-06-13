import 'package:flutter/material.dart';

class EllipsisText extends StatelessWidget {
  final String text;

  const EllipsisText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
