import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/data/dto/player.dart';
import 'package:cabo_counter/data/dto/round.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late GameSession gameSession;
  late GameSession emptyGameSession;
  late Player player1;
  late Player player2;
  late Player player3;
  late Round round1;
  late Round round2;
  late Round round3;
  late Round round3Replacement;
  late Round round4;
  late Round round5;

  // Helper function to compare lists
  Function areListsEqual = const ListEquality().equals;

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
    round3Replacement = Round(
      gameId: 'test_game_id',
      roundNum: 3,
      caboPlayerIndex: 0,
      scores: [4, 3, 6],
      scoreUpdates: [9, 0, 6],
    );
    round4 = Round(
      gameId: 'test_game_id',
      roundNum: 4,
      caboPlayerIndex: 2,
      scores: [3, 6, 8],
      scoreUpdates: [3, 6, 8],
    );
    round5 = Round(
      gameId: 'test_game_id',
      roundNum: 5,
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
    emptyGameSession = GameSession(
        gameId: 'test_game_id',
        createdAt: DateTime.now(),
        isGameFinished: false,
        gameTitle: 'empty game session',
        pointLimit: 100,
        caboPenalty: 5,
        isPointsLimitEnabled: true,
        players: [player1, player2, player3],
        roundList: []);
  });
  tearDown(() async {
    await database.close();
  });

  group('Rounds-Tests', () {
    test('Fetch rounds by gameId works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      final fetchedRounds =
          await database.roundsDao.getRoundsByGameId('test_game_id');

      expect(fetchedRounds.length, gameSession.roundList.length);

      for (int i = 0; i < fetchedRounds.length; i++) {
        expect(fetchedRounds[i].roundId, gameSession.roundList[i].roundId);
        expect(fetchedRounds[i].gameId, gameSession.roundList[i].gameId);
        expect(fetchedRounds[i].roundNum, gameSession.roundList[i].roundNum);
        expect(fetchedRounds[i].caboPlayerIndex,
            gameSession.roundList[i].caboPlayerIndex);
        expect(fetchedRounds[i].kamikazePlayerIndex,
            gameSession.roundList[i].kamikazePlayerIndex);
        expect(
            areListsEqual(
                fetchedRounds[i].scores, gameSession.roundList[i].scores),
            true);
        expect(
            areListsEqual(fetchedRounds[i].scoreUpdates,
                gameSession.roundList[i].scoreUpdates),
            true);
      }
    });

    test('Fetch rounds by roundNum and gameId works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);

      late Round? round;

      for (int i = 1; i <= gameSession.roundList.length; i++) {
        round = await database.roundsDao
            .getRoundByGameIdAndRoundNumber(gameSession.gameId, i);

        if (round == null) {
          fail('Round $i should not be null');
        } else {
          final expectedRound = gameSession.roundList[i - 1];

          expect(round.roundId, expectedRound.roundId);
          expect(round.gameId, expectedRound.gameId);
          expect(round.roundNum, expectedRound.roundNum);
          expect(round.caboPlayerIndex, expectedRound.caboPlayerIndex);
          expect(round.kamikazePlayerIndex, expectedRound.kamikazePlayerIndex);
          expect(areListsEqual(round.scores, expectedRound.scores), true);
          expect(areListsEqual(round.scoreUpdates, expectedRound.scoreUpdates),
              true);
        }
      }
    });

    test('Inserting and fetching a new round works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      await database.roundsDao
          .insertOneRound(gameSession.gameId, round4, gameSession.players);

      final round = await database.roundsDao
          .getRoundByGameIdAndRoundNumber(gameSession.gameId, 4);

      if (round == null) {
        fail('Inserted round should not be null');
      } else {
        expect(round.roundId, round4.roundId);
        expect(round.gameId, round4.gameId);
        expect(round.roundNum, round4.roundNum);
        expect(round.caboPlayerIndex, round4.caboPlayerIndex);
        expect(round.kamikazePlayerIndex, round4.kamikazePlayerIndex);
        expect(areListsEqual(round.scores, round4.scores), true);
        expect(areListsEqual(round.scoreUpdates, round4.scoreUpdates), true);
      }
    });

    test('Replacing a round works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);

      var round = await database.roundsDao
          .getRoundByGameIdAndRoundNumber(gameSession.gameId, 3);

      if (round == null) {
        fail('Round 3 should not be null before replacement');
      } else {
        expect(round.roundId, round3.roundId);
        expect(round.gameId, round3.gameId);
        expect(round.roundNum, round3.roundNum);
        expect(round.caboPlayerIndex, round3.caboPlayerIndex);
        expect(round.kamikazePlayerIndex, round3.kamikazePlayerIndex);
        expect(areListsEqual(round.scores, round3.scores), true);
        expect(areListsEqual(round.scoreUpdates, round3.scoreUpdates), true);
      }

      await database.roundsDao.replaceRound(
          gameSession.gameId, round3Replacement, gameSession.players);

      round = await database.roundsDao
          .getRoundByGameIdAndRoundNumber(gameSession.gameId, 3);

      if (round == null) {
        fail('Round 3 should not be null after replacement');
      } else {
        expect(round.roundId, round3Replacement.roundId);
        expect(round.gameId, round3Replacement.gameId);
        expect(round.roundNum, round3Replacement.roundNum);
        expect(round.caboPlayerIndex, round3Replacement.caboPlayerIndex);
        expect(
            round.kamikazePlayerIndex, round3Replacement.kamikazePlayerIndex);
        expect(areListsEqual(round.scores, round3Replacement.scores), true);
        expect(
            areListsEqual(round.scoreUpdates, round3Replacement.scoreUpdates),
            true);
      }
    });

    test('Inserting multiple rounds works correctly', () async {
      await database.gameSessionDao.insertGameSession(emptyGameSession);

      final newRounds = [round1, round2, round3, round4, round5];

      await database.roundsDao.insertMultipleRounds(
          emptyGameSession.gameId, newRounds, emptyGameSession.players);

      final fetchedRounds =
          await database.roundsDao.getRoundsByGameId(emptyGameSession.gameId);

      expect(fetchedRounds.length, newRounds.length);

      for (int i = 0; i < fetchedRounds.length; i++) {
        expect(fetchedRounds[i].roundId, newRounds[i].roundId);
        expect(fetchedRounds[i].gameId, newRounds[i].gameId);
        expect(fetchedRounds[i].roundNum, newRounds[i].roundNum);
        expect(fetchedRounds[i].caboPlayerIndex, newRounds[i].caboPlayerIndex);
        expect(fetchedRounds[i].kamikazePlayerIndex,
            newRounds[i].kamikazePlayerIndex);
        expect(
            areListsEqual(fetchedRounds[i].scores, newRounds[i].scores), true);
        expect(
            areListsEqual(
                fetchedRounds[i].scoreUpdates, newRounds[i].scoreUpdates),
            true);
      }
    });

    test('Fetching a non-existent round returns null', () async {
      await database.gameSessionDao.insertGameSession(gameSession);

      final round = await database.roundsDao
          .getRoundByGameIdAndRoundNumber(gameSession.gameId, 99);

      expect(round, isNull);
    });

    test('Deleting a round works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);

      var round = await database.roundsDao
          .getRoundByGameIdAndRoundNumber(gameSession.gameId, 3);

      if (round == null) {
        fail('Round should not be null before deletion');
      }

      await database.roundsDao.deleteRound(gameSession.gameId, 3);

      round = await database.roundsDao
          .getRoundByGameIdAndRoundNumber(gameSession.gameId, 3);

      expect(round, isNull);
    });
  });
}
