import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/dto/game_manager.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_dialog_action.dart';
import 'package:cabo_counter/presentation/views/home/active_game/graph_view.dart';
import 'package:cabo_counter/presentation/views/home/active_game/points_view.dart';
import 'package:cabo_counter/presentation/views/home/active_game/round_view.dart';
import 'package:cabo_counter/presentation/views/home/create_game_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/data_transfer_service.dart';
import 'package:cabo_counter/services/poup_service.dart';
import 'package:collection/collection.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Displays the active game view, showing game details, player rankings, rounds, and statistics.
///
/// This view allows users to interact with an ongoing game session, including viewing player scores,
/// navigating through rounds, ending or deleting the game, exporting game data, and starting a new game
/// with the same settings. It also provides visual feedback such as confetti animation when the game ends.
///
/// The widget listens to changes in the provided [GameSession] and updates the UI accordingly.
class ActiveGameView extends StatefulWidget {
  final GameSession gameSession;
  const ActiveGameView({super.key, required this.gameSession});

  @override
  // ignore: library_private_types_in_public_api
  _ActiveGameViewState createState() => _ActiveGameViewState();
}

class _ActiveGameViewState extends State<ActiveGameView> {
  /// Constant value to represent a press on the cancel button in round view.
  static const int kRoundCancelled = -1;

  final confettiController = ConfettiController(
    duration: const Duration(seconds: 10),
  );

  late final GameSession gameSession;

  /// A list of the ranks for each player corresponding to their index in sortedPlayerIndices
  late List<int> denseRanks;

  /// A list of player indices sorted by their scores in ascending order.
  late List<int> sortedPlayerIndices;

