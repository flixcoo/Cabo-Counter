import 'package:cabo_counter/data/game_manager.dart';
import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/l10n/app_localizations.dart';
import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:cabo_counter/utility/globals.dart';
import 'package:cabo_counter/views/active_game_view.dart';
import 'package:cabo_counter/views/mode_selection_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateGameView extends StatefulWidget {
  final String? gameTitle;
  final bool? isPointsLimitEnabled;
  final List<String>? players;

  const CreateGameView({
    super.key,
    this.gameTitle,
    this.isPointsLimitEnabled,
    this.players,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CreateGameViewState createState() => _CreateGameViewState();
}

class _CreateGameViewState extends State<CreateGameView> {
  final List<TextEditingController> _playerNameTextControllers = [
    TextEditingController()
  ];
  final TextEditingController _gameTitleTextController =
      TextEditingController();

  /// Maximum number of players allowed in the game.
  final int maxPlayers = 5;

  /// Variable to store whether the points limit feature is enabled.
  bool? _isPointsLimitEnabled;

  @override
  void initState() {
    super.initState();

    _isPointsLimitEnabled = widget.isPointsLimitEnabled;
    _gameTitleTextController.text = widget.gameTitle ?? '';

    if (widget.players != null) {
      _playerNameTextControllers.clear();
      for (var player in widget.players!) {
        _playerNameTextControllers.add(TextEditingController(text: player));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: AppLocalizations.of(context).overview,
          middle: Text(AppLocalizations.of(context).new_game),
        ),
        child: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                AppLocalizations.of(context).game,
                style: CustomTheme.rowTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
              child: CupertinoTextField(
                decoration: const BoxDecoration(),
                maxLength: 16,
                prefix: Text(AppLocalizations.of(context).name),
                textAlign: TextAlign.right,
                placeholder: AppLocalizations.of(context).game_title,
                controller: _gameTitleTextController,
              ),
            ),
            // Spielmodus-Auswahl mit Chevron
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
              child: CupertinoTextField(
                decoration: const BoxDecoration(),
                readOnly: true,
                prefix: Text(AppLocalizations.of(context).mode),
                suffix: Row(
                  children: [
                    Text(
                      _isPointsLimitEnabled == null
                          ? AppLocalizations.of(context).select_mode
                          : (_isPointsLimitEnabled!
                              ? '${Globals.pointLimit} ${AppLocalizations.of(context).points}'
                              : AppLocalizations.of(context).unlimited),
                    ),
                    const SizedBox(width: 3),
                    const CupertinoListTileChevron(),
                  ],
                ),
                onTap: () async {
                  final selectedMode = await Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ModeSelectionMenu(
                        pointLimit: Globals.pointLimit,
                      ),
                    ),
                  );

                  if (selectedMode != null) {
                    setState(() {
                      _isPointsLimitEnabled = selectedMode;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                AppLocalizations.of(context).players,
                style: CustomTheme.rowTitle,
              ),
            ),
            Expanded(
              child: ReorderableListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _playerNameTextControllers.length + 2,
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex < _playerNameTextControllers.length &&
                      newIndex <= _playerNameTextControllers.length) {
                    setState(() {
                      if (newIndex > oldIndex) newIndex--;
                      final item =
                          _playerNameTextControllers.removeAt(oldIndex);
                      _playerNameTextControllers.insert(newIndex, item);
                    });
                  }
                },
                itemBuilder: (context, index) {
                  // Create game button
                  if (index == _playerNameTextControllers.length + 1) {
                    return Container(
                      key: const ValueKey('create_game_button'),
                      child: CupertinoButton(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: CustomTheme.primaryColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                AppLocalizations.of(context).create_game,
                                style: TextStyle(
                                  color: CustomTheme.backgroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          _checkAllGameAttributes();
                        },
                      ),
                    );
                  }
                  // Add player button
                  if (index == _playerNameTextControllers.length) {
                    return Container(
                      key: const ValueKey('add_player_button'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 10),
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.add_circled_solid,
                                color: CustomTheme.primaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                AppLocalizations.of(context).add_player,
                                style:
                                    TextStyle(color: CustomTheme.primaryColor),
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (_playerNameTextControllers.length <
                                maxPlayers) {
                              setState(() {
                                _playerNameTextControllers
                                    .add(TextEditingController());
                              });
                            } else {
                              _showDialog((
                                AppLocalizations.of(context).max_players_title,
                                AppLocalizations.of(context).max_players_message
                              ));
                            }
                          },
                        ),
                      ),
                    );
                  }
                  // Player name input field
                  return Padding(
                    key: ValueKey('player_${index + 1}'),
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 5),
                    child: Row(
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Icon(
                            CupertinoIcons.minus_circle_fill,
                            color: CupertinoColors.destructiveRed,
                            size: 25,
                          ),
                          onPressed: () {
                            setState(() {
                              _playerNameTextControllers[index].dispose();
                              _playerNameTextControllers.removeAt(index);
                            });
                          },
                        ),
                        Expanded(
                          child: CupertinoTextField(
                            controller: _playerNameTextControllers[index],
                            maxLength: 12,
                            placeholder:
                                '${AppLocalizations.of(context).player} ${index + 1}',
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ReorderableDragStartListener(
                          index: index,
                          child: const Icon(
                            CupertinoIcons.line_horizontal_3,
                            size: 20,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ))));
  }

  void _checkAllGameAttributes() {
    if (_gameTitleTextController.text == '') {
      _showDialog((
        AppLocalizations.of(context).no_gameTitle_title,
        AppLocalizations.of(context).no_gameTitle_message
      ));
      return;
    }

    if (_isPointsLimitEnabled == null) {
      _showDialog(
        (
          AppLocalizations.of(context).no_mode_title,
          AppLocalizations.of(context).no_mode_message
        ),
      );
      return;
    }

    if (_playerNameTextControllers.length < 2) {
      _showDialog(
        (
          AppLocalizations.of(context).min_players_title,
          AppLocalizations.of(context).min_players_message
        ),
      );
      return;
    }

    if (!everyPlayerHasAName()) {
      _showDialog((
        AppLocalizations.of(context).no_name_title,
        AppLocalizations.of(context).no_name_message
      ));
      return;
    }

    _createGame();
  }

  void _showDialog((String, String) content) {
    final (title, message) = content;
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text(AppLocalizations.of(context).ok),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Future<void> _createGame() async {
    List<String> players = [];
    for (var controller in _playerNameTextControllers) {
      players.add(controller.text);
    }
    GameSession gameSession = GameSession(
      createdAt: DateTime.now(),
      gameTitle: _gameTitleTextController.text,
      players: players,
      pointLimit: Globals.pointLimit,
      caboPenalty: Globals.caboPenalty,
      isPointsLimitEnabled: _isPointsLimitEnabled!,
    );
    final index = await gameManager.addGameSession(gameSession);
    final session = gameManager.gameList[index];

    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) => ActiveGameView(gameSession: session)));
  }

  bool everyPlayerHasAName() {
    for (var controller in _playerNameTextControllers) {
      if (controller.text == '') {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    _gameTitleTextController.dispose();
    for (var controller in _playerNameTextControllers) {
      controller.dispose();
    }

    super.dispose();
  }
}
