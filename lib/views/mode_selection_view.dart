import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:flutter/cupertino.dart';

class ModeSelectionMenu extends StatelessWidget {
  final int pointLimit;
  const ModeSelectionMenu({super.key, required this.pointLimit});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Spielmodus auswählen'),
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: CupertinoListTile(
              title: Text('$pointLimit Punkte', style: CustomTheme.modeTitle),
              subtitle: Text(
                'Es wird so lange gespielt, bis ein:e Spieler:in mehr als $pointLimit Punkte erreicht',
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
              title: Text('Unbegrenzt', style: CustomTheme.modeTitle),
              subtitle: const Text(
                'Dem Spiel sind keine Grenzen gesetzt. Es wird so lange '
                'gespielt, bis ihr keine Lust mehr habt.',
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
