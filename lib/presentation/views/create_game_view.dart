import 'package:cabo_counter/core/constants.dart';
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
import 'package:uuid/uuid.dart';

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

  /// Factor to adjust the view length when the keyboard is visible.
  final double keyboardHeightAdjustmentFactor = 0.75;

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
                  maxLength: 20,
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
                      key: ValueKey(index),
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
                            duration: const Duration(
                                milliseconds: Constants.fadeInDuration),
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
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: null,
                          child: Icon(
                            CupertinoIcons.plus_circle_fill,
                            color: CustomTheme.primaryColor,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).add_player,
                                  style: TextStyle(
                                      color: CustomTheme.primaryColor),
                                ),
                              ),
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
                            _showFeedbackDialog(CreateStatus.maxPlayers);
                          }
                        },
                      ),
                    ),
                  ],
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
                  return SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom *
                        keyboardHeightAdjustmentFactor,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              })
            ],
          ),
        )));
  }

  /// Returns a widget that displays the currently selected game mode in the View.
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

  /// Checks all game attributes before creating a new game.
  /// If any attribute is invalid, it shows a feedback dialog.
  /// If all attributes are valid, it calls the `_createGame` method.
  void _checkAllGameAttributes() {
    if (_gameTitleTextController.text == '') {
      _showFeedbackDialog(CreateStatus.noGameTitle);
      return;
    }

    if (gameMode == GameMode.none) {
      _showFeedbackDialog(CreateStatus.noModeSelected);
      return;
    }

    if (_playerNameTextControllers.length < 2) {
      _showFeedbackDialog(CreateStatus.minPlayers);
      return;
    }

    if (!_everyPlayerHasAName()) {
      _showFeedbackDialog(CreateStatus.noPlayerName);
      return;
    }

    _createGame();
  }

  /// Checks if every player has a name.
  /// Returns true if all players have a name, false otherwise.
  bool _everyPlayerHasAName() {
    for (var controller in _playerNameTextControllers) {
      if (controller.text == '') {
        return false;
      }
    }
    return true;
  }

  /// Displays a feedback dialog based on the [CreateStatus].
  void _showFeedbackDialog(CreateStatus status) {
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

  /// Creates a new gameSession and navigates to the active game view.
  /// This method creates a new gameSession object with the provided attributes in the text fields.
  /// It then adds the game session to the game manager and navigates to the active game view.
  void _createGame() {
    var uuid = const Uuid();
    final String id = uuid.v1();

    List<String> players = [];
    for (var controller in _playerNameTextControllers) {
      players.add(controller.text);
    }

    bool isPointsLimitEnabled = gameMode == GameMode.pointLimit;

    GameSession gameSession = GameSession(
      id: id,
      createdAt: DateTime.now(),
      gameTitle: _gameTitleTextController.text,
      players: players,
      pointLimit: ConfigService.getPointLimit(),
      caboPenalty: ConfigService.getCaboPenalty(),
      isPointsLimitEnabled: isPointsLimitEnabled,
    );
    gameManager.addGameSession(gameSession);
    final session = gameManager.getGameSessionById(id) ?? gameSession;

    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) => ActiveGameView(gameSession: session)));
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
