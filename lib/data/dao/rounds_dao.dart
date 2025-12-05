import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/db/tables/round_scores_table.dart';
import 'package:cabo_counter/data/db/tables/rounds_table.dart';
import 'package:cabo_counter/data/dto/player.dart';
import 'package:cabo_counter/data/dto/round.dart';
import 'package:drift/drift.dart';

part 'rounds_dao.g.dart';

@DriftAccessor(tables: [RoundsTable, RoundScoresTable])
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

  /// Retrieves a specific round by its [gameId] and [roundNumber].
  /// Returns null if the round does not exist.
  Future<Round?> getRoundByGameIdAndRoundNumber(
      String gameId, int roundNumber) async {
    final query = select(roundsTable)
      ..where((tbl) =>
          tbl.gameId.equals(gameId) & tbl.roundNumber.equals(roundNumber));
    final roundResult = await query.getSingleOrNull();
    if (roundResult == null) return null;

    final scoreResult = await Future.wait([
      db.roundScoresDao.getScoresByRoundId(roundResult.roundId),
      db.roundScoresDao.getScoreUpdatesByRoundId(roundResult.roundId),
    ]);

    return Round(
      roundId: roundResult.roundId,
      gameId: roundResult.gameId,
      roundNum: roundResult.roundNumber,
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
  /// [players] is the list of players in the game session.
  Future<void> insertOneRound(
      String gameId, Round round, List<Player> players) async {
    final roundEntry = RoundsTableCompanion.insert(
      roundId: round.roundId,
      gameId: gameId,
      roundNumber: round.roundNum,
      caboPlayerIndex: round.caboPlayerIndex,
      kamikazePlayerIndex: Value(round.kamikazePlayerIndex),
    );

    await into(roundsTable).insert(roundEntry);

    for (int i = 0; i < players.length; i++) {
      final player = players[i];
      final roundScoreEntry = RoundScoresTableCompanion.insert(
        roundId: round.roundId,
        playerId: player.playerId,
        score: round.scores[i],
        scoreUpdate: round.scoreUpdates[i],
      );
      await into(roundScoresTable).insert(roundScoreEntry);
    }
  }

  /// Replaces an already existing round with a new one.
  /// [gameId] is the ID of the game session this round belongs to.
  /// [round] is the round data to be inserted.
  /// [players] is the list of players in the game session.
  Future<void> replaceRound(
      String gameId, Round round, List<Player> players) async {
    await deleteRound(gameId, round.roundNum);

    await insertOneRound(gameId, round, players);
  }

  /// Inserts multiple rounds into the database.
  /// This method uses a batch operation to insert all rounds and their scores
  /// in a single transaction.
  /// [gameId] is the ID of the game session these rounds belong to.
  /// [rounds] is the list of rounds to be inserted.
  /// [players] is the list of players in the game session.
  Future<void> insertMultipleRounds(
      String gameId, List<Round> rounds, List<Player> players) async {
    await batch((batch) {
      final roundEntries = <RoundsTableCompanion>[];
      final roundScoreEntries = <RoundScoresTableCompanion>[];

      for (final round in rounds) {
        roundEntries.add(RoundsTableCompanion.insert(
          roundId: round.roundId,
          gameId: gameId,
          roundNumber: round.roundNum,
          caboPlayerIndex: round.caboPlayerIndex,
          kamikazePlayerIndex: Value(round.kamikazePlayerIndex),
        ));

        for (int i = 0; i < players.length; i++) {
          roundScoreEntries.add(RoundScoresTableCompanion.insert(
            roundId: round.roundId,
            playerId: players[i].playerId,
            score: round.scores[i],
            scoreUpdate: round.scoreUpdates[i],
          ));
        }
      }

      batch.insertAll(roundsTable, roundEntries);
      batch.insertAll(roundScoresTable, roundScoreEntries);
    });
  }

  /// Deletes a specific round by its [gameId] and [roundNumber].
  /// Returns true if the round was found and deleted, false otherwise.
  /// Also deletes all associated scores due to foreign key constraints.
  /// [gameId] is the ID of the game session this round belongs to.
  /// [roundNumber] is the number of the round to be deleted.
  Future<bool> deleteRound(String gameId, int roundNumber) async {
    final query = select(roundsTable)
      ..where((tbl) =>
          tbl.gameId.equals(gameId) & tbl.roundNumber.equals(roundNumber));
    final roundResult = await query.getSingleOrNull();
    if (roundResult == null) return false;

    final deleteQuery = delete(roundsTable)
      ..where((tbl) =>
          tbl.gameId.equals(gameId) & tbl.roundNumber.equals(roundNumber));
    await deleteQuery.go();
    return true;
  }
}
