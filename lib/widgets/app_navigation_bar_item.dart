import 'package:flutter/material.dart';

class AppNavigationBarItem extends StatelessWidget {
  final IconData icon;

  final IconData? activeIcon;

  final String label;

  final bool isActive;

  final void Function()? onIndexChanged;

  const AppNavigationBarItem({
    super.key,
    required this.icon,
    required this.isActive,
    required this.label,
    this.activeIcon,
    this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
    final borderColor = isActive
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.surface;
    return Expanded(
      child: InkWell(
        onTap: onIndexChanged,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(
                width: 3,
                color: borderColor,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
              ),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
