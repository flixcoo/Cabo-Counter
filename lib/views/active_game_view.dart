import 'package:cabo_counter/data_classes/game_session.dart';
import 'package:cabo_counter/utility/theme.dart' as theme;
import 'package:cabo_counter/views/round_view.dart';
import 'package:flutter/cupertino.dart';

class ActiveGameView extends StatefulWidget {
  final GameSession gameSession;
  const ActiveGameView({super.key, required this.gameSession});

  @override
  // ignore: library_private_types_in_public_api
  _ActiveGameViewState createState() => _ActiveGameViewState();
}

class _ActiveGameViewState extends State<ActiveGameView> {
  List<int> sortedPlayerIndices = [];

  @override
  Widget build(BuildContext context) {
    sortedPlayerIndices = _getSortedPlayerIndices();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.gameSession.gameTitle),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                'Spieler:innen',
                style: theme.createGameTitle,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.gameSession.players.length,
              itemBuilder: (BuildContext context, int index) {
                int playerIndex = sortedPlayerIndices[index];
                return CupertinoListTile(
                  title: Row(
                    children: [
                      _getPlayerPlacement(index),
                      SizedBox(width: 5),
                      Text(
                        widget.gameSession.players[playerIndex],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: Row(
                    children: [
                      SizedBox(width: 5),
                      Text('${widget.gameSession.playerScores[playerIndex][0]} '
                          'Punkte')
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                'Runden',
                style: theme.createGameTitle,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.gameSession.playerScores[0].length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => RoundView(
                              gameSession: widget.gameSession,
                              roundNumber: index + 1),
                        ),
                      );
                    },
                    child: CupertinoListTile(
                      title: Text(
                        'Runde ${index + 1}',
                      ),
                      trailing:
                          index + 1 == widget.gameSession.playerScores[0].length
                              ? Text('⏳', style: TextStyle(fontSize: 22))
                              : Text('✅', style: TextStyle(fontSize: 22)),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }

  List<int> _getSortedPlayerIndices() {
    // Erstelle eine Liste von Indizes der Spieler
    List<int> playerIndices =
        List<int>.generate(widget.gameSession.players.length, (index) => index);
    // Sortiere die Indizes basierend auf den summierten Punkten
    // (playerScores[i][0])
    playerIndices.sort((a, b) {
      int scoreA = widget.gameSession.playerScores[a][0];
      int scoreB = widget.gameSession.playerScores[b][0];
      return scoreA.compareTo(scoreB); // Absteigende Sortierung
    });
    return playerIndices;
  }

  Widget _getPlayerPlacement(int index) {
    switch (index) {
      case 0:
        return Text(
          '🥇',
          style: TextStyle(fontSize: 22),
        );
      case 1:
        return Text(
          '🥈',
          style: TextStyle(fontSize: 22),
        );
      case 2:
        return Text(
          '🥉',
          style: TextStyle(fontSize: 22),
        );
      default:
        return Text(
          ' ${index + 1}.',
          style: TextStyle(fontWeight: FontWeight.bold),
        );
    }
  }
}
