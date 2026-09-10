import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/data/models/player.dart';
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
      id: 'player1_id',
      gameSessionId: 'test_game_id',
      name: 'Player 1',
      position: 0,
      totalScore: 0,
    );
    player2 = Player(
      id: 'player2_id',
      gameSessionId: 'test_game_id',
      name: 'Player 2',
      position: 1,
      totalScore: 0,
    );
    player3 = Player(
      id: 'player3_id',
      gameSessionId: 'test_game_id',
      name: 'Player 3',
      position: 2,
      totalScore: 0,
    );
    player4 = Player(
      id: 'player4_id',
      gameSessionId: 'test_game_without_players_id',
      name: 'Player 4',
      position: 0,
      totalScore: 0,
    );
    player5 = Player(
      id: 'player5_id',
      gameSessionId: 'test_game_without_players_id',
      name: 'Player 5',
      position: 1,
      totalScore: 0,
    );
    player6 = Player(
      id: 'player6_id',
      gameSessionId: 'test_game_without_players_id',
      name: 'Player 6',
      position: 2,
      totalScore: 0,
    );
    gameSession = GameSession(
      id: 'test_game_id',
      createdAt: DateTime.now(),
      isGameFinished: false,
      title: 'test game session',
      pointLimit: 100,
      caboPenalty: 5,
      players: [player1, player2, player3],
    );
    gameWithoutPlayers = GameSession(
      id: 'test_game_without_players_id',
      createdAt: DateTime.now(),
      isGameFinished: false,
      title: 'test game session',
      pointLimit: 100,
      caboPenalty: 5,
      players: [],
    );
  });
  tearDown(() async {
    await database.close();
  });

  group('Player-Tests', () {
    test('Insert players works correctly', () async {
      await database.gameSessionDao.addGameSession(gameWithoutPlayers);
      final insertedPlayers = [player4, player5, player6];
      await database.playerDao.addPlayerAsList(
        gameId: gameWithoutPlayers.id,
        players: insertedPlayers,
      );

      final players = await database.playerDao.getPlayersByGameSessionId(
        gameSessionId: gameWithoutPlayers.id,
      );

      expect(players.length, 3);
      final expectedPlayers = [player4, player5, player6];

      for (int i = 0; i < players.length; i++) {
        expect(players[i].id, expectedPlayers[i].id);
        expect(players[i].gameSessionId, expectedPlayers[i].gameSessionId);
        expect(players[i].name, expectedPlayers[i].name);
        expect(players[i].position, expectedPlayers[i].position);
        expect(players[i].totalScore, expectedPlayers[i].totalScore);
      }
    });

    test('Fetch all players of a game correctly', () async {
      await database.gameSessionDao.addGameSession(gameSession);
      final players = await database.playerDao.getPlayersByGameSessionId(
        gameSessionId: gameSession.id,
      );

      expect(players.length, 3);
      final expectedPlayers = [player1, player2, player3];

      for (int i = 0; i < players.length; i++) {
        expect(players[i].id, expectedPlayers[i].id);
        expect(players[i].gameSessionId, expectedPlayers[i].gameSessionId);
        expect(players[i].name, expectedPlayers[i].name);
        expect(players[i].position, expectedPlayers[i].position);
        expect(players[i].totalScore, expectedPlayers[i].totalScore);
      }
    });

    test('Fetch player position by playerId correctly', () async {
      await database.gameSessionDao.addGameSession(gameSession);
      var position = await database.playerDao.getPositionByPlayerId(player1.id);

      expect(position, player1.position);

      position = await database.playerDao.getPositionByPlayerId(player2.id);

      expect(position, player2.position);

      position = await database.playerDao.getPositionByPlayerId(player3.id);

      expect(position, player3.position);
    });
  });
}
