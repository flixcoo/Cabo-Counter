import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/mode_tile.dart';
import 'package:flutter/cupertino.dart';

/// A stateless widget that displays a menu for selecting the game mode.
///
/// The [ModeSelectionMenu] allows the user to choose between different game modes:
/// - Point limit mode with a specified [pointLimit]
/// - Unlimited mode
/// - Optionally, no default mode if [showDeselection] is true
class ModeSelectionMenu extends StatelessWidget {
  final int pointLimit;
  final bool showDeselection;
  const ModeSelectionMenu({
    super.key,
    required this.pointLimit,
    required this.showDeselection,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(loc.gamemode),
        previousPageTitle: !showDeselection ? loc.new_game : '',
      ),
      child: ListView(
        children: [
          ModeTile(
            title: '$pointLimit ${loc.points}',
            description: loc.point_limit_description(pointLimit),
          ),
          ModeTile(
            title: loc.unlimited,
            description: loc.unlimited_description,
          ),
          if (showDeselection)
            ModeTile(
              title: loc.no_default_mode,
              description: loc.no_default_description,
            ),
          /*Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: CupertinoListTile(
              title: Text(
                '$pointLimit ${loc.points}',
                style: CustomTheme.modeTitle,
              ),
              subtitle: Text(
                loc.point_limit_description(pointLimit),
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
              title: Text(loc.unlimited, style: CustomTheme.modeTitle),
              subtitle: Text(
                loc.unlimited_description,
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
                title: Text(loc.no_default_mode, style: CustomTheme.modeTitle),
                subtitle: Text(
                  loc.no_default_description,
                  style: CustomTheme.modeDescription,
                  maxLines: 3,
                ),
                onTap: () {
                  Navigator.pop(context, GameMode.none);
                },
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
