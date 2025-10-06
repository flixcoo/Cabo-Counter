import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/dto/game_manager.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/data/dto/player.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_button.dart';
import 'package:cabo_counter/presentation/views/home/active_game/active_game_view.dart';
import 'package:cabo_counter/presentation/views/home/active_game/mode_selection_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/popup_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

/// A view for creating a new game session in the Cabo Counter app.
///
/// The [CreateGameView] allows users to input a game title, select a game mode,
/// add and reorder player names, and validate all required fields before
/// starting a new game. It provides feedback dialogs for missing or invalid
/// input and navigates to the active game view upon successful creation.
class CreateGameView extends StatefulWidget {
  final GameMode gameMode;
  final String? gameTitle;
  final List<String>? players;
  final String previousPageTitle;

  const CreateGameView(
      {super.key,
      this.gameTitle,
      this.players,
      required this.gameMode,
      required this.previousPageTitle});

  @override
  // ignore: library_private_types_in_public_api
  _CreateGameViewState createState() => _CreateGameViewState();
}

class _CreateGameViewState extends State<CreateGameView> {
  final TextEditingController _gameTitleTextController =
      TextEditingController();

  /// List of text controllers for player names.
  final List<TextEditingController> _playerNameTextControllers = [
    TextEditingController()
  ];

  /// List of focus nodes for player name text fields.
  final List<FocusNode> _playerNameFocusNodes = [FocusNode()];

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
        _playerNameFocusNodes.add(FocusNode());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) async {
          if (!didPop) {
            await _keyboardDelay();
            if (context.mounted) Navigator.pop(context);
          }
        },
        child: CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              previousPageTitle: widget.previousPageTitle,
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
                      maxLength: 24,
                      prefix: Text(AppLocalizations.of(context).name),
                      textAlign: TextAlign.right,
                      placeholder: getFallbackGameTitle(),
                      controller: _gameTitleTextController,
                      onSubmitted: (_) {
                        _playerNameFocusNodes.isNotEmpty
                            ? _playerNameFocusNodes[0].requestFocus()
                            : FocusScope.of(context).unfocus();
                      },
                      textInputAction: _playerNameFocusNodes.isNotEmpty
                          ? TextInputAction.next
                          : TextInputAction.done,
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
                        await _keyboardDelay();

                        if (context.mounted) {
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
                                child: Icon(
                                  IconService.remove_player,
                                  color: CustomTheme.red,
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
                                  focusNode: _playerNameFocusNodes[index],
                                  maxLength: 12,
                                  placeholder:
                                      '${AppLocalizations.of(context).player} ${index + 1}',
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(),
                                  textInputAction: index + 1 <
                                          _playerNameTextControllers.length
                                      ? TextInputAction.next
                                      : TextInputAction.done,
                                  onSubmitted: (_) {
                                    if (index + 1 <
                                        _playerNameFocusNodes.length) {
                                      _playerNameFocusNodes[index + 1]
                                          .requestFocus();
                                    } else {
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                ),
                              ),
                              AnimatedOpacity(
                                opacity: _playerNameTextControllers.length > 1
                                    ? 1.0
                                    : 0.0,
                                duration: const Duration(
                                    milliseconds: Constants.kFadeInDuration),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ReorderableDragStartListener(
                                    index: index,
                                    child: Icon(
                                      IconService.drag,
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
                                IconService.add_player,
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
                              if (_playerNameTextControllers.length <
                                  maxPlayers) {
                                setState(() {
                                  _playerNameTextControllers
                                      .add(TextEditingController());
                                  _playerNameFocusNodes.add(FocusNode());
                                });
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  _playerNameFocusNodes.last.requestFocus();
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
                      child: CustomButton(
                        child: Text(
                          AppLocalizations.of(context).create_game,
                          style: TextStyle(
                            color: CustomTheme.primaryColor,
                          ),
                        ),
                        onPressed: () async {
                          await _keyboardDelay();
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
            ))));
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

    PopupService.showInfoPopup(
        context: context, title: Text(title), content: Text(message));
  }

  /// Returns the title and message for the dialog based on the [CreateStatus].
  (String, String) _getDialogContent(CreateStatus status) {
    switch (status) {
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
    final String gameId = uuid.v4();

    // Collect player names from the text controllers.
    List<String> playerNames = [];
    for (var controller in _playerNameTextControllers) {
      playerNames.add(controller.text);
    }

    // Create a list of Player objects with unique IDs and the corresponding attributes
    List<Player> playerList = [];
    for (int i = 0; i < playerNames.length; i++) {
      String playerId = uuid.v4();
      playerList.add(Player(
        playerId: playerId,
        gameId: gameId,
        name: playerNames[i],
        position: i,
      ));
    }

    final String gameTitle = _gameTitleTextController.text == ''
        ? getFallbackGameTitle()
        : _gameTitleTextController.text;

    final bool isPointsLimitEnabled = gameMode == GameMode.pointLimit;

    GameSession gameSession = GameSession(
        gameId: gameId,
        createdAt: DateTime.now(),
        gameTitle: gameTitle,
        players: playerList,
        pointLimit: ConfigService.getPointLimit(),
        caboPenalty: ConfigService.getCaboPenalty(),
        isPointsLimitEnabled: isPointsLimitEnabled,
        isGameFinished: false);

    gameManager.addGameSession(gameSession);
    final session = gameManager.getGameSessionById(gameId) ?? gameSession;

    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
          builder: (context) => ActiveGameView(gameSession: session)),
      (Route<dynamic> route) => route.isFirst,
    );
  }

  /// If the keyboard is visible, this method will unfocus the current text field
  /// to prevent the keyboard from interfering with the navigation bar.
  Future<void> _keyboardDelay() async {
    if (!KeyboardVisibilityController().isVisible) {
      return;
    } else {
      FocusScope.of(context).unfocus();
      await Future.delayed(
          const Duration(milliseconds: Constants.kKeyboardDelay));
    }
  }

  /// Generates a fallback game title based on the current date and locale.
  /// If the user does not provide a game title, this method will create one
  /// using the current date formatted according to the user's locale.
  String getFallbackGameTitle() {
    final now = DateTime.now();
    final String formattedDate;

    Locale currentLocale = Localizations.localeOf(context);
    switch (currentLocale.languageCode) {
      case 'en':
        formattedDate = DateFormat('MMMM d, y', 'en_US').format(now);
      default:
        formattedDate = DateFormat('dd.MM.yy').format(now);
    }

    return AppLocalizations.of(context).standard_game_title(formattedDate);
  }

  @override
  void dispose() {
    _gameTitleTextController.dispose();
    for (var controller in _playerNameTextControllers) {
      controller.dispose();
    }
    for (var focusnode in _playerNameFocusNodes) {
      focusnode.dispose();
    }

    super.dispose();
  }
}
