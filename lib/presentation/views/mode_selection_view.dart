import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

class ModeSelectionMenu extends StatelessWidget {
  final int pointLimit;
  const ModeSelectionMenu({super.key, required this.pointLimit});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context).select_game_mode),
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
                Navigator.pop(context, true);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CupertinoListTile(
              title: Text(AppLocalizations.of(context).unlimited,
                  style: CustomTheme.modeTitle),
              subtitle: Text(
                AppLocalizations.of(context).unlimited_description,
                style: CustomTheme.modeDescription,
                maxLines: 3,
              ),
              onTap: () {
                Navigator.pop(context, false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
