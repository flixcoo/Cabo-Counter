import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PointOverviewView extends StatefulWidget {
  final GameSession gameSession;

  const PointOverviewView({super.key, required this.gameSession});

  @override
  State<PointOverviewView> createState() => _PointOverviewViewState();
}

class _PointOverviewViewState extends State<PointOverviewView> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Punkte-Übersicht'),
          previousPageTitle: AppLocalizations.of(context).back,
        ),
        child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: DataTable(
                dataRowMinHeight: 60,
                dataRowMaxHeight: 60,
                dividerThickness: 0.5,
                columnSpacing: 20,
                columns: [
                  const DataColumn(label: Text('#')),
                  ...widget.gameSession.players.map(
                    (player) => DataColumn(label: Text(player)),
                  ),
                ],
                rows: List<DataRow>.generate(
                  widget.gameSession.roundList.length,
                  (roundIndex) {
                    final round = widget.gameSession.roundList[roundIndex];
                    return DataRow(
                      cells: [
                        DataCell(Align(
                          alignment: Alignment.center,
                          child: Text(
                            '$roundIndex',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )),
                        ...List.generate(widget.gameSession.players.length,
                            (playerIndex) {
                          final score = round.scores[playerIndex];
                          final update = round.scoreUpdates[playerIndex];
                          return DataCell(
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: update <= 0
                                        ? Colors.green[200]
                                        : Colors.red[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${update >= 0 ? '+' : '-'}$update',
                                    style: TextStyle(
                                      color: update <= 0
                                          ? Colors.green[900]
                                          : Colors.red[900],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text('$score'),
                              ],
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
              ),
            )));
  }
}
