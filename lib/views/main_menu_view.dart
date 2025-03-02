import 'dart:math';

import 'package:cabo_counter/data_classes/game_session.dart';
import 'package:cabo_counter/views/active_game_view.dart';
import 'package:cabo_counter/views/create_game_view.dart';
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
        winner: 'Clara',
        gameMode: 0),
    GameSession(
        gameTitle: 'Freundschaftsrunde',
        players: ['Felix', 'Jonas', 'Nils'],
        winner: 'Jonas',
        gameMode: 1),
    GameSession(
      gameTitle: 'Familienabend',
      players: ['Mama', 'Papa', 'Lisa'],
      winner: 'Lisa',
      gameMode: 0,
    ),
    GameSession(
        gameTitle: 'Turnier 1. Runde',
        players: ['Tim', 'Max', 'Sophie', 'Lena'],
        winner: 'Sophie',
        gameMode: 0),
  ];
  @override
  Widget build(BuildContext context) {
    randomizeRoundNumbers();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
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
              return GestureDetector(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: CupertinoListTile(
                        title: Text(session.gameTitle),
                        leading: session.gameMode.toInt() == 0
                            ? Icon(CupertinoIcons.hare_fill)
                            : Icon(CupertinoIcons.time_solid),
                        subtitle: Text('Gewinner*in: ${session.winner}'),
                        trailing: Row(
                          children: [
                            Text('${session.round}'),
                            SizedBox(width: 3),
                            Icon(CupertinoIcons.arrow_2_circlepath_circle_fill),
                            SizedBox(width: 6),
                            Text('${session.players.length}'),
                            SizedBox(width: 3),
                            Icon(CupertinoIcons.person_2_fill),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ActiveGameView(
                                  gameSession: gameSessionArray[index]),
                            ),
                          );
                        },
                      )));
            },
          ),
        ),
      ),
    );
  }

  void randomizeRoundNumbers() {
    var random = Random();
    for (var s in gameSessionArray) {
      s.round = random.nextInt(20);
    }
  }
}
