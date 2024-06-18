import 'package:flutter/material.dart';
import 'package:truesight_flutter/truesight_flutter.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;

  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 24,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.zero,
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: CarbonButton(
                onTap: () {
                  if (onCancel != null) {
                    onCancel!();
                  }
                  Navigator.of(context).pop();
                },
                label: 'Không'.hardcoded,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Expanded(
              child: CarbonButton(
                onTap: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                label: 'Xác nhận'.hardcoded,
                color: Theme.of(context).colorScheme.primary,
                // textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
