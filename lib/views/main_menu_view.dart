import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:cabo_counter/utility/globals.dart';
import 'package:cabo_counter/utility/local_storage_service.dart';
import 'package:cabo_counter/views/active_game_view.dart';
import 'package:cabo_counter/views/create_game_view.dart';
import 'package:cabo_counter/views/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainMenuViewState createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  @override
  initState() {
    super.initState();
    LocalStorageService.loadGameSessions().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    LocalStorageService.loadGameSessions();
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const SettingsView(),
                ),
              );
            },
            icon: const Icon(
              CupertinoIcons.settings,
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
          child: Globals.gameList.isEmpty
              ? Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Oben ausrichten
                  children: [
                    const SizedBox(height: 30), // Abstand von oben
                    Center(
                        child: GestureDetector(
                      onTap: () => setState(() {}),
                      child: Icon(
                        CupertinoIcons.plus,
                        size: 60,
                        color: CustomTheme.primaryColor,
                      ),
                    )),
                    const SizedBox(height: 10), // Abstand von oben
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70),
                      child: Text(
                        'Ganz schön leer hier...\nFüge über den Button oben rechts eine neue Runde hinzu.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: Globals.gameList.length,
                  itemBuilder: (context, index) {
                    final session = Globals.gameList[index];
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: CupertinoListTile(
                          title: Text(session.gameTitle),
                          subtitle: session.isGameFinished == true
                              ? Text(
                                  '\u{1F947} ${session.winner}',
                                  style: const TextStyle(fontSize: 14),
                                )
                              : Text(
                                  'Modus: ${_translateGameMode(session.isPointsLimitEnabled)}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                          trailing: Row(
                            children: [
                              Text('${session.roundNumber}'),
                              const SizedBox(width: 3),
                              const Icon(CupertinoIcons
                                  .arrow_2_circlepath_circle_fill),
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
                                    gameSession: Globals.gameList[index]),
                              ),
                            );
                            setState(() {});
                          },
                        ));
                  }),
        ),
      ),
    );
  }

  String _translateGameMode(bool pointLimit) {
    if (pointLimit) return '101 Punkte';
    return 'Unbegrenzt';
  }
}
