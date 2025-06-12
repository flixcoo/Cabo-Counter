import 'package:cabo_counter/data/game_manager.dart';
import 'package:cabo_counter/l10n/app_localizations.dart';
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

  @override
  initState() {
    super.initState();
    LocalStorageService.loadGameSessions().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    gameManager.addListener(_updateView);
  }

  void _updateView() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: gameManager,
        builder: (context, _) {
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
                  icon: const Icon(CupertinoIcons.settings, size: 30)),
              middle: const Text('Cabo Counter'),
              trailing: IconButton(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const CreateGame(),
                          ),
                        )
                      },
                  icon: const Icon(CupertinoIcons.add)),
            ),
            child: CupertinoPageScaffold(
              child: SafeArea(
                child: _isLoading
                    ? const Center(child: CupertinoActivityIndicator())
                    : gameManager.gameList.isEmpty
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
                            itemCount: gameManager.gameList.length,
                            itemBuilder: (context, index) {
                              final session = gameManager.gameList[index];
                              return ListenableBuilder(
                                  listenable: session,
                                  builder: (context, _) {
                                    return Dismissible(
                                      key: Key(session.gameTitle),
                                      background: Container(
                                        color: CupertinoColors.destructiveRed,
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: const Icon(
                                          CupertinoIcons.delete,
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                      direction: DismissDirection.startToEnd,
                                      confirmDismiss: (direction) async {
                                        final String gameTitle = gameManager
                                            .gameList[index].gameTitle;
                                        return await _showDeleteGamePopup(
                                            gameTitle);
                                      },
                                      onDismissed: (direction) {
                                        gameManager.removeGameSession(index);
                                      },
                                      dismissThresholds: const {
                                        DismissDirection.startToEnd: 0.6
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: CupertinoListTile(
                                          backgroundColorActivated:
                                              CustomTheme.backgroundColor,
                                          title: Text(session.gameTitle),
                                          subtitle:
                                              session.isGameFinished == true
                                                  ? Text(
                                                      '\u{1F947} ${session.winner}',
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    )
                                                  : Text(
                                                      '${AppLocalizations.of(context).mode}: ${_translateGameMode(session.isPointsLimitEnabled)}',
                                                      style: const TextStyle(
                                                          fontSize: 14),
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
                                              const Icon(
                                                  CupertinoIcons.person_2_fill),
                                            ],
                                          ),
                                          onTap: () async {
                                            //ignore: unused_local_variable
                                            final val = await Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    ActiveGameView(
                                                        gameSession: gameManager
                                                            .gameList[index]),
                                              ),
                                            );
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
              ),
            ),
          );
        });
  }

  /// Translates the game mode boolean into the corresponding String.
  /// If [pointLimit] is true, it returns '101 Punkte', otherwise it returns 'Unbegrenzt'.
  String _translateGameMode(bool pointLimit) {
    if (pointLimit) {
      return '${Globals.pointLimit} ${AppLocalizations.of(context).points}';
    }
    return AppLocalizations.of(context).unlimited;
  }

  /// Shows a confirmation dialog to delete all game sessions.
  /// Returns true if the user confirms the deletion, false otherwise.
  /// [gameTitle] is the title of the game session to be deleted.
  Future<bool> _showDeleteGamePopup(String gameTitle) async {
    bool? shouldDelete = await showCupertinoDialog<bool>(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(AppLocalizations.of(context).delete_game_title),
              content: Text(
                  AppLocalizations.of(context).delete_game_message(gameTitle)),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(AppLocalizations.of(context).cancel),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(AppLocalizations.of(context).delete),
                ),
              ],
            );
          },
        ) ??
        false;
    return shouldDelete;
  }

  @override
  void dispose() {
    gameManager.removeListener(_updateView);
    super.dispose();
  }
}
