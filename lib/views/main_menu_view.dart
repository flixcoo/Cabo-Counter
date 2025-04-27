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
        pointLimit: true),
    GameSession(
        gameTitle: 'Freundschaftsrunde',
        players: ['Felix', 'Jonas', 'Nils'],
        pointLimit: false),
    GameSession(
      gameTitle: 'Familienabend',
      players: ['Mama', 'Papa', 'Lisa'],
      pointLimit: true,
    ),
    GameSession(
        gameTitle: 'Turnier 1. Runde',
        players: ['Tim', 'Max', 'Sophie', 'Lena'],
        pointLimit: false),
    GameSession(
        gameTitle: '2 Namen max length',
        players: ['Heinrich', 'Johannes'],
        pointLimit: true),
    GameSession(
        gameTitle: '3 Namen max length',
        players: ['Benjamin', 'Stefanie', 'Wolfgang'],
        pointLimit: false),
    GameSession(
        gameTitle: '4 Namen max length',
        players: ['Leonhard', 'Mathilde', 'Bernhard', 'Gerlinde'],
        pointLimit: true),
    GameSession(
        gameTitle: '5 Namen max length',
        players: ['Hartmuth', 'Elisabet', 'Rosalind', 'Theresia', 'Karoline'],
        pointLimit: false),
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
                  builder: (context) => const InformationView(),
                ),
              );
            },
            icon: const Icon(
              CupertinoIcons.info_circle,
              size: 30,
            )),
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
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: CupertinoListTile(
                    title: Text(session.gameTitle),
                    subtitle: session.finished == true
                        ? Text(
                            '\u{1F947} ${session.winner}',
                            style: const TextStyle(fontSize: 14),
                          )
                        : Text(
                            'Modus: ${_translateGameMode(session.pointLimit)}',
                            style: const TextStyle(fontSize: 14),
                          ),
                    trailing: Row(
                      children: [
                        Text('${session.round}'),
                        const SizedBox(width: 3),
                        const Icon(CupertinoIcons.arrow_2_circlepath_circle_fill),
                        const SizedBox(width: 15),
                        Text('${session.players.length}'),
                        const SizedBox(width: 3),
                        const Icon(CupertinoIcons.person_2_fill),
                      ],
                    ),
                    onTap: () async {
                      //ignore: unused_local_variable
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

  String _translateGameMode(bool pointLimit) {
    if (pointLimit) return '101 Punkte';
    return 'Unbegrenzt';
  }
}
