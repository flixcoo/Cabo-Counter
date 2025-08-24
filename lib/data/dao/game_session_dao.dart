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
  Future<GameSession> getGameSession(String id) async {
    final query = select(gameSessionTable)..where((tbl) => tbl.id.equals(id));
    final gameSessionResult = await query.getSingle();

    List<Player> playerList = await db.playerDao.getPlayersByGameId(id);
    List<Round> roundList = await db.roundsDao.getRoundsByGameId(id);

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
}
