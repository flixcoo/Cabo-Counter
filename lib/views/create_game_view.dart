import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/utility/styles.dart';
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
  final int maxPlayers = 5;
  String? selectedMode; // Variable für den ausgewählten Spielmodus

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Übersicht',
          middle: const Text('Neues Spiel'),
        ),
        child: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                'Spiel',
                style: Styles.createGameTitle,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: CupertinoTextField(
                decoration: BoxDecoration(),
                maxLength: 8,
                prefix: Text('Name'),
                textAlign: TextAlign.right,
                placeholder: 'Titel des Spiels',
                controller: _gameTitleTextController,
              ),
            ),
            // Spielmodus-Auswahl mit Chevron
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: CupertinoTextField(
                decoration: BoxDecoration(),
                readOnly: true,
                prefix: Text('Modus'),
                suffix: Row(
                  children: [
                    Text(
                      selectedMode ?? 'Wähle einen Modus',
                    ),
                    SizedBox(width: 3),
                    CupertinoListTileChevron(),
                  ],
                ),
                onTap: () async {
                  // Öffne das Modus-Auswahlmenü
                  final selected = await Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ModeSelectionMenu(),
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
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                'Spieler:innen',
                style: Styles.createGameTitle,
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
                          children: const [
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
                                title: Text('Maximale Spielerzahl erreicht'),
                                content: Text(
                                    'Es können maximal 5 Spieler hinzugefügt '
                                    'werden.'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('OK'),
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
                            child: Icon(
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
                              decoration: BoxDecoration(),
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
                  children: const [
                    Text(
                      'Spiel erstellen ',
                      style: TextStyle(
                        color: CupertinoColors.activeGreen,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  if (_gameTitleTextController.text == '') {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text('Fehler'),
                        content:
                            Text('Es muss ein Titel für das Spiel eingegeben '
                                'werden.'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('OK'),
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
                        title: Text('Fehler'),
                        content:
                            Text('Es muss ein Spielmodus ausgewählt werden.'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('OK'),
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
                        title: Text('Fehler'),
                        content:
                            Text('Es müssen mindestens 2 Spieler hinzugefügt '
                                'werden.'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('OK'),
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
                        title: Text('Fehler'),
                        content: Text('Jeder Spieler muss einen Namen haben.'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                    return;
                  }

                  List<String> players = [];
                  for (var controller in _playerNameTextControllers) {
                    players.add(controller.text);
                  }
                  GameSession gameSession = GameSession(
                    gameTitle: _gameTitleTextController.text,
                    players: players,
                    winner: players[0],
                    gameMode: selectedMode == '101 Pkt.' ? 0 : 1,
                  );
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              ActiveGameView(gameSession: gameSession)));
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
