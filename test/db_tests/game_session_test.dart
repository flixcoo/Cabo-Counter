import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/data/dto/player.dart';
import 'package:cabo_counter/data/dto/round.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late GameSession gameSession;
  late GameSession gameSession2;
  late Player player1;
  late Player player2;
  late Player player3;
  late Player player4;
  late Player player5;
  late Player player6;
  late Round round1;
  late Round round2;
  late Round round3;
  late Round round4;
  late Round round5;
  late Round round6;

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
      gameId: 'test_game_id2',
      name: 'Player 4',
      position: 0,
      totalScore: 0,
    );
    player5 = Player(
      playerId: 'player5_id',
      gameId: 'test_game_id2',
      name: 'Player 5',
      position: 1,
      totalScore: 0,
    );
    player6 = Player(
      playerId: 'player6_id',
      gameId: 'test_game_id2',
      name: 'Player 6',
      position: 2,
      totalScore: 0,
    );
    round1 = Round(
      gameId: 'test_game_id',
      roundNum: 1,
      caboPlayerIndex: 0,
      scores: [5, 7, 10],
      scoreUpdates: [0, 7, 10],
    );
    round2 = Round(
      gameId: 'test_game_id',
      roundNum: 2,
      caboPlayerIndex: 1,
      scores: [2, 4, 4],
      scoreUpdates: [0, 9, 4],
    );
    round3 = Round(
      gameId: 'test_game_id',
      roundNum: 3,
      caboPlayerIndex: 1,
      kamikazePlayerIndex: 2,
      scores: [5, 2, 50],
      scoreUpdates: [50, 50, 0],
    );
    round4 = Round(
      gameId: 'test_game_id2',
      roundNum: 1,
      caboPlayerIndex: 2,
      scores: [3, 6, 8],
      scoreUpdates: [3, 6, 8],
    );
    round5 = Round(
      gameId: 'test_game_id2',
      roundNum: 2,
      caboPlayerIndex: 0,
      scores: [2, 7, 5],
      scoreUpdates: [0, 7, 5],
    );
    round6 = Round(
      gameId: 'test_game_id2',
      roundNum: 3,
      caboPlayerIndex: 0,
      scores: [2, 7, 5],
      scoreUpdates: [0, 7, 5],
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
        roundList: [round1, round2, round3]);
    gameSession2 = GameSession(
        gameId: 'test_game_id2',
        createdAt: DateTime.now(),
        isGameFinished: false,
        gameTitle: 'test game session 2',
        pointLimit: 100,
        caboPenalty: 5,
        isPointsLimitEnabled: true,
        players: [player4, player5, player6],
        roundList: [round4, round5, round6]);
  });
  tearDown(() async {
    await database.close();
  });

  group('GameSession-Tests', () {
    test('Inserting and fetching a game session works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      final fetchedSessions =
          await database.gameSessionDao.getGameSession(gameSession.gameId);

      if (fetchedSessions == null) {
        fail('Fetched game session is null');
      } else {
        expect(fetchedSessions.gameId, gameSession.gameId);
        expect(fetchedSessions.gameTitle, gameSession.gameTitle);
        expect(fetchedSessions.pointLimit, gameSession.pointLimit);
        expect(fetchedSessions.caboPenalty, gameSession.caboPenalty);
        expect(fetchedSessions.isPointsLimitEnabled,
            gameSession.isPointsLimitEnabled);
        expect(fetchedSessions.isGameFinished, gameSession.isGameFinished);
        expect(fetchedSessions.winner, gameSession.winner);
        expect(fetchedSessions.roundNumber, gameSession.roundNumber);
        expect(fetchedSessions.players.length, gameSession.players.length);
        expect(fetchedSessions.roundList.length, gameSession.roundList.length);
      }
    });

    test('Inserting and fetching multiple game sessions works correctly',
        () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      await database.gameSessionDao.insertGameSession(gameSession2);
      final fetchedSessions =
          await database.gameSessionDao.getAllGameSessions();

      final expected = {
        gameSession.gameId: gameSession,
        gameSession2.gameId: gameSession2,
      };

      if (fetchedSessions == null) {
        fail('Fetched game sessions is null');
      } else {
        expect(fetchedSessions.length, expected.length);

        for (var session in fetchedSessions) {
          final expectedSession = expected[session.gameId];
          if (expectedSession == null) {
            fail('Unexpected game session ID: ${session.gameId}');
          } else {
            expect(session.gameId, expectedSession.gameId);
            expect(
              session.createdAt
                  .difference(expectedSession.createdAt)
                  .inMilliseconds
                  .abs(),
              lessThan(1000),
            );
            expect(session.gameTitle, expectedSession.gameTitle);
            expect(session.pointLimit, expectedSession.pointLimit);
            expect(session.caboPenalty, expectedSession.caboPenalty);
            expect(session.isPointsLimitEnabled,
                expectedSession.isPointsLimitEnabled);
            expect(session.isGameFinished, expectedSession.isGameFinished);
            expect(session.winner, expectedSession.winner);
            expect(session.roundNumber, expectedSession.roundNumber);
            expect(session.players.length, expectedSession.players.length);
            for (int i = 0; i < session.players.length; i++) {
              expect(session.players[i].playerId,
                  expectedSession.players[i].playerId);
              expect(
                  session.players[i].gameId, expectedSession.players[i].gameId);
              expect(session.players[i].name, expectedSession.players[i].name);
              expect(session.players[i].position,
                  expectedSession.players[i].position);
              expect(session.players[i].totalScore,
                  expectedSession.players[i].totalScore);
            }

            expect(session.roundList.length, expectedSession.roundList.length);
            for (int i = 0; i < session.roundList.length; i++) {
              expect(session.roundList[i].gameId,
                  expectedSession.roundList[i].gameId);
              expect(session.roundList[i].roundNum,
                  expectedSession.roundList[i].roundNum);
              expect(session.roundList[i].caboPlayerIndex,
                  expectedSession.roundList[i].caboPlayerIndex);
              expect(session.roundList[i].kamikazePlayerIndex,
                  expectedSession.roundList[i].kamikazePlayerIndex);
              expect(session.roundList[i].scores,
                  expectedSession.roundList[i].scores);
              expect(session.roundList[i].scoreUpdates,
                  expectedSession.roundList[i].scoreUpdates);
            }
          }
        }
      }
    });

    test('Deleting a game session works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      var session =
          await database.gameSessionDao.getGameSession(gameSession.gameId);

      expect(session, isNotNull);

      await database.gameSessionDao.deleteGameSession(gameSession.gameId);
      final fetchedSessions =
          await database.gameSessionDao.getAllGameSessions();

      expect(fetchedSessions, isNull);
    });

    test('Deleting multiple game sessions works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      await database.gameSessionDao.insertGameSession(gameSession2);
      var sessions = await database.gameSessionDao.getAllGameSessions();

      expect(sessions, isNotNull);
      expect(sessions!.length, 2);

      await database.gameSessionDao.deleteAllGames();
      final fetchedSessions =
          await database.gameSessionDao.getAllGameSessions();

      expect(fetchedSessions, isNull);
    });

    test('Updating game finish status works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      await database.gameSessionDao
          .setGameFinishStatus(gameSession.gameId, true);
      var updatedSession =
          await database.gameSessionDao.getGameSession(gameSession.gameId);

      expect(updatedSession, isNotNull);
      expect(updatedSession!.isGameFinished, isTrue);

      await database.gameSessionDao
          .setGameFinishStatus(gameSession.gameId, false);
      updatedSession =
          await database.gameSessionDao.getGameSession(gameSession.gameId);
      expect(updatedSession, isNotNull);
      expect(updatedSession!.isGameFinished, isFalse);
    });

    test('Updating round number works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      await database.gameSessionDao.setRoundNumber(gameSession.gameId, 4);
      var updatedSession =
          await database.gameSessionDao.getGameSession(gameSession.gameId);

      expect(updatedSession, isNotNull);
      expect(updatedSession!.roundNumber, 4);

      await database.gameSessionDao.setRoundNumber(gameSession.gameId, 2);
      updatedSession =
          await database.gameSessionDao.getGameSession(gameSession.gameId);
      expect(updatedSession, isNotNull);
      expect(updatedSession!.roundNumber, 2);
    });

    test('Updating winner works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      await database.gameSessionDao.setWinner(gameSession.gameId, 'Player 1');
      var updatedSession =
          await database.gameSessionDao.getGameSession(gameSession.gameId);

      expect(updatedSession, isNotNull);
      expect(updatedSession!.winner, 'Player 1');

      await database.gameSessionDao
          .setWinner(gameSession.gameId, 'Player 2, Player 3');
      updatedSession =
          await database.gameSessionDao.getGameSession(gameSession.gameId);
      expect(updatedSession, isNotNull);
      expect(updatedSession!.winner, 'Player 2, Player 3');
    });

    test('Ending a game works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      int initialRoundNumber = gameSession.roundNumber;
      await database.gameSessionDao.endGame(gameSession.gameId);
      var updatedSession =
          await database.gameSessionDao.getGameSession(gameSession.gameId);

      expect(updatedSession, isNotNull);
      expect(updatedSession!.isGameFinished, isTrue);
      expect(updatedSession.roundNumber, initialRoundNumber - 1);
    });
  });
}
