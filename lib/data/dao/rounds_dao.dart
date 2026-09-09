import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/db/tables/round_score_table.dart';
import 'package:cabo_counter/data/db/tables/round_table.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:drift/drift.dart';

part 'rounds_dao.g.dart';

@DriftAccessor(tables: [RoundTable, RoundScoreTable])
class RoundsDao extends DatabaseAccessor<AppDatabase> with _$RoundsDaoMixin {
  RoundsDao(super.db);

  /// Retrieves all rounds for a specific game session by its ID.
  /// The rounds are ordered by their round number so that the position of a
  /// round in the returned list matches its round number (index + 1).
  Future<List<Round>> getRoundsByGameId({required String gameId}) async {
    final query = select(roundTable)
      ..where((tbl) => tbl.gameSessionId.equals(gameId))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.roundNumber)]);

    final roundResult = await query.get();

    final roundList = await Future.wait(
      roundResult.map((row) async {
        final scores = await db.roundScoresDao.getScoresByRoundId(
          roundId: row.id,
        );
        final roundScores = await db.roundScoresDao.getScoreUpdatesByRoundId(
          roundId: row.id,
        );

        return Round(
          roundId: row.id,
          gameSessionId: row.gameSessionId,
          caboPlayerIndex: row.caboPlayerIndex,
          kamikazePlayerIndex: row.kamikazePlayerIndex,
          scores: scores,
          scoreUpdates: roundScores,
        );
      }),
    );

    return roundList;
  }

  /// Retrieves a specific round by its [gameId] and [roundNumber].
  /// Returns null if the round does not exist.
  Future<Round?> getRoundByGameIdAndRoundNumber({
    required String gameId,
    required int roundNumber,
  }) async {
    final query = select(roundTable)
      ..where(
        (tbl) =>
            tbl.gameSessionId.equals(gameId) &
            tbl.roundNumber.equals(roundNumber),
      );
    final roundResult = await query.getSingleOrNull();
    if (roundResult == null) return null;

    final scoreResult = await Future.wait([
      db.roundScoresDao.getScoresByRoundId(roundId: roundResult.id),
      db.roundScoresDao.getScoreUpdatesByRoundId(roundId: roundResult.id),
    ]);

    return Round(
      roundId: roundResult.id,
      gameSessionId: roundResult.gameSessionId,
      caboPlayerIndex: roundResult.caboPlayerIndex,
      kamikazePlayerIndex: roundResult.kamikazePlayerIndex,
      scores: scoreResult[0],
      scoreUpdates: scoreResult[1],
    );
  }

  /// Inserts a new round into the database.
  /// This method creates a new round with a unique ID and inserts it
  /// along with the scores for each player in the round.
  /// [gameId] is the ID of the game session this round belongs to.
  /// [round] is the round data to be inserted.
  /// [roundNumber] is the position of the round within the game.
  /// [players] is the list of players in the game session.
  Future<void> insertOneRound({
    required String gameId,
    required Round round,
    required int roundNumber,
    required List<Player> players,
  }) async {
    final roundEntry = RoundTableCompanion.insert(
      id: round.id,
      gameSessionId: gameId,
      roundNumber: roundNumber,
      caboPlayerIndex: round.caboPlayerIndex,
      kamikazePlayerIndex: Value(round.kamikazePlayerIndex),
    );

    await into(roundTable).insert(roundEntry);

    for (int i = 0; i < players.length; i++) {
      final player = players[i];
      final roundScoreEntry = RoundScoreTableCompanion.insert(
        roundId: round.id,
        playerId: player.id,
        score: round.scores[i],
        scoreUpdate: round.scoreUpdates[i],
      );
      await into(roundScoreTable).insert(roundScoreEntry);
    }
  }

  /// Replaces an already existing round with a new one.
  /// [gameId] is the ID of the game session this round belongs to.
  /// [round] is the round data to be inserted.
  /// [roundNumber] is the position of the round within the game.
  /// [players] is the list of players in the game session.
  Future<void> replaceRound({
    required String gameId,
    required Round round,
    required int roundNumber,
    required List<Player> players,
  }) async {
    await deleteRound(gameId: gameId, roundNumber: roundNumber);

    await insertOneRound(
      gameId: gameId,
      round: round,
      roundNumber: roundNumber,
      players: players,
    );
  }

  /// Inserts multiple rounds into the database.
  /// This method uses a batch operation to insert all rounds and their scores
  /// in a single transaction. The round number of each round is derived from
  /// its position in the [rounds] list (index + 1).
  /// [gameSessionId] is the ID of the game session these rounds belong to.
  /// [rounds] is the list of rounds to be inserted.
  /// [players] is the list of players in the game session.
  Future<void> insertMultipleRounds({
    required String gameSessionId,
    required List<Round> rounds,
    required List<Player> players,
  }) async {
    if (rounds.isEmpty) return;
    await batch((batch) {
      final roundEntries = <RoundTableCompanion>[];
      final roundScoreEntries = <RoundScoreTableCompanion>[];

      for (int r = 0; r < rounds.length; r++) {
        final round = rounds[r];
        roundEntries.add(
          RoundTableCompanion.insert(
            id: round.id,
            gameSessionId: gameSessionId,
            roundNumber: r + 1,
            caboPlayerIndex: round.caboPlayerIndex,
            kamikazePlayerIndex: Value(round.kamikazePlayerIndex),
          ),
        );

        for (int i = 0; i < players.length; i++) {
          roundScoreEntries.add(
            RoundScoreTableCompanion.insert(
              roundId: round.id,
              playerId: players[i].id,
              score: round.scores[i],
              scoreUpdate: round.scoreUpdates[i],
            ),
          );
        }
      }

      batch.insertAll(roundTable, roundEntries);
      batch.insertAll(roundScoreTable, roundScoreEntries);
    });
  }

  /// Deletes a specific round by its [gameId] and [roundNumber].
  /// Returns true if the round was found and deleted, false otherwise.
  /// Also deletes all associated scores due to foreign key constraints.
  /// [gameId] is the ID of the game session this round belongs to.
  /// [roundNumber] is the number of the round to be deleted.
  Future<bool> deleteRound({
    required String gameId,
    required int roundNumber,
  }) async {
    final query = select(roundTable)
      ..where(
        (tbl) =>
            tbl.gameSessionId.equals(gameId) &
            tbl.roundNumber.equals(roundNumber),
      );
    final roundResult = await query.getSingleOrNull();
    if (roundResult == null) return false;

    final deleteQuery = delete(roundTable)
      ..where(
        (tbl) =>
            tbl.gameSessionId.equals(gameId) &
            tbl.roundNumber.equals(roundNumber),
      );
    await deleteQuery.go();
    return true;
  }
}
