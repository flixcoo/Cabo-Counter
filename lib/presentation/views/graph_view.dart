import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphView extends StatefulWidget {
  final GameSession gameSession;

  const GraphView({super.key, required this.gameSession});

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  /// List of colors for the graph lines.
  List<Color> lineColors = [
    Colors.red,
    Colors.blue,
    Colors.orange.shade400,
    Colors.purple,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context).game_process),
        previousPageTitle: AppLocalizations.of(context).back,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: SfCartesianChart(
          legend:
              const Legend(isVisible: true, position: LegendPosition.bottom),
          primaryXAxis: const NumericAxis(),
          primaryYAxis: const NumericAxis(),
          series: getCumulativeScores(),
        ),
      ),
    );
  }

  /// Returns a list of LineSeries representing the cumulative scores of each player.
  /// Each series contains data points for each round, showing the cumulative score up to that round.
  /// The x-axis represents the round number, and the y-axis represents the cumulative score.
  List<LineSeries<(int, int), int>> getCumulativeScores() {
    final rounds = widget.gameSession.roundList;
    final playerCount = widget.gameSession.players.length;
    final playerNames = widget.gameSession.players;

    List<List<int>> cumulativeScores = List.generate(playerCount, (_) => []);
    List<int> runningTotals = List.filled(playerCount, 0);

    for (var round in rounds) {
      for (int i = 0; i < playerCount; i++) {
        runningTotals[i] += round.scores[i];
        cumulativeScores[i].add(runningTotals[i]);
      }
    }

    /// Create a list of LineSeries for each player
    /// Each series contains data points for each round
    return List.generate(playerCount, (i) {
      final data = List.generate(
        cumulativeScores[i].length,
        (j) => (j + 1, cumulativeScores[i][j]), // (round, score)
      );

      /// Create a LineSeries for the player
      /// The xValueMapper maps the round number, and the yValueMapper maps the cumulative score.
      return LineSeries<(int, int), int>(
        name: playerNames[i],
        dataSource: data,
        xValueMapper: (record, _) => record.$1, // Runde
        yValueMapper: (record, _) => record.$2, // Punktestand
        markerSettings: const MarkerSettings(isVisible: true),
        color: lineColors[i],
      );
    });
  }
}
