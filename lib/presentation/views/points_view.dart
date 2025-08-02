import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PointsView extends StatefulWidget {
  final GameSession gameSession;

  const PointsView({super.key, required this.gameSession});

  @override
  State<PointsView> createState() => _PointsViewState();
}

class _PointsViewState extends State<PointsView> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(AppLocalizations.of(context).point_overview),
          previousPageTitle: AppLocalizations.of(context).back,
        ),
        child: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final int columnCount = 1 + widget.gameSession.players.length;
          final double columnWidth = constraints.maxWidth / columnCount;

          return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DataTable(
                    dataRowMaxHeight: 60,
                    dataRowMinHeight: 60,
                    columnSpacing: 0,
                    columns: [
                      const DataColumn(
                        label: SizedBox(
                          width: 18,
                          child: Text(
                            '#',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        numeric: true,
                      ),
                      ...widget.gameSession.players.map(
                        (player) => DataColumn(
                          label: SizedBox(
                            width: columnWidth,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                player,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      ...List<DataRow>.generate(
                        widget.gameSession.roundList.length,
                        (roundIndex) {
                          final round =
                              widget.gameSession.roundList[roundIndex];
                          return DataRow(
                            cells: [
                              DataCell(Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${roundIndex + 1}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              )),
                              ...List.generate(
                                  widget.gameSession.players.length,
                                  (playerIndex) {
                                final int score = round.scores[playerIndex];
                                final int update =
                                    round.scoreUpdates[playerIndex];
                                final bool saidCabo =
                                    round.caboPlayerIndex == playerIndex;
                                return DataCell(
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: update <= 0
                                                ? CustomTheme.pointLossColor
                                                : CustomTheme.pointGainColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            '${update >= 0 ? '+' : ''}$update',
                                            style: const TextStyle(
                                              color: CupertinoColors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text('$score',
                                            style: TextStyle(
                                              decorationThickness: 1,
                                              decoration: saidCabo
                                                  ? TextDecoration.underline
                                                  : TextDecoration.none,
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
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          )),
                          ...widget.gameSession.playerScores.map(
                            (score) => DataCell(
                              Center(
                                child: Text(
                                  '$score',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        })));
  }
}
