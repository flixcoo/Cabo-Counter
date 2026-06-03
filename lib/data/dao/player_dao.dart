import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/db/tables/player_table.dart';
import 'package:cabo_counter/data/dto/player.dart';
import 'package:drift/drift.dart';

part 'player_dao.g.dart';

@DriftAccessor(tables: [PlayerTable])
class PlayerDao extends DatabaseAccessor<AppDatabase> with _$PlayerDaoMixin {
  PlayerDao(super.db);

  /// Retrieves all players from a game by gameId
  Future<List<Player>> getPlayersByGameId({required String gameId}) async {
    final query = select(playerTable)
      ..where((tbl) => tbl.gameId.equals(gameId));
    final playerResults = await query.get();

    return playerResults.map((row) {
      return Player(
        playerId: row.playerId,
        gameId: row.gameId,
        name: row.name,
        position: row.position,
        totalScore: row.totalScore,
      );
    }).toList()..sort((a, b) => a.position.compareTo(b.position));
  }

  /// Retrieves a players position by its id
  Future<int> getPositionByPlayerId(String playerId) async {
    final query = select(playerTable)
      ..where((tbl) => tbl.playerId.equals(playerId));
    final result = await query.getSingle();

    return result.position;
  }

  /// Inserts a new player into the database.
  Future<void> insertPlayers({
    required String gameId,
    required List<Player> players,
  }) async {
    await batch((batch) {
      for (int i = 0; i < players.length; i++) {
        batch.insert(
          playerTable,
          PlayerTableCompanion.insert(
            playerId: players[i].playerId,
            gameId: gameId,
            name: players[i].name,
            position: i,
            totalScore: players[i].totalScore,
          ),
        );
      }
    });
  }

  /// Updates the total scores of multiple players in a batch operation.
  Future<void> updatePlayerScores({required List<Player> players}) async {
    batch((batch) {
      for (int i = 0; i < players.length; i++) {
        final player = players[i];
        final updatedScore = players[i].totalScore;
        batch.update(
          playerTable,
          PlayerTableCompanion(totalScore: Value(updatedScore)),
          where: (tbl) => tbl.playerId.equals(player.playerId),
        );
      }
    });
  }
}
