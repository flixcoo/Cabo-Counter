import 'package:cabo_counter/utility/styles.dart';
import 'package:flutter/cupertino.dart';

class ModeSelectionMenu extends StatelessWidget {
  const ModeSelectionMenu({super.key});

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
              title: Text('101 Punkte', style: Styles.modeTitle),
              subtitle: const Text(
                'Es wird solange gespielt, bis einer Spieler die 101 Punkte '
                'genau erreicht oder überschreitet.',
                style: Styles.modeDescription,
                maxLines: 3,
              ),
              onTap: () {
                Navigator.pop(context, '101 Pkt.');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CupertinoListTile(
              title: Text('Unbegrenzt', style: Styles.modeTitle),
              subtitle: const Text(
                'Dem Spiel sind keine Grenzen gesetzt. Es wird so lange '
                'gespielt, bis die Spieler keine Lust mehr haben.',
                style: Styles.modeDescription,
                maxLines: 3,
              ),
              onTap: () {
                Navigator.pop(context, 'Unbegrenzt');
              },
            ),
          ),
        ],
      ),
    );
  }
}
