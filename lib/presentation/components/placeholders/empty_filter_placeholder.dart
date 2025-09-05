import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:flutter/cupertino.dart';

/// A placeholder for the [MainMenuView] when the filter does not return any games
class EmptyFilterPlaceholder extends StatefulWidget {
  final void Function() toggleShowOnlyActiveGames;

  const EmptyFilterPlaceholder(
      {super.key, required this.toggleShowOnlyActiveGames});

  @override
  State<EmptyFilterPlaceholder> createState() => _EmptyFilterPlaceholderState();
}

class _EmptyFilterPlaceholderState extends State<EmptyFilterPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Center(
          child: Icon(
            CupertinoIcons.eye_slash,
            size: 60,
            color: CustomTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Text(
            AppLocalizations.of(context).empty_filter_text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        CupertinoButton(
            onPressed: () => widget.toggleShowOnlyActiveGames(),
            child: Text(AppLocalizations.of(context).empty_filter_button))
      ],
    );
  }
}
