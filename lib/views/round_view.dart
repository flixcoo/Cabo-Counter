import 'package:cabo_counter/data_classes/game_session.dart';
import 'package:cabo_counter/utility/styles.dart';
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

  /// List of booleans that represent whether the kamikaze checkbox is checked
  /// for a player on that index.
  late final List<bool> _isKamikazeChecked =
      List.filled(widget.gameSession.players.length, false);

  /// List of text controllers for the point text fields.
  late final List<TextEditingController> _pointControllers = List.generate(
    widget.gameSession.players.length,
    (index) => TextEditingController(),
  );

  /// List of focus nodes for the point text fields.
  late final List<FocusNode> _focusNodes = List.generate(
    widget.gameSession.players.length,
    (index) => FocusNode(),
  );

  @override
  void initState() {
    print('Runde ${widget.roundNumber} geöffnet');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Styles.backgroundColor,
        navigationBar: const CupertinoNavigationBar(
          transitionBetweenRoutes: true,
          middle: Text('Ergebnisse'),
          previousPageTitle: 'Übersicht',
        ),
        child: Stack(
          children: [
            SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 50),
                  child: Text(
                    'Runde ${widget.roundNumber}',
                    style: Styles.roundTitle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text('Wer hat CABO gesagt?',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: gameSession.players.length > 3 ? 5 : 20,
                      vertical: 10),
                  child: SizedBox(
                    height: 40,
                    child: CupertinoSegmentedControl<int>(
                      groupValue: _caboPlayerIndex,
                      children: Map<int, Widget>.fromIterable(
                        widget.gameSession.players.asMap().keys,
                        value: (index) => Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: gameSession.players.length > 3 ? 7 : 15,
                          ),
                          child: Text(
                            widget.gameSession.players[index],
                            style: TextStyle(
                                fontSize:
                                    gameSession.players.length > 3 ? 14 : 16),
                          ),
                        ),
                      ),
                      onValueChanged: (int value) {
                        setState(() {
                          _caboPlayerIndex = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  child: CupertinoListTile(
                    title: Text('Spieler:in'),
                    trailing: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Center(child: Text('Punkte')),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          width: 70,
                          child: Center(child: Text('Kamikaze')),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.gameSession.players.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(12), // Radius der Ecken
                            child: CupertinoListTile(
                                backgroundColor: CupertinoColors.secondaryLabel,
                                title: Row(
                                  children: [
                                    Text(widget.gameSession.players[index]),
                                  ],
                                ),
                                subtitle: Text(
                                  '${widget.gameSession.playerScores[index][0]}'
                                  ' Punkte',
                                ),
                                trailing: Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: CupertinoTextField(
                                        maxLength: 3,
                                        focusNode: _focusNodes[index],
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                          signed: true,
                                          decimal: false,
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        textInputAction: index ==
                                                widget.gameSession.players
                                                        .length -
                                                    1
                                            ? TextInputAction.done
                                            : TextInputAction.next,
                                        controller: _pointControllers[index],
                                        placeholder: 'Punkte',
                                        textAlign: TextAlign.center,
                                        // 👇 Action-Typ explizit setzen

                                        onSubmitted: (_) => _nextField(index),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    SizedBox(
                                      width: 50,
                                      child: CupertinoCheckbox(
                                        activeColor: Styles.primaryColor,
                                        tristate: false,
                                        value: _isKamikazeChecked[index],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isKamikazeChecked[index] = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ))));
                  },
                )),
              ],
            )),
            Positioned(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: theme.backgroundTintColor,
                ),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CupertinoButton(
                          child: const Text('Fertig'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CupertinoButton(
                            child: const Text('Nächste Runde'),
                            onPressed: () => {
                                  print('===================================='),
                                  print('Runde ${widget.roundNumber} beendet'),
                                  if (widget.roundNumber >=
                                      widget.gameSession.playerScores[0].length)
                                    {gameSession.expandPlayerScoreLists()},
                                  _checkForWinner(),
                                  widget.gameSession.sumPoints(),
                                  Navigator.pushReplacement(context,
                                      CupertinoPageRoute(builder: (context) {
                                    return RoundView(
                                        gameSession: widget.gameSession,
                                        roundNumber: widget.roundNumber + 1);
                                  })),
                                }),
                      ],
                    )),
              ),
            ),
          ],
        ));
  }

  /// Checks the scores of the current round and assigns points to the players.
  /// There are two possible outcomes of a round:
  ///
  /// **Case 1**<br>
  /// The player who said CABO has the lowest score. They receive 0 points.
  /// Every other player gets their round score.
  ///
  /// **Case 2**<br>
  ///  The player who said CABO does not have the lowest score.
  ///  They receive 5 extra points added to their round score.
  ///  Every player with the lowest score gets 0 points.
  ///  Every other player gets their round score.
  void _checkForWinner() {
    /// List of the scores of the current round
    List<int> roundScores = [];
    for (TextEditingController c in _pointControllers) {
      roundScores.add(int.parse(c.text));
    }
    print('Spieler: ${gameSession.players}');
    print('Punkte: $roundScores');
    print('${gameSession.players[_caboPlayerIndex]} hat CABO gesagt');
    print('${gameSession.players[_caboPlayerIndex]} hat '
        '${roundScores[_caboPlayerIndex]} Punkte');

    /// List of the index of the player(s) with the lowest score
    List<int> lowestScoreIndex = _getLowestScoreIndex(roundScores);
    // Spieler der CABO gesagt hat, hat am wenigsten Punkte
    if (lowestScoreIndex.contains(_caboPlayerIndex)) {
      print('${widget.gameSession.players[_caboPlayerIndex]} hat CABO gesagt '
          'und bekommt 0 Punkte');
      print('Alle anderen Spieler bekommen ihre Punkte');

      ///
      _assignPoints([_caboPlayerIndex], -1, roundScores);
    } else {
      // Ein anderer Spieler hat weniger Punkte
      print('${widget.gameSession.players[_caboPlayerIndex]} hat CABO gesagt, '
          'jedoch nicht die wenigsten Punkte.');

      print('Folgende:r Spieler haben die wenigsten Punkte:');
      for (int i in lowestScoreIndex) {
        print('${widget.gameSession.players[i]}: ${roundScores[i]} Punkte');
      }
      _assignPoints(lowestScoreIndex, _caboPlayerIndex, roundScores);
    }
  }

  /// Assigns points to the players based on the scores of the current round.
  /// [winnerIndex] is the index of the player(s) who receive 0 points
  /// [loserIndex] is the index of the player who receives 5 extra points
  /// [roundScores] is the raw list of the scores of all players in the
  /// current round.
  void _assignPoints(
      List<int> winnnerIndex, int loserIndex, List<int> roundScores) {
    print('Punkte der Spieler');
    for (int i = 0; i < roundScores.length; i++) {
      print('${widget.gameSession.players[i]}: ${roundScores[i]}');
    }
    for (int i in winnnerIndex) {
      print('${widget.gameSession.players[i]} bekommt 0 Punkte');
      roundScores[i] = 0;
    }
    if (loserIndex != -1) {
      print('${widget.gameSession.players[loserIndex]} bekommt 5 Fehlerpunkte');
      roundScores[loserIndex] += 5;
    }
    print('Aktualisierte Punkte');
    for (int i = 0; i < roundScores.length; i++) {
      print('${widget.gameSession.players[i]}: ${roundScores[i]}');
    }
    gameSession.addRoundScoresToScoreList(roundScores, widget.roundNumber);
  }

  /// Returns the index of the player with the lowest score. If there are
  /// multiple players with the same lowest score, all of them are returned.
  /// [roundScores] is a list of the scores of all players in the current round.
  List<int> _getLowestScoreIndex(List<int> roundScores) {
    int lowestScore = roundScores[0];
    List<int> lowestScoreIndex = [0];
    print('Niedrigster Score: ${gameSession.players[lowestScoreIndex[0]]} '
        '($lowestScore Punkte)');
    for (int i = 1; i < roundScores.length; i++) {
      if (roundScores[i] < lowestScore) {
        print('Neuer niedrigster Score: ${gameSession.players[i]} '
            '(${roundScores[i]} Punkte)');
        lowestScore = roundScores[i];
        lowestScoreIndex = [i];
      } else if (roundScores[i] == lowestScore) {
        print('${gameSession.players[i]} hat ebenfalls am wenigsten Punkte '
            '(${roundScores[i]} Punkte)');
        lowestScoreIndex.add(i);
      }
    }
    print('Folgende Spieler haben die niedrigsten Punte:');
    for (int i in lowestScoreIndex) {
      print('${widget.gameSession.players[i]} (${roundScores[i]} Punkte)');
    }
    return lowestScoreIndex;
  }

  /// Focuses the next text field in the list of text fields.
  /// [index] is the index of the current text field.
  void _nextField(int index) {
    if (index < widget.gameSession.players.length - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else {
      _focusNodes[index].unfocus();
    }
  }

  @override
  void dispose() {
    for (final controller in _pointControllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
