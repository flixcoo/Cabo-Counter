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
        id: gameSessionResult.id,
        createdAt: gameSessionResult.createdAt,
        gameTitle: gameSessionResult.gameTitle,
        players: playerList.map((player) => player.name).toList(),
        pointLimit: gameSessionResult.pointLimit,
        caboPenalty: gameSessionResult.caboPenalty,
        isPointsLimitEnabled: gameSessionResult.isPointsLimitEnabled,
        isGameFinished: gameSessionResult.isGameFinished,
        winner: gameSessionResult.winner ?? '',
        roundNumber: gameSessionResult.roundNumber,
        playerScores: playerList.map((player) => player.totalScore).toList(),
        roundList: roundList);

    return gameSession;
  }
}
