import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/l10n/app_localizations.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

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

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: true,
        middle: Text(AppLocalizations.of(context).results),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => {
            LocalStorageService.saveGameSessions(),
            Navigator.pop(context, widget.gameSession)
          },
          child: Text(AppLocalizations.of(context).cancel),
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
                        height: 40,
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
                        title: Text(AppLocalizations.of(context).player),
                        trailing: Row(
                          children: [
                            SizedBox(
                                width: 100,
                                child: Center(
                                    child: Text(
                                        AppLocalizations.of(context).points))),
                            const SizedBox(width: 20),
                            SizedBox(
                                width: 80,
                                child: Center(
                                    child: Text(AppLocalizations.of(context)
                                        .kamikaze))),
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
                                  '${widget.gameSession.playerScores[index]}'
                                  ' ${AppLocalizations.of(context).points}'),
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
                                      placeholder:
                                          AppLocalizations.of(context).points,
                                      textAlign: TextAlign.center,
                                      onSubmitted: (_) =>
                                          _focusNextTextfield(index),
                                      onChanged: (_) => setState(() {}),
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
                                _finishRound();
                                LocalStorageService.saveGameSessions();
                                Navigator.pop(context, widget.gameSession);
                              }
                            : null,
                        child: Text(AppLocalizations.of(context).done),
                      ),
                      CupertinoButton(
                        onPressed: _areRoundInputsValid()
                            ? () {
                                _finishRound();
                                LocalStorageService.saveGameSessions();
                                if (widget.gameSession.isGameFinished == true) {
                                  Navigator.pop(context, widget.gameSession);
                                } else {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushReplacement(
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
  /// It first determines, ifCalls the [_calculateScoredPoints()] method to calculate the points for
  /// every player. If the round is the highest round played in this game,
  /// it expands the player score lists. At the end it updates the score
  /// array for the game.
  void _finishRound() {
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
    widget.gameSession.updatePoints();
    if (widget.gameSession.isGameFinished == true) {
      print('Das Spiel ist beendet');
    } else if (widget.roundNumber == widget.gameSession.roundNumber) {
      widget.gameSession.increaseRound();
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
