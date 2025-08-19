import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:flutter/cupertino.dart';

enum GameMode {
  none,
  pointLimit,
  unlimited,
}

/// A stateless widget that displays a menu for selecting the game mode.
///
/// The [ModeSelectionMenu] allows the user to choose between different game modes:
/// - Point limit mode with a specified [pointLimit]
/// - Unlimited mode
/// - Optionally, no default mode if [showDeselection] is true
class ModeSelectionMenu extends StatelessWidget {
  final int pointLimit;
  final bool showDeselection;
  const ModeSelectionMenu(
      {super.key, required this.pointLimit, required this.showDeselection});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context).gamemode),
        previousPageTitle:
            !showDeselection ? AppLocalizations.of(context).new_game : '',
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: CupertinoListTile(
              title: Text('$pointLimit ${AppLocalizations.of(context).points}',
                  style: CustomTheme.modeTitle),
              subtitle: Text(
                AppLocalizations.of(context)
                    .point_limit_description(pointLimit),
                style: CustomTheme.modeDescription,
                maxLines: 3,
              ),
              onTap: () {
                Navigator.pop(context, GameMode.pointLimit);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: CupertinoListTile(
              title: Text(AppLocalizations.of(context).unlimited,
                  style: CustomTheme.modeTitle),
              subtitle: Text(
                AppLocalizations.of(context).unlimited_description,
                style: CustomTheme.modeDescription,
                maxLines: 3,
              ),
              onTap: () {
                Navigator.pop(context, GameMode.unlimited);
              },
            ),
          ),
          Visibility(
              visible: showDeselection,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: CupertinoListTile(
                  title: Text(AppLocalizations.of(context).no_default_mode,
                      style: CustomTheme.modeTitle),
                  subtitle: Text(
                    AppLocalizations.of(context).no_default_description,
                    style: CustomTheme.modeDescription,
                    maxLines: 3,
                  ),
                  onTap: () {
                    Navigator.pop(context, GameMode.none);
                  },
                ),
              )),
        ],
      ),
    );
  }
}
