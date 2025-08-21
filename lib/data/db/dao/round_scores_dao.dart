import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/db/tables/round_scores_table.dart';
import 'package:cabo_counter/data/dto/round_score.dart';
import 'package:drift/drift.dart';

part 'round_scores_dao.g.dart';

@DriftAccessor(tables: [RoundScoresTable])
class RoundScoresDao extends DatabaseAccessor<AppDatabase>
    with _$RoundScoresDaoMixin {
  RoundScoresDao(super.db);

  /// Retrieves all scores for a specific round by its ID.
  Future<List<RoundScore>> getRoundScoresByRoundId(String roundId) async {
    final query = select(roundScoresTable)
      ..where((tbl) => tbl.roundId.equals(roundId));

    final result = await query.get();

    // Get positions for each player
    final scoresWithPosition = await Future.wait(result.map((row) async {
      final position = await db.playerDao.getPositionByPlayerId(row.playerId);
      return MapEntry(row, position);
    }));

    // Sort rows by position
    scoresWithPosition.sort((a, b) => a.value.compareTo(b.value));

    return scoresWithPosition.map((entry) {
      final row = entry.key;
      return RoundScore(
        roundId: roundId,
        playerId: row.playerId,
        score: row.score,
        scoreUpdate: row.scoreUpdate,
      );
    }).toList();
  }

  Future<List<int>> getScoresByRoundId(String roundId) async {
    List<RoundScore> roundScores = await getRoundScoresByRoundId(roundId);

    return roundScores.map((score) => score.score).toList();
  }

  Future<List<int>> getScoreUpdatesByRoundId(String roundId) async {
    List<RoundScore> roundScores = await getRoundScoresByRoundId(roundId);

    return roundScores.map((score) => score.scoreUpdate).toList();
  }
}
