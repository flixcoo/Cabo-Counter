import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/utility/globals.dart';
import 'package:cabo_counter/utility/theme.dart';
import 'package:cabo_counter/views/main_menu_view.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: Theme.primaryColor,
        scaffoldBackgroundColor: Theme.backgroundColor,
        textTheme: CupertinoTextThemeData(
          primaryColor: Theme.primaryColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Cabo Counter',
      home: const MainMenuView(),
    );
  }

  /// FIXME Just for Debugging
  /// Fills the game list with some test data.
  void fillGameList() {
    Globals.addGameSession(GameSession(
        gameTitle: 'Spiel am 27.02.2025',
        players: ['Clara', 'Tobias', 'Yannik', 'Lena', 'Lekaia'],
        gameHasPointLimit: true));
    Globals.addGameSession(GameSession(
        gameTitle: 'Freundschaftsrunde',
        players: ['Felix', 'Jonas', 'Nils'],
        gameHasPointLimit: false));
    Globals.addGameSession(GameSession(
      gameTitle: 'Familienabend',
      players: ['Mama', 'Papa', 'Lisa'],
      gameHasPointLimit: true,
    ));
    Globals.addGameSession(GameSession(
        gameTitle: 'Turnier 1. Runde',
        players: ['Tim', 'Max', 'Sophie', 'Lena'],
        gameHasPointLimit: false));
    Globals.addGameSession(GameSession(
        gameTitle: '2 Namen max length',
        players: ['Heinrich', 'Johannes'],
        gameHasPointLimit: true));
    Globals.addGameSession(GameSession(
        gameTitle: '3 Namen max length',
        players: ['Benjamin', 'Stefanie', 'Wolfgang'],
        gameHasPointLimit: false));
    Globals.addGameSession(GameSession(
        gameTitle: '4 Namen max length',
        players: ['Leonhard', 'Mathilde', 'Bernhard', 'Gerlinde'],
        gameHasPointLimit: true));
    Globals.addGameSession(GameSession(
        gameTitle: '5 Namen max length',
        players: ['Hartmuth', 'Elisabet', 'Rosalind', 'Theresia', 'Karoline'],
        gameHasPointLimit: false));
  }
}
