import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
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
    round3Replacement = Round(
      gameSessionId: 'test_game_id',
      caboPlayerIndex: 0,
      scores: [4, 3, 6],
      scoreUpdates: [9, 0, 6],
    );
    round4 = Round(
      gameSessionId: 'test_game_id',
      caboPlayerIndex: 2,
      scores: [3, 6, 8],
      scoreUpdates: [3, 6, 8],
    );
    round5 = Round(
      gameSessionId: 'test_game_id',
      caboPlayerIndex: 0,
      scores: [2, 7, 5],
      scoreUpdates: [0, 7, 5],
    );
    gameSession = GameSession(
      gameId: 'test_game_id',
      createdAt: DateTime.now(),
      isGameFinished: false,
      title: 'test game session',
      pointLimit: 100,
      caboPenalty: 5,
      isPointsLimitEnabled: true,
      players: [player1, player2, player3],
      roundList: [round1, round2, round3],
    );
    emptyGameSession = GameSession(
      gameId: 'test_game_id',
      createdAt: DateTime.now(),
      isGameFinished: false,
      title: 'empty game session',
      pointLimit: 100,
      caboPenalty: 5,
      isPointsLimitEnabled: true,
      players: [player1, player2, player3],
      roundList: [],
    );
  });
  tearDown(() async {
    await database.close();
  });

  group('Rounds-Tests', () {
    test('Fetch rounds by gameId works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      final fetchedRounds = await database.roundsDao.getRoundsByGameId(
        gameId: 'test_game_id',
      );

      expect(fetchedRounds.length, gameSession.roundList.length);

      for (int i = 0; i < fetchedRounds.length; i++) {
        expect(fetchedRounds[i].id, gameSession.roundList[i].id);
        expect(
          fetchedRounds[i].gameSessionId,
          gameSession.roundList[i].gameSessionId,
        );
        expect(
          fetchedRounds[i].caboPlayerIndex,
          gameSession.roundList[i].caboPlayerIndex,
        );
        expect(
          fetchedRounds[i].kamikazePlayerIndex,
          gameSession.roundList[i].kamikazePlayerIndex,
        );
        expect(
          areListsEqual(
            fetchedRounds[i].scores,
            gameSession.roundList[i].scores,
          ),
          true,
        );
        expect(
          areListsEqual(
            fetchedRounds[i].scoreUpdates,
            gameSession.roundList[i].scoreUpdates,
          ),
          true,
        );
      }
    });

    test('Fetch rounds by roundNum and gameId works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);

      late Round? round;

      for (int i = 1; i <= gameSession.roundList.length; i++) {
        round = await database.roundsDao.getRoundByGameIdAndRoundNumber(
          gameId: gameSession.id,
          roundNumber: i,
        );

        if (round == null) {
          fail('Round $i should not be null');
        } else {
          final expectedRound = gameSession.roundList[i - 1];

          expect(round.id, expectedRound.id);
          expect(round.gameSessionId, expectedRound.gameSessionId);
          expect(round.caboPlayerIndex, expectedRound.caboPlayerIndex);
          expect(round.kamikazePlayerIndex, expectedRound.kamikazePlayerIndex);
          expect(areListsEqual(round.scores, expectedRound.scores), true);
          expect(
            areListsEqual(round.scoreUpdates, expectedRound.scoreUpdates),
            true,
          );
        }
      }
    });

    test('Inserting and fetching a new round works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);
      await database.roundsDao.insertOneRound(
        gameId: gameSession.id,
        round: round4,
        roundNumber: 4,
        players: gameSession.players,
      );

      final round = await database.roundsDao.getRoundByGameIdAndRoundNumber(
        gameId: gameSession.id,
        roundNumber: 4,
      );

      if (round == null) {
        fail('Inserted round should not be null');
      } else {
        expect(round.id, round4.id);
        expect(round.gameSessionId, round4.gameSessionId);
        expect(round.caboPlayerIndex, round4.caboPlayerIndex);
        expect(round.kamikazePlayerIndex, round4.kamikazePlayerIndex);
        expect(areListsEqual(round.scores, round4.scores), true);
        expect(areListsEqual(round.scoreUpdates, round4.scoreUpdates), true);
      }
    });

    test('Replacing a round works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);

      var round = await database.roundsDao.getRoundByGameIdAndRoundNumber(
        gameId: gameSession.id,
        roundNumber: 3,
      );

      if (round == null) {
        fail('Round 3 should not be null before replacement');
      } else {
        expect(round.id, round3.id);
        expect(round.gameSessionId, round3.gameSessionId);
        expect(round.caboPlayerIndex, round3.caboPlayerIndex);
        expect(round.kamikazePlayerIndex, round3.kamikazePlayerIndex);
        expect(areListsEqual(round.scores, round3.scores), true);
        expect(areListsEqual(round.scoreUpdates, round3.scoreUpdates), true);
      }

      await database.roundsDao.replaceRound(
        gameId: gameSession.id,
        round: round3Replacement,
        roundNumber: 3,
        players: gameSession.players,
      );

      round = await database.roundsDao.getRoundByGameIdAndRoundNumber(
        gameId: gameSession.id,
        roundNumber: 3,
      );

      if (round == null) {
        fail('Round 3 should not be null after replacement');
      } else {
        expect(round.id, round3Replacement.id);
        expect(round.gameSessionId, round3Replacement.gameSessionId);
        expect(round.caboPlayerIndex, round3Replacement.caboPlayerIndex);
        expect(
          round.kamikazePlayerIndex,
          round3Replacement.kamikazePlayerIndex,
        );
        expect(areListsEqual(round.scores, round3Replacement.scores), true);
        expect(
          areListsEqual(round.scoreUpdates, round3Replacement.scoreUpdates),
          true,
        );
      }
    });

    test('Inserting multiple rounds works correctly', () async {
      await database.gameSessionDao.insertGameSession(emptyGameSession);

      final newRounds = [round1, round2, round3, round4, round5];

      await database.roundsDao.insertMultipleRounds(
        gameId: emptyGameSession.id,
        rounds: newRounds,
        players: emptyGameSession.players,
      );

      final fetchedRounds = await database.roundsDao.getRoundsByGameId(
        gameId: emptyGameSession.id,
      );

      expect(fetchedRounds.length, newRounds.length);

      for (int i = 0; i < fetchedRounds.length; i++) {
        expect(fetchedRounds[i].id, newRounds[i].id);
        expect(fetchedRounds[i].gameSessionId, newRounds[i].gameSessionId);
        expect(fetchedRounds[i].caboPlayerIndex, newRounds[i].caboPlayerIndex);
        expect(
          fetchedRounds[i].kamikazePlayerIndex,
          newRounds[i].kamikazePlayerIndex,
        );
        expect(
          areListsEqual(fetchedRounds[i].scores, newRounds[i].scores),
          true,
        );
        expect(
          areListsEqual(
            fetchedRounds[i].scoreUpdates,
            newRounds[i].scoreUpdates,
          ),
          true,
        );
      }
    });

    test('Fetching a non-existent round returns null', () async {
      await database.gameSessionDao.insertGameSession(gameSession);

      final round = await database.roundsDao.getRoundByGameIdAndRoundNumber(
        gameId: gameSession.id,
        roundNumber: 99,
      );

      expect(round, isNull);
    });

    test('Deleting a round works correctly', () async {
      await database.gameSessionDao.insertGameSession(gameSession);

      var round = await database.roundsDao.getRoundByGameIdAndRoundNumber(
        gameId: gameSession.id,
        roundNumber: 3,
      );

      if (round == null) {
        fail('Round should not be null before deletion');
      }

      await database.roundsDao.deleteRound(
        gameId: gameSession.id,
        roundNumber: 3,
      );

      round = await database.roundsDao.getRoundByGameIdAndRoundNumber(
        gameId: gameSession.id,
        roundNumber: 3,
      );

      expect(round, isNull);
    });
  });
}
