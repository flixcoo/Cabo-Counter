import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/home/create_game_view.dart';
import 'package:cabo_counter/presentation/views/home/main_menu_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:flutter/cupertino.dart';

/// A placeholder for the [MainMenuView] when the app contains no games
class EmptyGamesPlaceholder extends StatefulWidget {
  const EmptyGamesPlaceholder({super.key});

  @override
  State<EmptyGamesPlaceholder> createState() => _EmptyGamesPlaceholderState();
}

class _EmptyGamesPlaceholderState extends State<EmptyGamesPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Center(
            child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CreateGameView(
                gameMode: ConfigService.getGameMode(),
                previousPageTitle: AppLocalizations.of(context).games,
              ),
            ),
          ),
          child: Icon(
            CupertinoIcons.plus,
            size: 60,
            color: CustomTheme.primaryColor,
          ),
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