  @override
  void initState() {
    super.initState();
    gameSession = widget.gameSession;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListenableBuilder(
            listenable: gameSession,
            builder: (context, _) {
              sortedPlayerIndices = _getSortedPlayerIndices();
              denseRanks = _calculateDenseRank(
                  gameSession.getPlayerScoresAsList(), sortedPlayerIndices);
              return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    previousPageTitle: AppLocalizations.of(context).games,
                    middle: Text(AppLocalizations.of(context).overview),
                  ),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              AppLocalizations.of(context).game,
                              style: CustomTheme.rowTitle,
                            ),
                          ),
                          CupertinoListTile(
                            title: Text(AppLocalizations.of(context).name),
                            trailing: Text(
                              gameSession.gameTitle,
                              style: TextStyle(color: CustomTheme.primaryColor),
                            ),
                          ),
                          CupertinoListTile(
                            title: Text(AppLocalizations.of(context).mode),
                            trailing: Text(
                              gameSession.isPointsLimitEnabled
                                  ? '${ConfigService.getPointLimit()} ${AppLocalizations.of(context).points}'
                                  : AppLocalizations.of(context).unlimited,
                              style: TextStyle(color: CustomTheme.primaryColor),
                            ),
                          ),
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
                                padding:
                                    const EdgeInsets.fromLTRB(14, 5, 14, 0),
                                title: Row(
                                  children: [
                                    _getPlacementTextWidget(index),
                                    const SizedBox(width: 5),
                                    Text(
                                      gameSession.players[playerIndex].name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    Text(
                                        '${gameSession.getPlayerScoresAsList()[playerIndex]} '
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
                                    trailing: index + 1 !=
                                                gameSession.roundNumber ||
                                            gameSession.isGameFinished == true
                                        ? (const Text('\u{2705}',
                                            style: TextStyle(fontSize: 22)))
                                        : const Text('\u{23F3}',
                                            style: TextStyle(fontSize: 22)),
                                    onTap: () async {
                                      _openRoundView(context, index + 1);
                                    },
                                  ));
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Text(
                              AppLocalizations.of(context).statistics,
                              style: CustomTheme.rowTitle,
                            ),
                          ),
                          Column(
                            children: [
                              CupertinoListTile(
                                  title: Text(
                                    AppLocalizations.of(context)
                                        .scoring_history,
                                  ),
                                  backgroundColorActivated:
                                      CustomTheme.backgroundColor,
                                  onTap: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (_) => GraphView(
                                                gameSession: gameSession,
                                              )))),
                              CupertinoListTile(
                                  title: Text(
                                    AppLocalizations.of(context).point_overview,
                                  ),
                                  backgroundColorActivated:
                                      CustomTheme.backgroundColor,
                                  onTap: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (_) => PointsView(
                                                gameSession: gameSession,
                                              )))),
                            ],
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
                              Visibility(
                                visible: !gameSession.isPointsLimitEnabled,
                                child: CupertinoListTile(
                                    title: Text(
                                      AppLocalizations.of(context).end_game,
                                      style: gameSession.roundNumber > 1 &&
                                              !gameSession.isGameFinished
                                          ? const TextStyle(color: Colors.white)
                                          : const TextStyle(
                                              color: Colors.white30),
                                    ),
                                    backgroundColorActivated:
                                        CustomTheme.backgroundColor,
                                    onTap: () {
                                      if (gameSession.roundNumber > 1 &&
                                          !gameSession.isGameFinished) {
                                        _showEndGameDialog();
                                      }
                                    }),
                              ),
                              CupertinoListTile(
                                title: Text(
                                  AppLocalizations.of(context).delete_game,
                                ),
                                backgroundColorActivated:
                                    CustomTheme.backgroundColor,
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
                                backgroundColorActivated:
                                    CustomTheme.backgroundColor,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (_) => CreateGameView(
                                                gameTitle:
                                                    gameSession.gameTitle,
                                                gameMode: widget.gameSession
                                                            .isPointsLimitEnabled ==
                                                        true
                                                    ? GameMode.pointLimit
                                                    : GameMode.unlimited,
                                                players: gameSession
                                                    .getPlayerNamesAsList(),
                                                previousPageTitle:
                                                    AppLocalizations.of(context)
                                                        .overview,
                                              )));
                                },
                              ),
                              CupertinoListTile(
                                  title: Text(
                                    AppLocalizations.of(context).export_game,
                                  ),
                                  backgroundColorActivated:
                                      CustomTheme.backgroundColor,
                                  onTap: () async {
                                    final success = await DataTransferService
                                        .exportSingleGameSession(
                                            widget.gameSession);
                                    if (!success && context.mounted) {
                                      PopupService.showInfoPopup(
                                          context,
                                          AppLocalizations.of(context)
                                              .export_error_title,
                                          AppLocalizations.of(context)
                                              .export_error_message);
                                    }
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
            }),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ConfettiWidget(
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag: 0.07,
                emissionFrequency: 0.1,
                numberOfParticles: 10,
                minBlastForce: 5,
                maxBlastForce: 20,
                confettiController: confettiController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Shows a dialog to confirm ending the game.
  /// If the user confirms, it calls the `endGame` method on the game manager
  void _showEndGameDialog() {
    final endGameAction = CustomDialogAction(
      isDestructiveAction: true,
      onPressed: () {
        setState(() {
          gameManager.endGame(gameSession.gameId);
          _playFinishAnimation(context);
        });
        Navigator.pop(context);
      },
      actionText: AppLocalizations.of(context).end_game,
    );
    final cancelAction = CustomDialogAction(
      actionText: AppLocalizations.of(context).cancel,
      onPressed: () => Navigator.pop(context),
    );

    PopupService.showSelectionPopup(
        context: context,
        title: Text(AppLocalizations.of(context).end_game_title),
        message: Text(AppLocalizations.of(context).end_game_message),
        actions: [endGameAction, cancelAction]);
  }

  /// Returns a list of player indices sorted by their scores in
  /// ascending order.
  List<int> _getSortedPlayerIndices() {
    List<int> playerIndices =
        List<int>.generate(gameSession.players.length, (index) => index);
    // Sort the indices based on the summed points
    playerIndices.sort((a, b) {
      int scoreA = gameSession.getPlayerScoresAsList()[a];
      int scoreB = gameSession.getPlayerScoresAsList()[b];
      if (scoreA != scoreB) {
        return scoreA.compareTo(scoreB);
      }
      return a.compareTo(b);
    });
    return playerIndices;
  }

  /// Calculates the dense rank for a player based on their index in the sorted list of players.
  List<int> _calculateDenseRank(
      List<int> playerScores, List<int> sortedIndices) {
    List<int> denseRanks = [];
    int rank = 1;
    for (int i = 0; i < sortedIndices.length; i++) {
      if (i > 0) {
        int prevScore = playerScores[sortedIndices[i - 1]];
        int currScore = playerScores[sortedIndices[i]];
        if (currScore != prevScore) {
          rank++;
        }
      }
      denseRanks.add(rank);
    }
    return denseRanks;
  }

  /// Returns a text widget representing the placement text based on the given placement number.
  /// [index] is the index of the player in [players] list,
  Text _getPlacementTextWidget(int index) {
    int placement = denseRanks[index];
    switch (placement) {
      case 1:
        return const Text('\u{1F947}', style: TextStyle(fontSize: 22)); // 🥇
      case 2:
        return const Text('\u{1F948}', style: TextStyle(fontSize: 22)); // 🥈
      case 3:
        return const Text('\u{1F949}', style: TextStyle(fontSize: 22)); // 🥉
      default:
        return Text(' $placement.',
            style: const TextStyle(fontWeight: FontWeight.bold));
    }
  }

  /// Shows a dialog to confirm deleting the game session.
  Future<bool> _showDeleteGameDialog() async {
    return await PopupService.showSelectionPopup<bool>(
          context: context,
          title: Text(AppLocalizations.of(context).delete_game_title),
          message: Text(AppLocalizations.of(context)
              .delete_game_message(gameSession.gameTitle)),
          actions: [
            CustomDialogAction(
              onPressed: () => Navigator.pop(context, false),
              actionText: AppLocalizations.of(context).cancel,
            ),
            CustomDialogAction(
              actionText: AppLocalizations.of(context).delete,
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ) ??
        false;
  }

  /// Removes the game session in the game manager and navigates back to the previous screen.
  /// If the game session does not exist in the game list, it shows an error dialog.
  Future<void> _removeGameSession(GameSession gameSession) async {
    if (gameManager.gameExistsInGameList(gameSession.gameId)) {
      Navigator.pop(context);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        gameManager.deleteGameById(gameSession.gameId);
      });
    } else {
      PopupService.showInfoPopup(
          context,
          AppLocalizations.of(context).id_error_title,
          AppLocalizations.of(context).id_error_message);
    }
  }

  /// Recursively opens the RoundView for the specified round number.
  /// It starts with the given [roundNumber] and continues to open the next round
  /// until the user navigates back or the round number is invalid.
  void _openRoundView(BuildContext context, int roundNumber) async {
    final round = await Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => RoundView(
          gameSession: gameSession,
          roundNumber: roundNumber,
        ),
      ),
    );

    // If the user presses the cancel button
    if (round == kRoundCancelled) return;

    if (widget.gameSession.isGameFinished && context.mounted) {
      _playFinishAnimation(context);
    }

    // If the previous round was not the last one
    if (round != null && round >= 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(
            const Duration(milliseconds: Constants.kRoundViewDelay));
        if (context.mounted) {
          _openRoundView(context, round);
        }
      });
    }
  }

  /// Plays the confetti animation and shows a dialog with the winner's information.
  Future<void> _playFinishAnimation(BuildContext context) async {
    String winner = widget.gameSession.winner;

    int winnerPoints = widget.gameSession.getPlayerScoresAsList().min;
    int winnerAmount = winner.contains('&') ? 2 : 1;

    confettiController.play();

    await Future.delayed(const Duration(milliseconds: Constants.kPopUpDelay));

    if (context.mounted) {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(AppLocalizations.of(context).end_of_game_title),
              content: Text(AppLocalizations.of(context)
                  .end_of_game_message(winnerAmount, winner, winnerPoints)),
              actions: [
                CustomDialogAction(
                  actionText: AppLocalizations.of(context).ok,
                  onPressed: () {
                    confettiController.stop();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }
}
