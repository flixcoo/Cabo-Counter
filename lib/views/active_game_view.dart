import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/l10n/app_localizations.dart';
import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:cabo_counter/views/round_view.dart';
import 'package:flutter/cupertino.dart';

class ActiveGameView extends StatefulWidget {
  final GameSession gameSession;
  const ActiveGameView({super.key, required this.gameSession});

  @override
  // ignore: library_private_types_in_public_api
  _ActiveGameViewState createState() => _ActiveGameViewState();
}

class _ActiveGameViewState extends State<ActiveGameView> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.gameSession,
        builder: (context, _) {
          List<int> sortedPlayerIndices = _getSortedPlayerIndices();
          return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text(widget.gameSession.gameTitle),
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
                        itemCount: widget.gameSession.players.length,
                        itemBuilder: (BuildContext context, int index) {
                          int playerIndex = sortedPlayerIndices[index];
                          return CupertinoListTile(
                            title: Row(
                              children: [
                                _getPlacementPrefix(index),
                                const SizedBox(width: 5),
                                Text(
                                  widget.gameSession.players[playerIndex],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            trailing: Row(
                              children: [
                                const SizedBox(width: 5),
                                Text(
                                    '${widget.gameSession.playerScores[playerIndex]} '
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
                        itemCount: widget.gameSession.roundNumber,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.all(1),
                              child: CupertinoListTile(
                                title: Text(
                                  '${AppLocalizations.of(context).round} ${index + 1}',
                                ),
                                trailing: index + 1 !=
                                            widget.gameSession.roundNumber ||
                                        widget.gameSession.isGameFinished ==
                                            true
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
                                          gameSession: widget.gameSession,
                                          roundNumber: index + 1),
                                    ),
                                  );
                                },
                              ));
                        },
                      ),
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
        List<int>.generate(widget.gameSession.players.length, (index) => index);
    // Sort the indices based on the summed points
    playerIndices.sort((a, b) {
      int scoreA = widget.gameSession.playerScores[a];
      int scoreB = widget.gameSession.playerScores[b];
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
}
