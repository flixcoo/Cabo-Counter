import 'package:cabo_counter/data_classes/game_session.dart';
import 'package:cabo_counter/utility/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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
  late final List<TextEditingController> _pointControllers = List.generate(
    widget.gameSession.players.length,
    (index) => TextEditingController(),
  );
  int _caboPlayerIndex = 0;
  late GameSession gameSession = widget.gameSession;
  late final List<FocusNode> _focusNodes = List.generate(
    widget.gameSession.players.length,
    (index) => FocusNode(),
  ); // Neue FocusNodes-Liste

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
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 50),
              child: Text(
                'Runde ${widget.roundNumber}',
                style: Styles.roundTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text('Wer hat CABO gesagt?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: gameSession.players.length > 3 ? 5 : 20,
                  vertical: 10),
              child: SizedBox(
                height: 40,
                child: CupertinoSegmentedControl<int>(
                  groupValue: _caboPlayerIndex,
                  children: Map<int, Widget>.fromIterable(
                    widget.gameSession.players.asMap().keys,
                    value: (index) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: gameSession.players.length > 3 ? 7 : 15,
                      ),
                      child: Text(
                        widget.gameSession.players[index],
                        style: TextStyle(
                            fontSize: gameSession.players.length > 3 ? 14 : 16),
                      ),
                    ),
                  ),
                  onValueChanged: (int value) {
                    setState(() {
                      _caboPlayerIndex = value;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              child: CupertinoListTile(
                title: Text('Spieler:in'),
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
            Expanded(
                child: ListView.builder(
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
                            trailing: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: CupertinoTextField(
                                    maxLength: 3,
                                    focusNode: _focusNodes[index],
                                    //keyboardType:
                                    //    TextInputType.numberWithOptions(
                                    //        signed: false, decimal: false),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                      signed: true,
                                      decimal: false,
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    textInputAction: index ==
                                            widget.gameSession.players.length -
                                                1
                                        ? TextInputAction.done
                                        : TextInputAction.next,
                                    controller: _pointControllers[index],
                                    placeholder: 'Punkte',
                                    textAlign: TextAlign.center,
                                    // 👇 Action-Typ explizit setzen

                                    onSubmitted: (_) => _nextField(index),
                                  ),
                                ),
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
            )),
          ],
        )));
  }

  void _nextField(int index) {
    if (index < widget.gameSession.players.length - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else {
      _focusNodes[index].unfocus();
    }
  }
}
