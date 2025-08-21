import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/db/tables/rounds_table.dart';
import 'package:cabo_counter/data/dto/round.dart';
import 'package:drift/drift.dart';

part 'rounds_dao.g.dart';

@DriftAccessor(tables: [RoundsTable])
class RoundsDao extends DatabaseAccessor<AppDatabase> with _$RoundsDaoMixin {
  RoundsDao(super.db);

  /// Retrieves all rounds for a specific game session by its ID.
  Future<List<Round>> getRoundsByGameId(String gameId) async {
    final query = select(roundsTable)
      ..where((tbl) => tbl.gameId.equals(gameId));

    final roundResult = await query.get();

    final roundList = await Future.wait(
      roundResult.map((row) async {
        final scores = await db.roundScoresDao.getScoresByRoundId(row.roundId);
        final roundScores =
            await db.roundScoresDao.getScoreUpdatesByRoundId(row.roundId);

        return Round(
          roundId: row.roundId,
          gameId: row.gameId,
          roundNum: row.roundNumber,
          caboPlayerIndex: row.caboPlayerIndex,
          kamikazePlayerIndex: row.kamikazePlayerIndex,
          scores: scores,
          scoreUpdates: roundScores,
        );
      }),
    );

    return roundList;
  }
}
