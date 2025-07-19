import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:flutter/cupertino.dart';

class ModeSelectionMenu extends StatelessWidget {
  final int pointLimit;
  final bool showDeselection;
  const ModeSelectionMenu(
      {super.key, required this.pointLimit, required this.showDeselection});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context).select_game_mode),
      ),
      child: ListView(
        children: [
          Visibility(
              visible: showDeselection,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: CupertinoListTile(
                  title:
                      Text('Kein Standardmodus', style: CustomTheme.modeTitle),
                  subtitle: const Text(
                    'Dein Standardmodus wird zurückgesetzt.',
                    style: CustomTheme.modeDescription,
                    maxLines: 3,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )),
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
