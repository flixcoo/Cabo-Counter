import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/data/dto/player.dart';
import 'package:test/test.dart';

void main() {
  late GameSession session;
  final testPlayers = [
    Player(
        name: 'Alice',
        totalScore: 0,
        playerId: '0',
        gameId: 'abc',
        position: 0),
    Player(
        name: 'Bob', totalScore: 0, playerId: '1', gameId: 'abc', position: 1),
    Player(
        name: 'Charlie',
        totalScore: 0,
        playerId: '2',
        gameId: 'abc',
        position: 2)
  ];
  final testDate = DateTime(2023, 1, 1);
  const testTitle = 'Test Game';

  setUp(() {
    session = GameSession(
        id: '1',
        createdAt: testDate,
        gameTitle: testTitle,
        players: testPlayers,
        pointLimit: 100,
        caboPenalty: 5,
        isPointsLimitEnabled: true,
        isGameFinished: false);
  });

  group('Initialization & JSON', () {
    test('Initialization', () {
      expect(session.gameTitle, testTitle);
      expect(session.players, testPlayers);
      expect(session.getPlayerScoresAsList(), [0, 0, 0]);
      expect(session.roundNumber, 1);
      expect(session.isGameFinished, isFalse);
      expect(session.winner, isEmpty);
    });

    test('toJson and fromJson', () {
      // Add some rounds to test serialization
      session.addRoundScoresToList(1, [10, 20, 30], [10, 20, 30], 0);
      session.addRoundScoresToList(2, [15, 25, 35], [5, 5, 5], 1);

      final json = session.toJson();
      final fromJsonSession = GameSession.fromJson(json);

      expect(fromJsonSession.gameTitle, testTitle);
      expect(fromJsonSession.players, testPlayers);
      expect(fromJsonSession.roundList.length, 2);
    });

    test('null values in JSON', () {
      expect(
          () => GameSession.fromJson({
                'createdAt': testDate.toIso8601String(),
                'gameTitle': null, // Invalid
                'players': testPlayers,
                'pointLimit': 100,
                'caboPenalty': 50,
                'isPointsLimitEnabled': true,
                'isGameFinished': false,
                'winner': '',
                'roundNumber': 1,
                'playerScores': [0, 0, 0],
                'roundList': [],
              }),
          throwsA(isA<TypeError>()));
    });
  });

  group('Helper Functions', () {
    test('increaseRound', () {
      expect(session.roundNumber, 1);
      session.increaseRound();
      expect(session.roundNumber, 2);
    });

    test('getLowestScoreIndex', () {
      List<int> lowestScoreIndex;

      lowestScoreIndex = session.testingGetLowestScoreIndex([5, 10, 15]);
      expect(lowestScoreIndex, [0]);

      lowestScoreIndex = session.testingGetLowestScoreIndex([5, 5, 15]);
      expect(lowestScoreIndex, [0, 1]);

      lowestScoreIndex = session.testingGetLowestScoreIndex([5, 5, 5]);
      expect(lowestScoreIndex, [0, 1, 2]);
    });
  });

  group('Game Functions', () {
    test('applyKamikaze', () {
      session.applyKamikaze(1, 0); // Alice has kamikaze
      expect(session.roundList[0].scoreUpdates, [0, 50, 50]);
      expect(session.roundList[0].scores, [0, 0, 0]);
      expect(session.roundList[0].kamikazePlayerIndex, 0);
      expect(session.roundList[0].caboPlayerIndex, 0);
    });

    test('calculateScoredPoints - CABO player has lowest', () {
      session.calculateScoredPoints(1, [3, 5, 8], 0); // Alice has lowest
      expect(session.roundList[0].scoreUpdates, equals([0, 5, 8]));
    });

    test('calculateScoredPoints - CABO player not lowest', () {
      session.calculateScoredPoints(1, [5, 3, 8], 0); // Bob has lowest
      expect(session.roundList[0].scoreUpdates, [10, 0, 8]);
    });

    test('addRoundScoresToList', () {
      session.addRoundScoresToList(1, [3, 5, 8], [0, 5, 8], 0);
      expect(session.roundList.length, 1);
      expect(session.roundList[0].roundNum, 1);
      expect(session.roundList[0].scoreUpdates, [0, 5, 8]);
      expect(session.roundList[0].scores, [3, 5, 8]);
      expect(session.roundList[0].kamikazePlayerIndex, isNull);
      expect(session.roundList[0].caboPlayerIndex, 0);
    });

    test('updatePoints - game not finished', () {
      session.addRoundScoresToList(1, [10, 20, 30], [10, 20, 30], 0);
      session.updatePoints();
      expect(session.isGameFinished, isFalse);
    });

    test('updatePoints - game finished', () {
      session.addRoundScoresToList(1, [101, 20, 30], [101, 20, 30], 0);
      session.updatePoints();
      expect(session.isGameFinished, isTrue);
    });

    test('_assignPoints', () {
      // Alice said Cabo and has the lowest score
      session.testingAssignPoints(1, [5, 10, 15], 0, [0]);
      expect(session.roundList[0].scoreUpdates, [0, 10, 15]);

      // Alice said Cabo and has not the lowest score
      session.testingAssignPoints(1, [5, 10, 15], 0, [1], 0);
      expect(session.roundList[0].scoreUpdates, [10, 0, 15]);

      // Bob and Charlie have the lowest score, Alice said Cabo
      session.testingAssignPoints(1, [15, 5, 5], 0, [1, 2], 0);
      expect(session.roundList[0].scoreUpdates, [20, 0, 0]);
    });

    test('_sumPoints', () async {
      session.addRoundScoresToList(1, [10, 20, 30], [10, 20, 30], 0);
      session.addRoundScoresToList(2, [5, 5, 5], [5, 5, 5], 1);
      session.testingSumPoints();
      expect(session.getPlayerScoresAsList(), [15, 25, 35]);
    });

    test('_checkHundredPointsReached via updatePoints', () {
      session.addRoundScoresToList(1, [50, 5, 15], [50, 0, 15], 1);
      session.addRoundScoresToList(2, [50, 5, 15], [50, 0, 15], 1);
      session.updatePoints();
      expect(session.getPlayerScoresAsList(), equals([50, 0, 30]));
    });

    test('_setWinner via updatePoints', () {
      session.addRoundScoresToList(1, [101, 20, 30], [101, 0, 30], 1);
      session.updatePoints();
      expect(session.winner, 'Bob'); // Bob has lowest score (20)
    });
  });
}
