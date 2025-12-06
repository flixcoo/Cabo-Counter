import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/data/dto/player.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late GameSession gameSession;
  late GameSession gameWithoutPlayers;
  late Player player1;
  late Player player2;
  late Player player3;
  late Player player4;
  late Player player5;
  late Player player6;

  setUp(() {
    database = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        // Recommended for widget tests to avoid test errors.
        closeStreamsSynchronously: true,
      ),
    );
    player1 = Player(
      playerId: 'player1_id',
      gameId: 'test_game_id',
      name: 'Player 1',
      position: 0,
      totalScore: 0,
    );
    player2 = Player(
      playerId: 'player2_id',
      gameId: 'test_game_id',
      name: 'Player 2',
      position: 1,
      totalScore: 0,
    );
    player3 = Player(
      playerId: 'player3_id',
      gameId: 'test_game_id',
      name: 'Player 3',
      position: 2,
      totalScore: 0,
    );
    player4 = Player(
      playerId: 'player4_id',
      gameId: 'test_game_without_players_id',
      name: 'Player 4',
      position: 0,
      totalScore: 0,
    );
    player5 = Player(
      playerId: 'player5_id',
      gameId: 'test_game_without_players_id',
      name: 'Player 5',
      position: 1,
      totalScore: 0,
    );
    player6 = Player(
      playerId: 'player6_id',
      gameId: 'test_game_without_players_id',
      name: 'Player 6',
      position: 2,
      totalScore: 0,
    );
    gameSession = GameSession(
      gameId: 'test_game_id',
      createdAt: DateTime.now(),
      isGameFinished: false,
      gameTitle: 'test game session',
      pointLimit: 100,
      caboPenalty: 5,
      isPointsLimitEnabled: true,
      players: [player1, player2, player3],
    );
    gameWithoutPlayers = GameSession(
      gameId: 'test_game_without_players_id',
      createdAt: DateTime.now(),
      isGameFinished: false,
      gameTitle: 'test game session',
      pointLimit: 100,
      caboPenalty: 5,
      isPointsLimitEnabled: true,
      players: [],
    );
  });
  tearDown(() async {
    await database.close();
  });

  group('Player-Tests', () {
    test('Insert players works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameWithoutPlayers);
      final insertedPlayers = [player4, player5, player6];
      await database.playerDao.insertPlayers(
          gameId: gameWithoutPlayers.gameId, players: insertedPlayers);

      final players = await database.playerDao
          .getPlayersByGameId(gameId: gameWithoutPlayers.gameId);

      expect(players.length, 3);
      final expectedPlayers = [player4, player5, player6];

      for (int i = 0; i < players.length; i++) {
        expect(players[i].playerId, expectedPlayers[i].playerId);
        expect(players[i].gameId, expectedPlayers[i].gameId);
        expect(players[i].name, expectedPlayers[i].name);
        expect(players[i].position, expectedPlayers[i].position);
        expect(players[i].totalScore, expectedPlayers[i].totalScore);
      }
    });

    test('Fetch all players of a game correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      final players = await database.playerDao
          .getPlayersByGameId(gameId: gameSession.gameId);

      expect(players.length, 3);
      final expectedPlayers = [player1, player2, player3];

      for (int i = 0; i < players.length; i++) {
        expect(players[i].playerId, expectedPlayers[i].playerId);
        expect(players[i].gameId, expectedPlayers[i].gameId);
        expect(players[i].name, expectedPlayers[i].name);
        expect(players[i].position, expectedPlayers[i].position);
        expect(players[i].totalScore, expectedPlayers[i].totalScore);
      }
    });

    test('Fetch player position by playerId correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      var position =
          await database.playerDao.getPositionByPlayerId(player1.playerId);

      expect(position, player1.position);

      position =
          await database.playerDao.getPositionByPlayerId(player2.playerId);

      expect(position, player2.position);

      position =
          await database.playerDao.getPositionByPlayerId(player3.playerId);

      expect(position, player3.position);
    });
  });
}
