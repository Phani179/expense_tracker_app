import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  ChartBar({required this.fill, super.key});

  double fill;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: FractionallySizedBox(
        heightFactor: fill,
        widthFactor: 0.9,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isDark
                ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                : Theme.of(context).colorScheme.primary.withOpacity(0.7),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
