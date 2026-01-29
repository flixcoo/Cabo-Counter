import 'package:cabo_counter/core/custom_theme.dart';
import 'package:flutter/cupertino.dart';

class ModeTile extends StatelessWidget {
  const ModeTile({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
  });

  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: const BoxDecoration(
          color: CustomTheme.mainElementColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
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
