import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/data/dto/player.dart';
import 'package:cabo_counter/data/dto/round.dart';
import 'package:drift/drift.dart';

part 'game_session_dao.g.dart';

@DriftAccessor(tables: [GameSessionTable])
class GameSessionDao extends DatabaseAccessor<AppDatabase>
    with _$GameSessionDaoMixin {
  GameSessionDao(super.db);

  /// Retrieves a game session by its ID.
  /// This method fetches the game session details from the `gameSessionTable`,
  /// along with associated players and rounds from their respective DAOs.
  /// It constructs and returns a `GameSession` object containing all relevant data.
  /// [gameId] The ID of the game session to retrieve.
  Future<GameSession> getGameSession(String gameId) async {
    final query = select(gameSessionTable)..where((tbl) => tbl.id.equals(gameId));
    final gameSessionResult = await query.getSingle();

    List<Player> playerList = await db.playerDao.getPlayersByGameId(gameId);
    List<Round> roundList = await db.roundsDao.getRoundsByGameId(gameId);

    GameSession gameSession = GameSession(
        gameId: gameSessionResult.id,
        createdAt: gameSessionResult.createdAt,
        gameTitle: gameSessionResult.gameTitle,
        players: playerList,
        pointLimit: gameSessionResult.pointLimit,
        caboPenalty: gameSessionResult.caboPenalty,
        isPointsLimitEnabled: gameSessionResult.isPointsLimitEnabled,
        isGameFinished: gameSessionResult.isGameFinished,
        winner: gameSessionResult.winner ?? '',
        roundNumber: gameSessionResult.roundNumber,
        roundList: roundList);

    return gameSession;
  }

  /// Retrieves all game sessions from the database.
  /// This method fetches all entries from the `gameSessionTable`,
  /// along with associated players and rounds for each session from their respective DAOs.
  /// It constructs and returns a list of `GameSession` objects containing all relevant data.
  /// Returns an empty list if no game sessions are found.
  /// Returns a [List] of [GameSession] objects.
  Future<List<GameSession>> getAllGameSessions() async {
    final query = select(gameSessionTable);
    final gameSessionResults = await query.get();

    List<GameSession> gameSessions = await Future.wait(
      gameSessionResults.map((row) async {
        List<Player> playerList = await db.playerDao.getPlayersByGameId(row.id);
        List<Round> roundList = await db.roundsDao.getRoundsByGameId(row.id);

        return GameSession(
          gameId: row.id,
          createdAt: row.createdAt,
          gameTitle: row.gameTitle,
          players: playerList,
          pointLimit: row.pointLimit,
          caboPenalty: row.caboPenalty,
          isPointsLimitEnabled: row.isPointsLimitEnabled,
          isGameFinished: row.isGameFinished,
          winner: row.winner ?? '',
          roundNumber: row.roundNumber,
          roundList: roundList,
        );
      }),
    );

    return gameSessions;
  }

  Future<void> insertGameSession(GameSession gameSession) async {
    await into(gameSessionTable).insert(
      GameSessionTableCompanion.insert(
        id: gameSession.gameId,
        createdAt: gameSession.createdAt,
        gameTitle: gameSession.gameTitle,
        pointLimit: gameSession.pointLimit,
        caboPenalty: gameSession.caboPenalty,
        isPointsLimitEnabled: gameSession.isPointsLimitEnabled,
        isGameFinished: gameSession.isGameFinished,
        winner: Value(gameSession.winner),
        roundNumber: gameSession.roundNumber,
      ),
    );

    db.playerDao.insertPlayers(gameSession.gameId, gameSession.players);

    db.roundsDao.insertMultipleRounds(
        gameSession.gameId, gameSession.roundList, gameSession.players);
  }

  /// Updates the game finish status of a specific game session.
  /// This method updates the [isGameFinished] field in the [gameSessionTable]
  /// for the game session with the given [gameId].
  /// [gameId] The ID of the game session to update.
  /// [isFinished] The new finish status to set.
  Future<void> setGameFinishStatus(String gameId, bool isFinished) async {
    await (update(gameSessionTable)..where((tbl) => tbl.id.equals(gameId)))
        .write(GameSessionTableCompanion(
      isGameFinished: Value(isFinished),
    ));
  }
}
