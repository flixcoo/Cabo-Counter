import 'package:cabo_counter/data/game_manager.dart';
import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/l10n/app_localizations.dart';
import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:cabo_counter/views/create_game_view.dart';
import 'package:cabo_counter/views/graph_view.dart';
import 'package:cabo_counter/views/round_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActiveGameView extends StatefulWidget {
  final GameSession gameSession;
  const ActiveGameView({super.key, required this.gameSession});

  @override
  // ignore: library_private_types_in_public_api
  _ActiveGameViewState createState() => _ActiveGameViewState();
}

class _ActiveGameViewState extends State<ActiveGameView> {
  late final GameSession gameSession;

  @override
  void initState() {
    super.initState();
    gameSession = widget.gameSession;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: gameSession,
        builder: (context, _) {
          List<int> sortedPlayerIndices = _getSortedPlayerIndices();
          return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text(gameSession.gameTitle),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          AppLocalizations.of(context).players,
                          style: CustomTheme.rowTitle,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: gameSession.players.length,
                        itemBuilder: (BuildContext context, int index) {
                          int playerIndex = sortedPlayerIndices[index];
                          return CupertinoListTile(
                            title: Row(
                              children: [
                                _getPlacementPrefix(index),
                                const SizedBox(width: 5),
                                Text(
                                  gameSession.players[playerIndex],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            trailing: Row(
                              children: [
                                const SizedBox(width: 5),
                                Text('${gameSession.playerScores[playerIndex]} '
                                    '${AppLocalizations.of(context).points}')
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          AppLocalizations.of(context).rounds,
                          style: CustomTheme.rowTitle,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: gameSession.roundNumber,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.all(1),
                              child: CupertinoListTile(
                                backgroundColorActivated:
                                    CustomTheme.backgroundColor,
                                title: Text(
                                  '${AppLocalizations.of(context).round} ${index + 1}',
                                ),
                                trailing:
                                    index + 1 != gameSession.roundNumber ||
                                            gameSession.isGameFinished == true
                                        ? (const Text('\u{2705}',
                                            style: TextStyle(fontSize: 22)))
                                        : const Text('\u{23F3}',
                                            style: TextStyle(fontSize: 22)),
                                onTap: () async {
                                  // ignore: unused_local_variable
                                  final val = await Navigator.of(context,
                                          rootNavigator: true)
                                      .push(
                                    CupertinoPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => RoundView(
                                          gameSession: gameSession,
                                          roundNumber: index + 1),
                                    ),
                                  );
                                },
                              ));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          AppLocalizations.of(context).game,
                          style: CustomTheme.rowTitle,
                        ),
                      ),
                      Column(
                        children: [
                          CupertinoListTile(
                              backgroundColorActivated:
                                  CustomTheme.backgroundColor,
                              title: Text(
                                AppLocalizations.of(context).statistics,
                              ),
                              onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (_) => GraphView(
                                            gameSession: gameSession,
                                          )))),
                          CupertinoListTile(
                            title: Text(
                              AppLocalizations.of(context).delete_game,
                            ),
                            onTap: () {
                              _showDeleteGameDialog().then((value) {
                                if (value) {
                                  _removeGameSession(gameSession);
                                }
                              });
                            },
                          ),
                          CupertinoListTile(
                            title: Text(
                              AppLocalizations.of(context)
                                  .new_game_same_settings,
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (_) => CreateGameView(
                                            gameTitle: gameSession.gameTitle,
                                            isPointsLimitEnabled: widget
                                                .gameSession
                                                .isPointsLimitEnabled,
                                            players: gameSession.players,
                                          )));
                            },
                          ),
                          CupertinoListTile(
                            title:
                                Text(AppLocalizations.of(context).export_game,
                                    style: const TextStyle(
                                      color: Colors.white30,
                                    )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  /// Returns a list of player indices sorted by their scores in
  /// ascending order.
  List<int> _getSortedPlayerIndices() {
    List<int> playerIndices =
        List<int>.generate(gameSession.players.length, (index) => index);
    // Sort the indices based on the summed points
    playerIndices.sort((a, b) {
      int scoreA = gameSession.playerScores[a];
      int scoreB = gameSession.playerScores[b];
      return scoreA.compareTo(scoreB);
    });
    return playerIndices;
  }

  /// Returns a widget that displays the placement prefix based on the index.
  /// First three places are represented by medals, and the rest are numbered.
  /// [index] is the index of the player in the descending sorted list.
  Widget _getPlacementPrefix(int index) {
    switch (index) {
      case 0:
        return const Text(
          '\u{1F947}',
          style: TextStyle(fontSize: 22),
        );
      case 1:
        return const Text(
          '\u{1F948}',
          style: TextStyle(fontSize: 22),
        );
      case 2:
        return const Text(
          '\u{1F949}',
          style: TextStyle(fontSize: 22),
        );
      default:
        return Text(
          ' ${index + 1}.',
          style: const TextStyle(fontWeight: FontWeight.bold),
        );
    }
  }

  Future<bool> _showDeleteGameDialog() async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(AppLocalizations.of(context).delete_game),
              content: Text(
                  'Möchtes du das Spiel "${gameSession.gameTitle}" wirklich löschen?'),
              actions: [
                CupertinoDialogAction(
                  child: Text(AppLocalizations.of(context).cancel),
                  onPressed: () => Navigator.pop(context, false),
                ),
                CupertinoDialogAction(
                  child: Text(AppLocalizations.of(context).delete),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> _removeGameSession(GameSession gameSession) async {
    if (gameManager.gameExistsInGameList(gameSession.id)) {
      Navigator.pop(context);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        gameManager.removeGameSessionById(gameSession.id);
      });
    } else {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('ID Fehler'),
              content: const Text(
                  'Das Spiel hat bisher noch keine ID zugewiesen bekommen. Falls du das Spiel löschen möchtest, mache das bitte über das Hauptmenü. Alle neu erstellten Spiele haben eine ID.'),
              actions: [
                CupertinoDialogAction(
                  child: Text(AppLocalizations.of(context).ok),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }
  }
}
