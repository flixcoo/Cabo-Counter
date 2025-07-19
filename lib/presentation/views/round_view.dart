import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    if (widget.roundNumber < widget.gameSession.roundNumber ||
        widget.gameSession.isGameFinished == true) {
      print(
          'Diese wurde bereits gespielt, deshalb werden die alten Punktestaende angezeigt');

      // If the current round has already been played, the text fields
      // are filled with the scores from this round
      for (int i = 0; i < _scoreControllerList.length; i++) {
        _scoreControllerList[i].text =
            gameSession.roundList[widget.roundNumber - 1].scores[i].toString();
      }
      _caboPlayerIndex =
          gameSession.roundList[widget.roundNumber - 1].caboPlayerIndex;
      _kamikazePlayerIndex =
          gameSession.roundList[widget.roundNumber - 1].kamikazePlayerIndex;
    }

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final rotatedPlayers = _getRotatedPlayers();
    final originalIndices = _getOriginalIndices();

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: true,
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => {
              LocalStorageService.saveGameSessions(),
              Navigator.pop(context)
            },
            child: Text(AppLocalizations.of(context).cancel),
          ),
          middle: Text(AppLocalizations.of(context).results),
          trailing: Visibility(
              visible: widget.gameSession.isGameFinished,
              child: const Icon(
                CupertinoIcons.lock,
                size: 25,
              ))),
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
                    Text(
                        '${AppLocalizations.of(context).round} ${widget.roundNumber}',
                        style: CustomTheme.roundTitle),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context).who_said_cabo,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            widget.gameSession.players.length > 3 ? 5 : 20,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        height: 60,
                        child: CupertinoSegmentedControl<int>(
                          unselectedColor: CustomTheme.backgroundTintColor,
                          selectedColor: CustomTheme.primaryColor,
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 8,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    name,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: rotatedPlayers.length,
                      itemBuilder: (context, index) {
                        final originalIndex = originalIndices[index];
                        final name = rotatedPlayers[index];
                        bool shouldShowMedal =
                            index == 0 && widget.roundNumber > 1;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CupertinoListTile(
                              backgroundColor: CupertinoColors.secondaryLabel,
                              title: Row(children: [
                                Expanded(
                                    child: Row(children: [
                                  Text(
                                    name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Visibility(
                                    visible: shouldShowMedal,
                                    child: const SizedBox(width: 10),
                                  ),
                                  Visibility(
                                      visible: shouldShowMedal,
                                      child: const Icon(FontAwesomeIcons.crown,
                                          size: 15))
                                ]))
                              ]),
                              subtitle: Text(
                                  '${widget.gameSession.playerScores[originalIndex]}'
                                  ' ${AppLocalizations.of(context).points}'),
                              trailing: SizedBox(
                                width: 100,
                                child: CupertinoTextField(
                                  maxLength: 3,
                                  focusNode: _focusNodeList[originalIndex],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    signed: true,
                                    decimal: false,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  textInputAction: index ==
                                          widget.gameSession.players.length - 1
                                      ? TextInputAction.done
                                      : TextInputAction.next,
                                  controller:
                                      _scoreControllerList[originalIndex],
                                  placeholder:
                                      AppLocalizations.of(context).points,
                                  textAlign: TextAlign.center,
                                  onSubmitted: (_) =>
                                      _focusNextTextfield(originalIndex),
                                  onChanged: (_) => setState(() {}),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Center(
                        heightFactor: 1,
                        child: CupertinoButton(
                          sizeStyle: CupertinoButtonSize.medium,
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFF202020),
                          onPressed: () async {
                            if (await _showKamikazeSheet(context)) {
                              if (!context.mounted) return;
                              _endOfRoundNavigation(context, true);
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context).kamikaze,
                            style: const TextStyle(
                              color: CupertinoColors.destructiveRed,
                            ),
                          ),
                        ),
                      ),
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
            child: KeyboardVisibilityBuilder(builder: (context, visible) {
              if (!visible) {
                return Container(
                  height: 80,
                  padding: const EdgeInsets.only(bottom: 20),
                  color: CustomTheme.backgroundTintColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CupertinoButton(
                        onPressed: _areRoundInputsValid()
                            ? () {
                                _endOfRoundNavigation(context, false);
                              }
                            : null,
                        child: Text(AppLocalizations.of(context).done),
                      ),
                      if (!widget.gameSession.isGameFinished)
                        CupertinoButton(
                          onPressed: _areRoundInputsValid()
                              ? () {
                                  _endOfRoundNavigation(context, true);
                                }
                              : null,
                          child: Text(AppLocalizations.of(context).next_round),
                        ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          )
        ],
      ),
    );
  }

  /// Gets the index of the player who won the previous round.
  int _getPreviousRoundWinnerIndex() {
    if (widget.roundNumber == 1) {
      return 0; // If it's the first round, there's no previous round, so return 0.
    }

    final previousRound = widget.gameSession.roundList[widget.roundNumber - 2];
    final scores = previousRound.scoreUpdates;

    // Find the index of the player with the minimum score
    int minScore = scores[0];
    int winnerIndex = 0;

    // Iterate through the scores to find the player with the minimum score
    for (int i = 1; i < scores.length; i++) {
      if (scores[i] < minScore) {
        minScore = scores[i];
        winnerIndex = i;
      }
    }

    return winnerIndex;
  }

  /// Rotates the players list based on the previous round's winner.
  List<String> _getRotatedPlayers() {
    final winnerIndex = _getPreviousRoundWinnerIndex();
    return [
      widget.gameSession.players[winnerIndex],
      ...widget.gameSession.players.sublist(winnerIndex + 1),
      ...widget.gameSession.players.sublist(0, winnerIndex)
    ];
  }

  /// Gets the original indices of the players by recalculating it from the rotated list.
  List<int> _getOriginalIndices() {
    final winnerIndex = _getPreviousRoundWinnerIndex();
    return [
      winnerIndex,
      ...List.generate(widget.gameSession.players.length - winnerIndex - 1,
          (i) => winnerIndex + i + 1),
      ...List.generate(winnerIndex, (i) => i)
    ];
  }

  Future<bool> _showKamikazeSheet(BuildContext context) async {
    return await showCupertinoModalPopup<bool?>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoActionSheet(
              title: Text(AppLocalizations.of(context).kamikaze),
              message: Text(AppLocalizations.of(context).who_has_kamikaze),
              actions: widget.gameSession.players.asMap().entries.map((entry) {
                final index = entry.key;
                final name = entry.value;
                return CupertinoActionSheetAction(
                  onPressed: () {
                    _kamikazePlayerIndex = index;
                    Navigator.pop(context, true);
                  },
                  child: Text(name),
                );
              }).toList(),
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context, false),
                isDestructiveAction: true,
                child: Text(AppLocalizations.of(context).cancel),
              ),
            );
          },
        ) ??
        false;
  }

  /// Focuses the next text field in the list of text fields.
  /// [index] is the index of the current text field.
  void _focusNextTextfield(int index) {
    final originalIndices = _getOriginalIndices();
    final currentPos = originalIndices.indexOf(index);

    if (currentPos < originalIndices.length - 1) {
      FocusScope.of(context)
          .requestFocus(_focusNodeList[originalIndices[currentPos + 1]]);
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
  /// It first determines, ifCalls the [_calculateScoredPoints()] method to calculate the points for
  /// every player. If the round is the highest round played in this game,
  /// it expands the player score lists. At the end it updates the score
  /// array for the game.
  List<int> _finishRound() {
    print('====================================');
    print('Runde ${widget.roundNumber} beendet');
    // The shown round is smaller than the newest round
    if (widget.roundNumber < widget.gameSession.roundNumber) {
      print('Da diese Runde bereits gespielt wurde, werden die alten '
          'Punktestaende ueberschrieben');
    }
    if (_kamikazePlayerIndex != null) {
      print('${widget.gameSession.players[_kamikazePlayerIndex!]} hat Kamikaze '
          'und bekommt 0 Punkte');
      print('Alle anderen Spieler bekommen 50 Punkte');
      widget.gameSession
          .applyKamikaze(widget.roundNumber, _kamikazePlayerIndex!);
    } else {
      List<int> roundScores = [];
      for (TextEditingController c in _scoreControllerList) {
        if (c.text.isNotEmpty) roundScores.add(int.parse(c.text));
      }
      widget.gameSession.calculateScoredPoints(
          widget.roundNumber, roundScores, _caboPlayerIndex);
    }
    List<int> bonusPlayers = widget.gameSession.updatePoints();
    if (widget.gameSession.isGameFinished == true) {
      print('Das Spiel ist beendet');
    } else if (widget.roundNumber == widget.gameSession.roundNumber) {
      widget.gameSession.increaseRound();
    }
    return bonusPlayers;
  }

  /// Shows a popup dialog with the information which player received the bonus points.
  Future<void> _showBonusPopup(
      BuildContext context, List<int> bonusPlayers) async {
    print('Bonus Popup wird angezeigt');
    int pointLimit = widget.gameSession.pointLimit;
    int bonusPoints = (pointLimit / 2).round();

    String resultText =
        _getBonusPopupMessageString(pointLimit, bonusPoints, bonusPlayers);

    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(AppLocalizations.of(context).bonus_points_title),
        content: Text(resultText),
        actions: [
          CupertinoDialogAction(
            child: Text(AppLocalizations.of(context).ok),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  /// Generates the message string for the bonus popup.
  /// It takes the [pointLimit], [bonusPoints] and the list of [bonusPlayers]
  /// and returns a formatted string.
  String _getBonusPopupMessageString(
      int pointLimit, int bonusPoints, List<int> bonusPlayers) {
    List<String> nameList =
        bonusPlayers.map((i) => widget.gameSession.players[i]).toList();
    String resultText = '';
    if (nameList.length == 1) {
      resultText = AppLocalizations.of(context).bonus_points_message(
          nameList.length, nameList.first, pointLimit, bonusPoints);
    } else {
      resultText = nameList.length == 2
          ? '${nameList[0]} & ${nameList[1]}'
          : '${nameList.sublist(0, nameList.length - 1).join(', ')} & ${nameList.last}';
      resultText = AppLocalizations.of(context).bonus_points_message(
        nameList.length,
        resultText,
        pointLimit,
        bonusPoints,
      );
    }
    return resultText;
  }

  /// Handles the navigation for the end of the round.
  /// It checks for bonus players and shows a popup, saves the game session,
  /// and navigates to the next round or back to the previous screen.
  /// It takes the BuildContext [context] and a boolean [navigateToNextRound] to determine
  /// if it should navigate to the next round or not.
  Future<void> _endOfRoundNavigation(
      BuildContext context, bool navigateToNextRound) async {
    List<int> bonusPlayersIndices = _finishRound();
    if (bonusPlayersIndices.isNotEmpty) {
      await _showBonusPopup(context, bonusPlayersIndices);
    }

    LocalStorageService.saveGameSessions();

    if (context.mounted) {
      // If the game is finished, pop the context and return to the previous screen.
      if (widget.gameSession.isGameFinished) {
        Navigator.pop(context);
        return;
      }
      // If navigateToNextRound is false, pop the context and return to the previous screen.
      if (!navigateToNextRound) {
        Navigator.pop(context);
        return;
      }
      // If navigateToNextRound is true and the game isn't finished yet,
      // pop the context and navigate to the next round.
      Navigator.pop(context, widget.roundNumber + 1);
    }
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
