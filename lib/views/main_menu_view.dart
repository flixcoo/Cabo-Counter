import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:cabo_counter/utility/globals.dart';
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
  bool _isLoading = true;
  bool _isDeletionModeEnabled = false;

  @override
  initState() {
    super.initState();
    LocalStorageService.loadGameSessions().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('MainMenuView build');
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
              icon: _isDeletionModeEnabled
                  ? const Icon(null)
                  : const Icon(CupertinoIcons.settings, size: 30)),
          middle: const Text('Cabo Counter'),
          trailing: IconButton(
              onPressed: () => _isDeletionModeEnabled
                  ? _showDeleteAllGamesPopup()
                  : {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const CreateGame(),
                        ),
                      )
                    },
              icon: _isDeletionModeEnabled
                  ? const Icon(CupertinoIcons.trash, size: 25)
                  : const Icon(CupertinoIcons.add)),
        ),
        child: CupertinoPageScaffold(
          child: SafeArea(
            child: _isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : Globals.gameList.isEmpty
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
                    : GestureDetector(
                        onTap: () => {
                          if (_isDeletionModeEnabled)
                            {
                              setState(() {
                                _isDeletionModeEnabled = false;
                              }),
                              print('Deletion mode: $_isDeletionModeEnabled')
                            }
                        },
                        onLongPress: () => {
                          setState(() {
                            _isDeletionModeEnabled = true;
                          }),
                          print('Deletion mode: $_isDeletionModeEnabled')
                        },
                        child: ListView.builder(
                          itemCount: Globals.gameList.length,
                          itemBuilder: (context, index) {
                            final session = Globals.gameList[index];
                            return Dismissible(
                              key: Key(session.gameTitle),
                              background: Container(
                                color: CupertinoColors.destructiveRed,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 20.0),
                                child: const Icon(
                                  CupertinoIcons.delete,
                                  color: CupertinoColors.white,
                                ),
                              ),
                              direction: DismissDirection.startToEnd,
                              confirmDismiss: (direction) async {
                                if (_isDeletionModeEnabled) return false;
                                return await _showDeleteSingleGamePopup(index);
                              },
                              onDismissed: (direction) {
                                _deleteSpecificGame(index);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
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
                                  onTap: () => _isDeletionModeEnabled
                                      ? _showDeleteSingleGamePopup(index)
                                      : () async {
                                          //ignore: unused_local_variable
                                          final val = await Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  ActiveGameView(
                                                      gameSession: Globals
                                                          .gameList[index]),
                                            ),
                                          );
                                          setState(() {});
                                        },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ));
  }

  /// Translates the game mode boolean into the corresponding String.
  /// If [pointLimit] is true, it returns '101 Punkte', otherwise it returns 'Unbegrenzt'.
  String _translateGameMode(bool pointLimit) {
    if (pointLimit) return '101 Punkte';
    return 'Unbegrenzt';
  }

  /// Shows a confirmation dialog to delete all game sessions.
  void _showDeleteAllGamesPopup() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Alle Spiele löschen?'),
          content: const Text(
              'Bist du sicher, dass du alle Spiele löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.'),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Abbrechen'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                setState(() {
                  _deleteAllGames();
                  _isDeletionModeEnabled = false;
                });
                Navigator.pop(context);
              },
              child: const Text('Löschen'),
            ),
          ],
        );
      },
    );
  }

  /// Shows a confirmation dialog to delete all game sessions.
  Future<bool> _showDeleteSingleGamePopup(int gameIndex) async {
    final String title = Globals.gameList[gameIndex].gameTitle;
    bool? shouldDelete = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Spiel löschen?'),
          content: Text(
              'Bist du sicher, dass du die Runde "$title" löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.'),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Abbrechen'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Löschen'),
            ),
          ],
        );
      },
    );
    return shouldDelete ?? false;
  } //

  /// Deletes all game sessions.
  /// This functions clears the global games lists and triggers a save to the
  /// local storage. This overwrites the existing game data so that both the
  /// local json file and the global variable are empty.
  void _deleteAllGames() {
    Globals.gameList.clear();
    LocalStorageService.saveGameSessions();
  }

  /// Deletes a specific game session by its index.
  /// This function takes an [index] as parameter and removes the game session at
  /// that index from the global game list,
  void _deleteSpecificGame(int index) {
    Globals.gameList.removeAt(index);
    LocalStorageService.saveGameSessions();
  }
}
