import 'package:cabo_counter/core/custom_theme.dart';
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
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context).table),
        previousPageTitle: AppLocalizations.of(context).back,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DataTable(
            dataRowMinHeight: 60,
            dataRowMaxHeight: 60,
            dividerThickness: 0.5,
            columnSpacing: 20,
            columns: [
              const DataColumn(
                  numeric: true,
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text(
                    '#',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  columnWidth: IntrinsicColumnWidth(flex: 0.5)),
              ...widget.gameSession.players.map(
                (player) => DataColumn(
                    label: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          player,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                    headingRowAlignment: MainAxisAlignment.center,
                    columnWidth: const IntrinsicColumnWidth(flex: 1)),
              ),
            ],
            rows: [
              ...List<DataRow>.generate(
                widget.gameSession.roundList.length,
                (roundIndex) {
                  final round = widget.gameSession.roundList[roundIndex];
                  return DataRow(
                    cells: [
                      DataCell(Align(
                        alignment: Alignment.center,
                        child: Text(
                          '$roundIndex',
                          style: const TextStyle(fontSize: 20),
                        ),
                      )),
                      ...List.generate(widget.gameSession.players.length,
                          (playerIndex) {
                        final score = round.scores[playerIndex];
                        final update = round.scoreUpdates[playerIndex];
                        final saidCabo =
                            round.caboPlayerIndex == playerIndex ? true : false;
                        return DataCell(
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: update <= 0
                                        ? CustomTheme.primaryColor
                                        : CupertinoColors.destructiveRed,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${update >= 0 ? '+' : '-'}$update',
                                    style: const TextStyle(
                                      color: CupertinoColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text('$score',
                                    style: TextStyle(
                                      fontWeight: saidCabo
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    )),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                },
              ),
              DataRow(
                cells: [
                  const DataCell(Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Σ',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  )),
                  ...widget.gameSession.playerScores.map(
                    (score) => DataCell(
                      Center(
                        child: Text(
                          '$score',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
