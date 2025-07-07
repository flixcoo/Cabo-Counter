import 'package:cabo_counter/data/game_manager.dart';
import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/l10n/app_localizations.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:cabo_counter/views/active_game_view.dart';
import 'package:cabo_counter/views/mode_selection_view.dart';
import 'package:flutter/cupertino.dart';

enum CreateStatus {
  noGameTitle,
  noModeSelected,
  minPlayers,
  maxPlayers,
  noPlayerName,
}

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
                              ? '${ConfigService.pointLimit} ${AppLocalizations.of(context).points}'
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
                        pointLimit: ConfigService.pointLimit,
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
              child: ListView.builder(
                itemCount: _playerNameTextControllers.length +
                    1, // +1 für den + Button
                itemBuilder: (context, index) {
                  if (index == _playerNameTextControllers.length) {
                    // + Button als letztes Element
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              CupertinoIcons.add_circled,
                              color: CupertinoColors.activeGreen,
                              size: 25,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context).add_player,
                              style: const TextStyle(
                                color: CupertinoColors.activeGreen,
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
                            showFeedbackDialog(CreateStatus.maxPlayers);
                          }
                        },
                      ),
                    );
                  } else {
                    // Spieler-Einträge
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 5),
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
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            Center(
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).create_game,
                      style: const TextStyle(
                        color: CupertinoColors.activeGreen,
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  if (_gameTitleTextController.text == '') {
                    showFeedbackDialog(CreateStatus.noGameTitle);
                    return;
                  }
                  if (_isPointsLimitEnabled == null) {
                    showFeedbackDialog(CreateStatus.noModeSelected);
                    return;
                  }
                  if (_playerNameTextControllers.length < 2) {
                    showFeedbackDialog(CreateStatus.minPlayers);
                    return;
                  }
                  if (!everyPlayerHasAName()) {
                    showFeedbackDialog(CreateStatus.noPlayerName);
                    return;
                  }

                  List<String> players = [];
                  for (var controller in _playerNameTextControllers) {
                    players.add(controller.text);
                  }
                  GameSession gameSession = GameSession(
                    createdAt: DateTime.now(),
                    gameTitle: _gameTitleTextController.text,
                    players: players,
                    pointLimit: ConfigService.pointLimit,
                    caboPenalty: ConfigService.caboPenalty,
                    isPointsLimitEnabled: _isPointsLimitEnabled!,
                  );
                  final index = await gameManager.addGameSession(gameSession);
                  final session = gameManager.gameList[index];
                  if (context.mounted) {
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                ActiveGameView(gameSession: session)));
                  }
                },
              ),
            ),
          ],
        ))));
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

  @override
  void dispose() {
    _gameTitleTextController.dispose();
    for (var controller in _playerNameTextControllers) {
      controller.dispose();
    }

    super.dispose();
  }
}
