import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:cabo_counter/utility/globals.dart';
import 'package:cabo_counter/views/active_game_view.dart';
import 'package:cabo_counter/views/mode_selection_view.dart';
import 'package:flutter/cupertino.dart';

class CreateGame extends StatefulWidget {
  const CreateGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  final List<TextEditingController> _playerNameTextControllers = [
    TextEditingController()
  ];
  final TextEditingController _gameTitleTextController =
      TextEditingController();

  /// Maximum number of players allowed in the game.
  final int maxPlayers = 5;

  /// Variable to store the selected game mode.
  bool? selectedMode;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          previousPageTitle: 'Übersicht',
          middle: Text('Neues Spiel'),
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
                'Spiel',
                style: CustomTheme.createGameTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
              child: CupertinoTextField(
                decoration: const BoxDecoration(),
                maxLength: 16,
                prefix: const Text('Name'),
                textAlign: TextAlign.right,
                placeholder: 'Titel des Spiels',
                controller: _gameTitleTextController,
              ),
            ),
            // Spielmodus-Auswahl mit Chevron
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
              child: CupertinoTextField(
                decoration: const BoxDecoration(),
                readOnly: true,
                prefix: const Text('Modus'),
                suffix: Row(
                  children: [
                    Text(
                      selectedMode == null
                          ? 'Wähle einen Modus'
                          : (selectedMode! ? '101 Punkte' : 'Unbegrenzt'),
                    ),
                    const SizedBox(width: 3),
                    const CupertinoListTileChevron(),
                  ],
                ),
                onTap: () async {
                  // Öffne das Modus-Auswahlmenü
                  final selected = await Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const ModeSelectionMenu(),
                    ),
                  );

                  // Aktualisiere den ausgewählten Modus
                  if (selected != null) {
                    setState(() {
                      selectedMode = selected;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                'Spieler:innen',
                style: CustomTheme.createGameTitle,
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.add_circled,
                              color: CupertinoColors.activeGreen,
                              size: 25,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Spieler hinzufügen',
                              style: TextStyle(
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
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title:
                                    const Text('Maximale Spielerzahl erreicht'),
                                content: const Text(
                                    'Es können maximal 5 Spieler hinzugefügt '
                                    'werden.'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
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
                              placeholder: 'Spieler:in ${index + 1}',
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Spiel erstellen ',
                      style: TextStyle(
                        color: CupertinoColors.activeGreen,
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  if (_gameTitleTextController.text == '') {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Fehler'),
                        content: const Text(
                            'Es muss ein Titel für das Spiel eingegeben '
                            'werden.'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  if (selectedMode == null) {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Fehler'),
                        content: const Text(
                            'Es muss ein Spielmodus ausgewählt werden.'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  if (_playerNameTextControllers.length < 2) {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Fehler'),
                        content: const Text(
                            'Es müssen mindestens 2 Spieler hinzugefügt '
                            'werden.'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  if (!everyPlayerHasAName()) {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Fehler'),
                        content:
                            const Text('Jeder Spieler muss einen Namen haben.'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  }

                  List<String> players = [];
                  for (var controller in _playerNameTextControllers) {
                    players.add(controller.text);
                  }
                  GameSession gameSession = GameSession(
                    createdAt: DateTime.now(),
                    gameTitle: _gameTitleTextController.text,
                    players: players,
                    pointLimit: await ConfigService.getPointLimit(),
                    caboPenalty: await ConfigService.getCaboPenalty(),
                    isPointsLimitEnabled: selectedMode!,
                  );
                  Globals.addGameSession(gameSession);
                  LocalStorageService.saveGameSessions();
                  if (context.mounted) {
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                ActiveGameView(gameSession: gameSession)));
                  } else {
                    print('Context is not mounted');
                  }
                },
              ),
            ),
          ],
        ))));
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
    for (var controller in _playerNameTextControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
