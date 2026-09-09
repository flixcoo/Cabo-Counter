import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late GameSession gameSession;
  late Player player1;
  late Player player2;
  late Player player3;
  late Round round1;
  late Round round2;
  late Round round3;

  setUp(() {
    database = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        // Recommended for widget tests to avoid test errors.
        closeStreamsSynchronously: true,
      ),
    );
    player1 = Player(
      gameSessionId: 'test_game_id',
      name: 'Player 1',
      position: 0,
      totalScore: 0,
    );
    player2 = Player(
      gameSessionId: 'test_game_id',
      name: 'Player 2',
      position: 1,
      totalScore: 0,
    );
    player3 = Player(
      gameSessionId: 'test_game_id',
      name: 'Player 3',
      position: 2,
      totalScore: 0,
    );
    round1 = Round(
      gameSessionId: 'test_game_id',
      caboPlayerIndex: 0,
      scores: [5, 7, 10],
      scoreUpdates: [0, 7, 10],
    );
    round2 = Round(
      gameSessionId: 'test_game_id',
      caboPlayerIndex: 1,
      scores: [2, 4, 4],
      scoreUpdates: [0, 9, 4],
    );
    round3 = Round(
      gameSessionId: 'test_game_id',
      caboPlayerIndex: 1,
      kamikazePlayerIndex: 2,
      scores: [5, 2, 50],
      scoreUpdates: [50, 50, 0],
    );
    gameSession = GameSession(
      gameId: 'test_game_id',
      createdAt: DateTime.now(),
      isGameFinished: false,
      title: 'test game session',
      pointLimit: 100,
      caboPenalty: 5,
      players: [player1, player2, player3],
      roundList: [round1, round2, round3],
    );
  });
  tearDown(() async {
    await database.close();
  });

  group('RoundScore-Tests', () {
    test('Scores get fetched correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);

      final List<List<int>> scores = await Future.wait([
        database.roundScoresDao.getScoresByRoundId(
          roundId: gameSession.roundList[0].id,
        ),
        database.roundScoresDao.getScoresByRoundId(
          roundId: gameSession.roundList[1].id,
        ),
        database.roundScoresDao.getScoresByRoundId(
          roundId: gameSession.roundList[2].id,
        ),
      ]);

      for (int i = 0; i < scores.length; i++) {
        expect(scores[i].length, gameSession.players.length);
        for (int j = 0; j < scores[i].length; j++) {
          expect(scores[i][j], gameSession.roundList[i].scores[j]);
        }
      }
    });

    test('Score Updates get fetched correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);

      final List<List<int>> scoreUpdates = await Future.wait([
        database.roundScoresDao.getScoreUpdatesByRoundId(
          roundId: gameSession.roundList[0].id,
        ),
        database.roundScoresDao.getScoreUpdatesByRoundId(
          roundId: gameSession.roundList[1].id,
        ),
        database.roundScoresDao.getScoreUpdatesByRoundId(
          roundId: gameSession.roundList[2].id,
        ),
      ]);

      for (int i = 0; i < scoreUpdates.length; i++) {
        expect(scoreUpdates[i].length, gameSession.players.length);
        for (int j = 0; j < scoreUpdates[i].length; j++) {
          expect(scoreUpdates[i][j], gameSession.roundList[i].scoreUpdates[j]);
        }
      }
    });
  });
}
