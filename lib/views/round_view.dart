import 'package:cabo_counter/data_classes/game_session.dart';
import 'package:cabo_counter/utility/styles.dart';
import 'package:flutter/cupertino.dart';

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
  late final List<bool> _isKamikazeChecked =
      List.filled(widget.gameSession.players.length, false);
  late final List<TextEditingController> _pointControllers =
      List.filled(widget.gameSession.players.length, TextEditingController());
  late final List<bool> _hasSaidCabo =
      List.filled(widget.gameSession.players.length, false);
  @override
  void initState() {
    super.initState();
    print('Runde ${widget.roundNumber} geöffnet');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Styles.backgroundColor,
        navigationBar: const CupertinoNavigationBar(
          transitionBetweenRoutes: true,
          middle: Text('Ergebnisse'),
          previousPageTitle: 'Zurück',
        ),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
              child: Text(
                'Runde ${widget.roundNumber}',
                style: Styles.roundTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: CupertinoListTile(
                title: Row(
                  children: [
                    Text('Name'),
                  ],
                ),
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.gameSession.players.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                              '${widget.gameSession.playerScores[index][widget.roundNumber - 1]} Punkte',
                            ),
                            leading: CupertinoRadio(
                                value: _hasSaidCabo[index],
                                groupValue: _hasSaidCabo,
                                onChanged: (value) {
                                  setState(() {
                                    _hasSaidCabo[index] = true;
                                  });
                                }),
                            trailing: Row(
                              children: [
                                SizedBox(
                                    width: 100,
                                    child: CupertinoTextField(
                                      keyboardType: TextInputType.number,
                                      controller: _pointControllers[index],
                                      placeholder: 'Punkte',
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        widget.gameSession.playerScores[index]
                                                [widget.roundNumber - 1] =
                                            int.parse(value);
                                      },
                                    )),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 50,
                                  child: CupertinoCheckbox(
                                    activeColor: Styles.primaryColor,
                                    tristate: false,
                                    value: _isKamikazeChecked[index],
                                    onChanged: (bool? value) {
                                      print('value: $value');
                                      setState(() {
                                        _isKamikazeChecked[index] = value!;
                                        print(
                                            'Kamikaze checked: ${_isKamikazeChecked[index]}');
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ))));
              },
            ),
          ],
        )));
  }
}
