import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget {
  final int index;

  final List<Widget> items;

  const AppNavigationBar({
    super.key,
    required this.index,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.surfaceContainer,
                blurRadius: 10,
                offset: const Offset(0, -10),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: items,
          ),
        ),
      ),
    );
  }
}
