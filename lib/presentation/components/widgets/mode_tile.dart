import 'package:cabo_counter/core/custom_theme.dart';
import 'package:flutter/cupertino.dart';

class ModeTile extends StatelessWidget {
  const ModeTile({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
