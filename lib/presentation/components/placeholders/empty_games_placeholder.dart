import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/home/main_menu_view.dart';
import 'package:flutter/cupertino.dart';

/// A placeholder for the [MainMenuView] when the app contains no games
class EmptyGamesPlaceholder extends StatelessWidget {
  const EmptyGamesPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Center(
            child: Icon(
          CupertinoIcons.tray,
          size: 60,
          color: CustomTheme.primaryColor,
        )),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Text(
            '${AppLocalizations.of(context).empty_text_1}\n${AppLocalizations.of(context).empty_text_2}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
