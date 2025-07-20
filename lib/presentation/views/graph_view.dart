import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphView extends StatefulWidget {
  final GameSession gameSession;

  const GraphView({super.key, required this.gameSession});

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  /// List of colors for the graph lines.
  final List<Color> lineColors = [
    CustomTheme.graphColor1,
    CustomTheme.graphColor2,
    CustomTheme.graphColor3,
    CustomTheme.graphColor4,
    CustomTheme.graphColor5
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(AppLocalizations.of(context).scoring_history),
          previousPageTitle: AppLocalizations.of(context).back,
        ),
        child: Visibility(
          visible: widget.gameSession.roundNumber > 1 ||
              widget.gameSession.isGameFinished,
          replacement: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Icon(CupertinoIcons.chart_bar_alt_fill, size: 60),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  AppLocalizations.of(context).empty_graph_text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: SfCartesianChart(
              enableAxisAnimation: true,
              legend: const Legend(
                  overflowMode: LegendItemOverflowMode.wrap,
                  isVisible: true,
                  position: LegendPosition.bottom),
              primaryXAxis: const NumericAxis(
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                interval: 1,
                decimalPlaces: 0,
              ),
              primaryYAxis: NumericAxis(
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                labelAlignment: LabelAlignment.center,
                labelPosition: ChartDataLabelPosition.inside,
                interval: 1,
                decimalPlaces: 0,
                axisLabelFormatter: (AxisLabelRenderDetails details) {
                  if (details.value == 0) {
                    return ChartAxisLabel('', const TextStyle());
                  }
                  return ChartAxisLabel(
                      '${details.value.toInt()}', const TextStyle());
                },
              ),
              series: getCumulativeScores(),
            ),
          ),
        ));
  }

  /// Returns a list of LineSeries representing the cumulative scores of each player.
  /// Each series contains data points for each round, showing the cumulative score up to that round.
  /// The x-axis represents the round number, and the y-axis represents the cumulative score.
  List<LineSeries<(int, num), int>> getCumulativeScores() {
    final rounds = widget.gameSession.roundList;
    final playerCount = widget.gameSession.players.length;
    final playerNames = widget.gameSession.players;

    List<List<int>> cumulativeScores = List.generate(playerCount, (_) => []);
    List<int> runningTotals = List.filled(playerCount, 0);

    for (var round in rounds) {
      for (int i = 0; i < playerCount; i++) {
        runningTotals[i] += round.scoreUpdates[i];
        cumulativeScores[i].add(runningTotals[i]);
      }
    }

    const double jitterStep = 0.03;

    /// Create a list of LineSeries for each player
    /// Each series contains data points for each round
    return List.generate(playerCount, (i) {
      final data = List.generate(
        cumulativeScores[i].length + 1,
        (j) => (
          j,
          j == 0 || cumulativeScores[i][j - 1] == 0
              ? 0 // 0 points at the start of the game or when the value is 0 (don't subtract jitter step)

              // Adds a small jitter to the cumulative scores to prevent overlapping data points in the graph.
              // The jitter is centered around zero by subtracting playerCount ~/ 2 from the player index i.
              : cumulativeScores[i][j - 1] + (i - playerCount ~/ 2) * jitterStep
        ),
      );

      /// Create a LineSeries for the player
      /// The xValueMapper maps the round number, and the yValueMapper maps the cumulative score.
      return LineSeries<(int, num), int>(
        name: playerNames[i],
        dataSource: data,
        xValueMapper: (record, _) => record.$1,
        yValueMapper: (record, _) => record.$2,
        markerSettings: const MarkerSettings(isVisible: true),
        color: lineColors[i],
      );
    });
  }
}
