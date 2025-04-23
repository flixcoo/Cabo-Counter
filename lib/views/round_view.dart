import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/utility/theme.dart' as theme;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class RoundView extends StatefulWidget {
  final GameSession gameSession;
  final int roundNumber;
  const RoundView(
      {super.key, required this.roundNumber, required this.gameSession});

  @override
  // ignore: library_private_types_in_public_api
  _RoundViewState createState() => _RoundViewState();
}

class _RoundViewState extends State<RoundView> {
  /// The current game session.
  late GameSession gameSession = widget.gameSession;

  /// Index of the player who said CABO.
  int _caboPlayerIndex = 0;

  /// Index of the player who has Kamikaze.
  /// Default is null (no Kamikaze player).
  int? _kamikazePlayerIndex;

  /// List of text controllers for the score text fields.
  late final List<TextEditingController> _scoreControllerList = List.generate(
    widget.gameSession.players.length,
    (index) => TextEditingController(),
  );

  /// List of focus nodes for the score text fields.
  late final List<FocusNode> _focusNodeList = List.generate(
    widget.gameSession.players.length,
    (index) => FocusNode(),
  );

  @override
  void initState() {
    print('=== Runde ${widget.roundNumber} geöffnet ===');
    if (widget.roundNumber < widget.gameSession.round ||
        widget.gameSession.finished == true) {
      print('Die Runde ${widget.roundNumber} wurde bereits gespielt, deshalb '
          'werden die alten Punktestaende angezeigt');

      // If the current round has already been played, the text fields
      // are filled with the scores from this round
      for (int i = 0; i < _scoreControllerList.length; i++) {
        _scoreControllerList[i].text =
            gameSession.playerScores[i][widget.roundNumber].toString();
      }
    }
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: true,
        middle: const Text('Ergebnisse'),
        previousPageTitle: 'Übersicht',
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context, widget.gameSession),
          child: const Text('Abbrechen'),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 100 + bottomInset),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text('Runde ${widget.roundNumber}',
                        style: theme.roundTitle),
                    const SizedBox(height: 10),
                    const Text(
                      'Wer hat CABO gesagt?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            widget.gameSession.players.length > 3 ? 5 : 20,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        height: 40,
                        child: CupertinoSegmentedControl<int>(
                          unselectedColor: theme.backgroundTintColor,
                          selectedColor: theme.primaryColor,
                          groupValue: _caboPlayerIndex,
                          children: Map.fromEntries(widget.gameSession.players
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final name = entry.value;
                            return MapEntry(
                              index,
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: widget.gameSession
                                              .getLengthOfPlayerNames() >
                                          20
                                      ? (widget.gameSession
                                                  .getLengthOfPlayerNames() >
                                              32
                                          ? 5
                                          : 10)
                                      : 15,
                                  vertical: 6,
                                ),
                                child: Text(
                                  name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: widget.gameSession
                                                .getLengthOfPlayerNames() >
                                            28
                                        ? 14
                                        : 18,
                                  ),
                                ),
                              ),
                            );
                          })),
                          onValueChanged: (value) {
                            setState(() {
                              _caboPlayerIndex = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CupertinoListTile(
                        title: const Text('Spieler:in'),
                        trailing: Row(
                          children: const [
                            SizedBox(
                                width: 100,
                                child: Center(child: Text('Punkte'))),
                            SizedBox(width: 28),
                            SizedBox(
                                width: 70,
                                child: Center(child: Text('Kamikaze'))),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.gameSession.players.length,
                      itemBuilder: (context, index) {
                        final name = widget.gameSession.players[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CupertinoListTile(
                              backgroundColor: CupertinoColors.secondaryLabel,
                              title: Row(children: [Text(name)]),
                              subtitle: Text(
                                  '${widget.gameSession.playerScores[index][0]} Punkte'),
                              trailing: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: CupertinoTextField(
                                      maxLength: 3,
                                      focusNode: _focusNodeList[index],
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        signed: true,
                                        decimal: false,
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      textInputAction: index ==
                                              widget.gameSession.players
                                                      .length -
                                                  1
                                          ? TextInputAction.done
                                          : TextInputAction.next,
                                      controller: _scoreControllerList[index],
                                      placeholder: 'Punkte',
                                      textAlign: TextAlign.center,
                                      onSubmitted: (_) =>
                                          _focusNextTextfield(index),
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _kamikazePlayerIndex =
                                            (_kamikazePlayerIndex == index)
                                                ? null
                                                : index;
                                      });
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _kamikazePlayerIndex == index
                                            ? CupertinoColors.systemRed
                                            : CupertinoColors
                                                .tertiarySystemFill,
                                        border: Border.all(
                                          color: _kamikazePlayerIndex == index
                                              ? CupertinoColors.systemRed
                                              : CupertinoColors.systemGrey,
                                        ),
                                      ),
                                      child: _kamikazePlayerIndex == index
                                          ? const Icon(
                                              CupertinoIcons.exclamationmark,
                                              size: 16,
                                              color: CupertinoColors.white,
                                            )
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: 22),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomInset,
            child: Container(
              height: 80,
              padding: const EdgeInsets.only(bottom: 20),
              color: theme.backgroundTintColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoButton(
                    onPressed: _areRoundInputsValid()
                        ? () {
                            _finishRound();
                            Navigator.pop(context, widget.gameSession);
                          }
                        : null,
                    child: const Text('Fertig'),
                  ),
                  CupertinoButton(
                    onPressed: _areRoundInputsValid()
                        ? () {
                            _finishRound();
                            if (widget.gameSession.finished == true) {
                              Navigator.pop(context, widget.gameSession);
                            } else {
                              Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => RoundView(
                                    gameSession: widget.gameSession,
                                    roundNumber: widget.roundNumber + 1,
                                  ),
                                ),
                              );
                            }
                          }
                        : null,
                    child: const Text('Nächste Runde'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Focuses the next text field in the list of text fields.
  /// [index] is the index of the current text field.
  void _focusNextTextfield(int index) {
    if (index < widget.gameSession.players.length - 1) {
      FocusScope.of(context).requestFocus(_focusNodeList[index + 1]);
    } else {
      _focusNodeList[index].unfocus();
    }
  }

  /// Checks if the inputs for the round are valid.
  /// Returns true if the inputs are valid, false otherwise.
  /// Round Inputs are valid if every player has a score or
  /// kamikaze is selected for a player
  bool _areRoundInputsValid() {
    if (_areTextFieldsEmpty() && _kamikazePlayerIndex == null) return false;
    return true;
  }

  /// Checks if any of the text fields for the players points are empty.
  /// Returns true if any of the text fields is empty, false otherwise.
  bool _areTextFieldsEmpty() {
    for (TextEditingController t in _scoreControllerList) {
      if (t.text.isEmpty) {
        return true;
      }
    }
    return false;
  }

  /// Finishes the current round.
  /// Calls the [_calculateScoredPoints()] method to calculate the points for
  /// every player. If the round is the highest round played in this game,
  /// it expands the player score lists. At the end it updates the score
  /// array for the game.
  void _finishRound() {
    print('====================================');
    print('Runde ${widget.roundNumber} beendet');
    // The shown round is smaller than the newest round
    if (widget.gameSession.round < widget.gameSession.playerScores[0].length) {
      print('Da diese Runde bereits gespielt wurde, werden die alten '
          'Punktestaende ueberschrieben');
      print('Alte Punktestaende:');
      print(gameSession.printRoundScores(widget.roundNumber));
    }

    _calculateScoredPoints();
    widget.gameSession.sumPoints();
    if (widget.gameSession.finished == true) {
      print('Das Spiel ist beendet');
    } else {
      if (widget.roundNumber >= widget.gameSession.playerScores[0].length - 1) {
        gameSession.expandPlayerScoreLists();
        print('Das Punkte-Array wurde erweitert');
      }
      widget.gameSession.increaseRound();
    }

    print('Die Punktesummen wurden aktualisiert');
  }

  /// Checks the scores of the current round and assigns points to the players.
  /// There are three possible outcomes of a round:
  ///
  /// **Case 1**<br>
  /// One player has Kamikaze. This player receives 0 points. Every other player
  /// receives 50 points.
  ///
  /// **Case 2**<br>
  /// The player who said CABO has the lowest score. They receive 0 points.
  /// Every other player gets their round score.
  ///
  /// **Case 3**<br>
  ///  The player who said CABO does not have the lowest score.
  ///  They receive 5 extra points added to their round score.
  ///  Every player with the lowest score gets 0 points.
  ///  Every other player gets their round score.
  void _calculateScoredPoints() {
    print('Spieler: ${gameSession.players}');

    // A player has Kamikaze
    if (_kamikazePlayerIndex != null) {
      print('${widget.gameSession.players[_kamikazePlayerIndex!]} hat Kamikaze '
          'und bekommt 0 Punkte');
      print('Alle anderen Spieler bekommen 50 Punkte');
      _applyKamikaze(_kamikazePlayerIndex!,
          List.generate(widget.gameSession.players.length, (index) => 0));
    } else {
      // List of the scores of the current round
      List<int> roundScores = [];
      for (TextEditingController c in _scoreControllerList) {
        if (c.text.isNotEmpty) roundScores.add(int.parse(c.text));
      }

      print('Punkte: $roundScores');
      print('${gameSession.players[_caboPlayerIndex]} hat CABO gesagt');
      print('${gameSession.players[_caboPlayerIndex]} hat '
          '${roundScores[_caboPlayerIndex]} Punkte');

      /// List of the index of the player(s) with the lowest score
      List<int> lowestScoreIndex = _getLowestScoreIndex(roundScores);
      print('Folgende Spieler haben die niedrigsten Punte:');
      for (int i in lowestScoreIndex) {
        print('${widget.gameSession.players[i]} (${roundScores[i]} Punkte)');
      }
      // The player who said CABO is one of the players which have the
      // fewest points.
      if (lowestScoreIndex.contains(_caboPlayerIndex)) {
        print('${widget.gameSession.players[_caboPlayerIndex]} hat CABO gesagt '
            'und bekommt 0 Punkte');
        print('Alle anderen Spieler bekommen ihre Punkte');
        _assignPoints([_caboPlayerIndex], -1, roundScores);
      } else {
        // A player other than the one who said CABO has the fewest points.
        print(
            '${widget.gameSession.players[_caboPlayerIndex]} hat CABO gesagt, '
            'jedoch nicht die wenigsten Punkte.');
        print('Folgende:r Spieler haben die wenigsten Punkte:');
        for (int i in lowestScoreIndex) {
          print('${widget.gameSession.players[i]}: ${roundScores[i]} Punkte');
        }
        _assignPoints(lowestScoreIndex, _caboPlayerIndex, roundScores);
      }
    }
  }

  /// Returns the index of the player with the lowest score. If there are
  /// multiple players with the same lowest score, all of them are returned.
  /// [roundScores] is a list of the scores of all players in the current round.
  List<int> _getLowestScoreIndex(List<int> roundScores) {
    int lowestScore = roundScores[0];
    List<int> lowestScoreIndex = [0];

    for (int i = 1; i < roundScores.length; i++) {
      if (roundScores[i] < lowestScore) {
        lowestScore = roundScores[i];
        lowestScoreIndex = [i];
      } else if (roundScores[i] == lowestScore) {
        lowestScoreIndex.add(i);
      }
    }
    return lowestScoreIndex;
  }

  /// Assigns 50 points to all players except the kamikaze player.
  /// [kamikazePlayerIndex] is the index of the kamikaze player.
  /// [roundScores] is the list of the scores of all players in the
  /// current round.
  void _applyKamikaze(int kamikazePlayerIndex, List<int> roundScores) {
    for (int i = 0; i < widget.gameSession.players.length; i++) {
      if (i != kamikazePlayerIndex) {
        roundScores[i] += 50;
      }
    }
    gameSession.addRoundScoresToScoreList(roundScores, widget.roundNumber);
  }

  /// Assigns points to the players based on the scores of the current round.
  /// [winnerIndex] is the index of the player(s) who receive 0 points
  /// [loserIndex] is the index of the player who receives 5 extra points
  /// [roundScores] is the raw list of the scores of all players in the
  /// current round.
  void _assignPoints(
      List<int> winnnerIndex, int loserIndex, List<int> roundScores) {
    print('Folgende Punkte wurden aus der Runde übernommen:');
    for (int i = 0; i < roundScores.length; i++) {
      print('${widget.gameSession.players[i]}: ${roundScores[i]}');
    }
    for (int i in winnnerIndex) {
      print(
          '${widget.gameSession.players[i]} hat gewonnen und bekommt 0 Punkte');
      roundScores[i] = 0;
    }
    if (loserIndex != -1) {
      print('${widget.gameSession.players[loserIndex]} bekommt 5 Fehlerpunkte');
      roundScores[loserIndex] += 5;
    }
    print('Aktualisierte Punkte:');
    for (int i = 0; i < roundScores.length; i++) {
      print('${widget.gameSession.players[i]}: ${roundScores[i]}');
    }
    gameSession.addRoundScoresToScoreList(roundScores, widget.roundNumber);
  }

  @override
  void dispose() {
    for (final controller in _scoreControllerList) {
      controller.dispose();
    }
    for (final focusNode in _focusNodeList) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
