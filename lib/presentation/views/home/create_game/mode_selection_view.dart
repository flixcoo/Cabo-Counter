import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/tiles/mode_tile.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.gamemode),
        //previousPageTitle: !showDeselection ? loc.new_game : '',
      ),
      body: ListView(
        children: [
          ModeTile(
            title: '$pointLimit ${loc.points}',
            description: loc.point_limit_description(pointLimit),
            onTap: () {
              Navigator.pop(context, GameMode.pointLimit);
            },
          ),
          ModeTile(
            title: loc.unlimited,
            description: loc.unlimited_description,
            onTap: () {
              Navigator.pop(context, GameMode.unlimited);
            },
          ),
          if (showDeselection)
            ModeTile(
              title: loc.no_default_mode,
              description: loc.no_default_description,
              onTap: () {
                Navigator.pop(context, GameMode.none);
              },
            ),
        ],
      ),
    );
  }
}
