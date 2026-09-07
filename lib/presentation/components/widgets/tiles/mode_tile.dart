import 'package:cabo_counter/core/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModeTile extends StatelessWidget {
  const ModeTile({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
    this.selected = false,
  });

  final String title;
  final String description;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          HapticFeedback.selectionClick();
          onTap?.call();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: CustomTheme.mainElementColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: selected ? CustomTheme.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: CustomTheme.modeTitle),
            const SizedBox(height: 10),
            Text(description, style: CustomTheme.modeDescription),
          ],
        ),
      ),
    );
  }
}
