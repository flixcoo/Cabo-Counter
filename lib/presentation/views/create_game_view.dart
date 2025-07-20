import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/game_manager.dart';
import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/active_game_view.dart';
import 'package:cabo_counter/presentation/views/mode_selection_view.dart';
import 'package:cabo_counter/presentation/widgets/custom_button.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

enum CreateStatus {
  noGameTitle,
  noModeSelected,
  minPlayers,
  maxPlayers,
  noPlayerName,
}

class CreateGameView extends StatefulWidget {
  final GameMode gameMode;
  final String? gameTitle;
  final List<String>? players;

  const CreateGameView({
    super.key,
    this.gameTitle,
    this.players,
    required this.gameMode,
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

  /// Variable to hold the selected game mode.
  late GameMode gameMode;

  @override
  void initState() {
    super.initState();

    gameMode = widget.gameMode;

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
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: AppLocalizations.of(context).overview,
          middle: Text(AppLocalizations.of(context).new_game),
        ),
        child: SafeArea(
            child: SingleChildScrollView(
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
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                child: CupertinoTextField(
                  decoration: const BoxDecoration(),
                  readOnly: true,
                  prefix: Text(AppLocalizations.of(context).mode),
                  suffix: Row(
                    children: [
                      _getDisplayedGameMode(),
                      const SizedBox(width: 3),
                      const CupertinoListTileChevron(),
                    ],
                  ),
                  onTap: () async {
                    final selectedMode = await Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ModeSelectionMenu(
                          pointLimit: ConfigService.getPointLimit(),
                          showDeselection: false,
                        ),
                      ),
                    );

                    setState(() {
                      gameMode = selectedMode ?? gameMode;
                    });
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
              ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: _playerNameTextControllers.length,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (oldIndex < _playerNameTextControllers.length &&
                          newIndex <= _playerNameTextControllers.length) {
                        if (newIndex > oldIndex) newIndex--;
                        final item =
                            _playerNameTextControllers.removeAt(oldIndex);
                        _playerNameTextControllers.insert(newIndex, item);
                      }
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      key: ValueKey(
                          'player_${_playerNameTextControllers[index].hashCode}'),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                          AnimatedOpacity(
                            opacity: _playerNameTextControllers.length > 1
                                ? 1.0
                                : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ReorderableDragStartListener(
                                index: index,
                                child: const Icon(
                                  CupertinoIcons.line_horizontal_3,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 50),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context).add_player,
                            style: TextStyle(color: CustomTheme.primaryColor),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            CupertinoIcons.add_circled_solid,
                            color: CustomTheme.primaryColor,
                            size: 25,
                          ),
                        ],
                      ),
                      onPressed: () {
                        if (_playerNameTextControllers.length < maxPlayers) {
                          setState(() {
                            _playerNameTextControllers
                                .add(TextEditingController());
                          });
                        } else {
                          showFeedbackDialog(CreateStatus.maxPlayers);
                        }
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Center(
                  key: const ValueKey('create_game_button'),
                  child: CustomButton(
                    child: Text(
                      AppLocalizations.of(context).create_game,
                      style: TextStyle(
                        color: CustomTheme.primaryColor,
                      ),
                    ),
                    onPressed: () {
                      _checkAllGameAttributes();
                    },
                  ),
                ),
              ),
              KeyboardVisibilityBuilder(builder: (context, visible) {
                if (visible) {
                  return const SizedBox(
                    height: 250,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              })
            ],
          ),
        )));
  }

  Future<void> _createGame() async {
    /*var uuid = const Uuid();
    id = uuid.v1();*/

    List<String> players = [];
    for (var controller in _playerNameTextControllers) {
      players.add(controller.text);
    }

    bool isPointsLimitEnabled = gameMode == GameMode.pointLimit;

    GameSession gameSession = GameSession(
      createdAt: DateTime.now(),
      gameTitle: _gameTitleTextController.text,
      players: players,
      pointLimit: ConfigService.getPointLimit(),
      caboPenalty: ConfigService.getCaboPenalty(),
      isPointsLimitEnabled: isPointsLimitEnabled,
    );
    final index = await gameManager.addGameSession(gameSession);
    final session = gameManager.gameList[index];

    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) => ActiveGameView(gameSession: session)));
  }

  /// Displays a feedback dialog based on the [CreateStatus].
  void showFeedbackDialog(CreateStatus status) {
    final (title, message) = _getDialogContent(status);

    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                child: Text(AppLocalizations.of(context).ok),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  void _checkAllGameAttributes() {
    if (_gameTitleTextController.text == '') {
      _showDialog((
        AppLocalizations.of(context).no_gameTitle_title,
        AppLocalizations.of(context).no_gameTitle_message
      ));
      return;
    }

    if (gameMode == GameMode.none) {
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

  /// Returns the title and message for the dialog based on the [CreateStatus].
  (String, String) _getDialogContent(CreateStatus status) {
    switch (status) {
      case CreateStatus.noGameTitle:
        return (
          AppLocalizations.of(context).no_gameTitle_title,
          AppLocalizations.of(context).no_gameTitle_message
        );
      case CreateStatus.noModeSelected:
        return (
          AppLocalizations.of(context).no_mode_title,
          AppLocalizations.of(context).no_mode_message
        );

      case CreateStatus.minPlayers:
        return (
          AppLocalizations.of(context).min_players_title,
          AppLocalizations.of(context).min_players_message
        );
      case CreateStatus.maxPlayers:
        return (
          AppLocalizations.of(context).max_players_title,
          AppLocalizations.of(context).max_players_message
        );
      case CreateStatus.noPlayerName:
        return (
          AppLocalizations.of(context).no_name_title,
          AppLocalizations.of(context).no_name_message
        );
    }
  }

  /// Checks if every player has a name.
  /// Returns true if all players have a name, false otherwise.
  bool everyPlayerHasAName() {
    for (var controller in _playerNameTextControllers) {
      if (controller.text == '') {
        return false;
      }
    }
    return true;
  }

  Text _getDisplayedGameMode() {
    if (gameMode == GameMode.none) {
      return Text(AppLocalizations.of(context).no_mode_selected);
    } else if (gameMode == GameMode.pointLimit) {
      return Text(
          '${ConfigService.getPointLimit()} ${AppLocalizations.of(context).points}',
          style: TextStyle(color: CustomTheme.primaryColor));
    } else {
      return Text(AppLocalizations.of(context).unlimited,
          style: TextStyle(color: CustomTheme.primaryColor));
    }
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
