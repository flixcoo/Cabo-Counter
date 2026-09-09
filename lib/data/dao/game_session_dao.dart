import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:drift/drift.dart';

part 'game_session_dao.g.dart';

@DriftAccessor(tables: [GameSessionTable])
class GameSessionDao extends DatabaseAccessor<AppDatabase>
    with _$GameSessionDaoMixin {
  GameSessionDao(super.db);

  /// Inserts a new game session into the database.
  /// This method takes a [GameSession] object as input and inserts its details
  /// into the [gameSessionTable]. It also inserts associated players and rounds
  /// using the respective DAOs.
  /// [gameSession] The [GameSession] object to insert into the database.
  Future<void> insertGameSession(GameSession gameSession) async {
    await into(gameSessionTable).insert(
      GameSessionTableCompanion.insert(
        id: gameSession.id,
        createdAt: gameSession.createdAt,
        gameTitle: gameSession.title,
        pointLimit: Value(gameSession.pointLimit),
        caboPenalty: gameSession.caboPenalty,
        isGameFinished: gameSession.isGameFinished,
      ),
    );

    await db.playerDao.insertPlayers(
      gameId: gameSession.id,
      players: gameSession.players,
    );

    await db.roundsDao.insertMultipleRounds(
      gameSessionId: gameSession.id,
      rounds: gameSession.roundList,
      players: gameSession.players,
    );
  }

  /// Retrieves all game sessions from the database.
  /// This method fetches all entries from the `gameSessionTable`,
  /// along with associated players and rounds for each session from their respective DAOs.
  /// It constructs and returns a list of `GameSession` objects containing all relevant data.
  /// Returns 'null' if no game sessions are found.
  /// Returns a [List] of [GameSession] objects.
  Future<List<GameSession>> getAllGameSessions() async {
    final query = select(gameSessionTable);
    final gameSessionResults = await query.get();
    if (gameSessionResults.isEmpty) return [];

    List<GameSession> gameSessions = await Future.wait(
      gameSessionResults.map((row) async {
        List<Player> playerList = await db.playerDao.getPlayersByGameId(
          gameId: row.id,
        );
        List<Round> roundList = await db.roundsDao.getRoundsByGameId(
          gameId: row.id,
        );

        return GameSession(
          id: row.id,
          createdAt: row.createdAt,
          title: row.gameTitle,
          players: playerList,
          pointLimit: row.pointLimit,
          caboPenalty: row.caboPenalty,
          isGameFinished: row.isGameFinished,
          roundList: roundList,
        );
      }),
    );

    return gameSessions;
  }

  /// Retrieves a game session by its ID.
  /// This method fetches the game session details from the `gameSessionTable`,
  /// along with associated players and rounds from their respective DAOs.
  /// It constructs and returns a `GameSession` object containing all relevant data.
  /// [gameSessionId] The ID of the game session to retrieve.
  Future<GameSession?> getGameSession({required String gameSessionId}) async {
    final query = select(gameSessionTable)
      ..where((tbl) => tbl.id.equals(gameSessionId));
    final gameSessionResult = await query.getSingleOrNull();
    if (gameSessionResult == null) {
      return null;
    }

    List<Player> playerList = await db.playerDao.getPlayersByGameId(
      gameId: gameSessionId,
    );
    List<Round> roundList = await db.roundsDao.getRoundsByGameId(
      gameId: gameSessionId,
    );

    GameSession gameSession = GameSession(
      id: gameSessionResult.id,
      createdAt: gameSessionResult.createdAt,
      title: gameSessionResult.gameTitle,
      players: playerList,
      pointLimit: gameSessionResult.pointLimit,
      caboPenalty: gameSessionResult.caboPenalty,
      isGameFinished: gameSessionResult.isGameFinished,
      roundList: roundList,
    );

    return gameSession;
  }

  /// Deletes the game session with the given [gameSessionId].
  /// Returns `true` if the deletion was successful, `false` otherwise.
  Future<bool> deleteGameSession({required String gameSessionId}) async {
    final rowsAffected = await (delete(
      gameSessionTable,
    )..where((tbl) => tbl.id.equals(gameSessionId))).go();
    return rowsAffected > 0;
  }

  /// Deletes all game sessions from the database.
  /// This method removes all entries from the [gameSessionTable].
  /// Returns the number of deleted rows.
  Future<int> deleteAllGames() async {
    return await delete(gameSessionTable).go();
  }

  /// Updates the game finish status of a specific game session.
  /// This method updates the [isGameFinished] field in the [gameSessionTable]
  /// for the game session with the given [gameId].
  /// [gameId] The ID of the game session to update.
  /// [isFinished] The new finish status to set.
  Future<void> setGameFinishStatus({
    required String gameId,
    required bool isFinished,
  }) async {
    await (update(gameSessionTable)..where((tbl) => tbl.id.equals(gameId)))
        .write(GameSessionTableCompanion(isGameFinished: Value(isFinished)));
  }

  /// Ends a game session by marking it as finished.
  /// [gameId] The ID of the game session to end.
  Future<void> endGame({required String gameId}) async {
    await (update(gameSessionTable)..where((tbl) => tbl.id.equals(gameId)))
        .write(const GameSessionTableCompanion(isGameFinished: Value(true)));
  }
}
