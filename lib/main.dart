import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/utility/apptheme.dart';
import 'package:cabo_counter/utility/globals.dart';
import 'package:cabo_counter/utility/local_storage_service.dart';
import 'package:cabo_counter/views/main_menu_view.dart';
import 'package:flutter/cupertino.dart';

void main() {
  /// FIXME Just for Debugging
  /// Fills the game list with some test data.
  Globals.addGameSession(GameSession(
      gameTitle: 'Spiel am 27.02.2025',
      players: ['Clara', 'Tobias', 'Yannik', 'Lena', 'Lekaia'],
      isPointsLimitEnabled: true));
  Globals.addGameSession(GameSession(
      gameTitle: 'Freundschaftsrunde',
      players: ['Felix', 'Jonas', 'Nils'],
      isPointsLimitEnabled: false));
  Globals.addGameSession(GameSession(
    gameTitle: 'Familienabend',
    players: ['Mama', 'Papa', 'Lisa'],
    isPointsLimitEnabled: true,
  ));
  Globals.addGameSession(GameSession(
      gameTitle: 'Turnier 1. Runde',
      players: ['Tim', 'Max', 'Sophie', 'Lena'],
      isPointsLimitEnabled: false));
  Globals.addGameSession(GameSession(
      gameTitle: '2 Namen max length',
      players: ['Heinrich', 'Johannes'],
      isPointsLimitEnabled: true));
  Globals.addGameSession(GameSession(
      gameTitle: '3 Namen max length',
      players: ['Benjamin', 'Stefanie', 'Wolfgang'],
      isPointsLimitEnabled: false));
  Globals.addGameSession(GameSession(
      gameTitle: '4 Namen max length',
      players: ['Leonhard', 'Mathilde', 'Bernhard', 'Gerlinde'],
      isPointsLimitEnabled: true));
  Globals.addGameSession(GameSession(
      gameTitle: '5 Namen max length',
      players: ['Hartmuth', 'Elisabet', 'Rosalind', 'Theresia', 'Karoline'],
      isPointsLimitEnabled: false));

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    LocalStorageService.loadGameSessions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      LocalStorageService.saveGameSessions();
    }
  }

  @override
  Widget build(BuildContext context) {
    LocalStorageService.loadGameSessions();

    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: AppTheme.primaryColor,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        textTheme: CupertinoTextThemeData(
          primaryColor: AppTheme.primaryColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Cabo Counter',
      home: const MainMenuView(),
    );
  }
}
