import 'package:flutter/material.dart';

class CarbonButton extends StatelessWidget {
  final bool isLoading;

  final bool isExpanded;

  final void Function() onTap;

  final String label;

  final Color? color;

  final IconData? icon;

  const CarbonButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
    required this.label,
    this.color,
    this.icon,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Không bo góc
        ),
        backgroundColor: color ?? Theme.of(context).colorScheme.primary,
        textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    icon,
                    size: 20,
                    color: Colors.white,
                  ),
                ],
              ),
      ),
    );
    return isExpanded ? Expanded(child: child) : child;
  }
}
