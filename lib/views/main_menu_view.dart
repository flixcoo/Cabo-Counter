import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/views/active_game_view.dart';
import 'package:cabo_counter/views/create_game_view.dart';
import 'package:cabo_counter/views/information_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainMenuViewState createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  final List<GameSession> gameSessionArray = [
    GameSession(
        gameTitle: 'Spiel am 27.02.2025',
        players: ['Clara', 'Tobias', 'Yannik', 'Lena', 'Lekaia'],
        gameMode: 0),
    GameSession(
        gameTitle: 'Freundschaftsrunde',
        players: ['Felix', 'Jonas', 'Nils'],
        gameMode: 1),
    GameSession(
      gameTitle: 'Familienabend',
      players: ['Mama', 'Papa', 'Lisa'],
      gameMode: 0,
    ),
    GameSession(
        gameTitle: 'Turnier 1. Runde',
        players: ['Tim', 'Max', 'Sophie', 'Lena'],
        gameMode: 0),
    GameSession(
        gameTitle: '2 Namen max length',
        players: ['Heinrich', 'Johannes'],
        gameMode: 0),
    GameSession(
        gameTitle: '3 Namen max length',
        players: ['Benjamin', 'Stefanie', 'Wolfgang'],
        gameMode: 0),
    GameSession(
        gameTitle: '4 Namen max length',
        players: ['Leonhard', 'Mathilde', 'Bernhard', 'Gerlinde'],
        gameMode: 0),
    GameSession(
        gameTitle: '5 Namen max length',
        players: ['Hartmuth', 'Elisabet', 'Rosalind', 'Theresia', 'Karoline'],
        gameMode: 0),
  ];

  @override
  Widget build(BuildContext context) {
    gameSessionArray.sort((b, a) => a.createdAt.compareTo(b.createdAt));

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => InformationView(),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.info_circle)),
        middle: const Text('Cabo Counter'),
        trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const CreateGame(),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.add)),
      ),
      child: CupertinoPageScaffold(
        child: SafeArea(
          child: ListView.builder(
            itemCount: gameSessionArray.length,
            itemBuilder: (context, index) {
              final session = gameSessionArray[index];
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: CupertinoListTile(
                    title: Text(session.gameTitle),
                    subtitle: session.finished == true
                        ? Text(
                            '\u{1F947} ${session.winner}',
                            style: TextStyle(fontSize: 14),
                          )
                        : Text(
                            'Modus: ${_translateGameMode(session.gameMode)}',
                            style: TextStyle(fontSize: 14),
                          ),
                    trailing: Row(
                      children: [
                        Text('${session.round}'),
                        SizedBox(width: 3),
                        Icon(CupertinoIcons.arrow_2_circlepath_circle_fill),
                        SizedBox(width: 15),
                        Text('${session.players.length}'),
                        SizedBox(width: 3),
                        Icon(CupertinoIcons.person_2_fill),
                      ],
                    ),
                    onTap: () async {
                      final val = await Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ActiveGameView(
                              gameSession: gameSessionArray[index]),
                        ),
                      );
                      setState(() {});
                    },
                  ));
            },
          ),
        ),
      ),
    );
  }

  String _translateGameMode(int gameMode) {
    switch (gameMode) {
      case 0:
        return '101 Punkte';
      case 1:
        return 'Unendlich';
      default:
        return '-';
    }
  }
}
