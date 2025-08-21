import 'package:cabo_counter/data/dto/round.dart';
import 'package:test/test.dart';

void main() {
  late Round round;
  const testRoundNum = 1;
  const testCaboPlayerIndex = 0;
  const testKamikazePlayerIndex = 1;
  const testScores = [10, 20, 30];
  const testScoreUpdates = [5, 15, 25];

  setUp(() {
    round = Round(
      roundId: 'testRoundId',
      gameId: 'testGameId',
      roundNum: testRoundNum,
      caboPlayerIndex: testCaboPlayerIndex,
      kamikazePlayerIndex: testKamikazePlayerIndex,
      scores: testScores,
      scoreUpdates: testScoreUpdates,
    );
  });

  group('Constructor Tests', () {
    test('Constructor sets correct values', () {
      expect(round.roundNum, testRoundNum);
      expect(round.caboPlayerIndex, testCaboPlayerIndex);
      expect(round.kamikazePlayerIndex, testKamikazePlayerIndex);
      expect(round.scores, testScores);
      expect(round.scoreUpdates, testScoreUpdates);
    });

    test('Constructor with null kamikazePlayerIndex', () {
      final roundWithoutKamikaze = Round(
        roundId: 'testRoundId',
        gameId: 'testGameId',
        roundNum: testRoundNum,
        caboPlayerIndex: testCaboPlayerIndex,
        kamikazePlayerIndex: null,
        scores: testScores,
        scoreUpdates: testScoreUpdates,
      );

      expect(roundWithoutKamikaze.kamikazePlayerIndex, isNull);
    });
  });

  group('JSON Methods', () {
    test('toJson() returns correct map', () {
      final jsonMap = round.toJson();

      expect(jsonMap['roundNum'], equals(testRoundNum));
      expect(jsonMap['caboPlayerIndex'], equals(testCaboPlayerIndex));
      expect(jsonMap['kamikazePlayerIndex'], equals(testKamikazePlayerIndex));
      expect(jsonMap['scores'], equals(testScores));
      expect(jsonMap['scoreUpdates'], equals(testScoreUpdates));
    });

    test('fromJson() creates correct Round object', () {
      final jsonMap = {
        'roundNum': testRoundNum,
        'caboPlayerIndex': testCaboPlayerIndex,
        'kamikazePlayerIndex': testKamikazePlayerIndex,
        'scores': testScores,
        'scoreUpdates': testScoreUpdates,
      };

      final fromJsonRound = Round.fromJson(jsonMap);

      expect(fromJsonRound.roundNum, testRoundNum);
      expect(fromJsonRound.caboPlayerIndex, testCaboPlayerIndex);
      expect(fromJsonRound.kamikazePlayerIndex, testKamikazePlayerIndex);
      expect(fromJsonRound.scores, testScores);
      expect(fromJsonRound.scoreUpdates, testScoreUpdates);
    });

    test('fromJson() with null kamikazePlayerIndex', () {
      final jsonMap = {
        'roundNum': testRoundNum,
        'caboPlayerIndex': testCaboPlayerIndex,
        'kamikazePlayerIndex': null,
        'scores': testScores,
        'scoreUpdates': testScoreUpdates,
      };

      final fromJsonRound = Round.fromJson(jsonMap);

      expect(fromJsonRound.kamikazePlayerIndex, isNull);
    });
  });

  group('toString()', () {
    test('toString() returns correct string representation', () {
      final expectedString = 'Round $testRoundNum, '
          'caboPlayerIndex: $testCaboPlayerIndex, '
          'kamikazePlayerIndex: $testKamikazePlayerIndex, '
          'scores: $testScores, '
          'scoreUpdates: $testScoreUpdates, ';

      expect(round.toString(), equals(expectedString));
    });

    test('toString() with null kamikazePlayerIndex', () {
      final roundWithoutKamikaze = Round(
        roundId: 'testRoundId',
        gameId: 'testGameId',
        roundNum: testRoundNum,
        caboPlayerIndex: testCaboPlayerIndex,
        kamikazePlayerIndex: null,
        scores: testScores,
        scoreUpdates: testScoreUpdates,
      );

      final expectedString = 'Round $testRoundNum, '
          'caboPlayerIndex: $testCaboPlayerIndex, '
          'kamikazePlayerIndex: null, '
          'scores: $testScores, '
          'scoreUpdates: $testScoreUpdates, ';

      expect(roundWithoutKamikaze.toString(), expectedString);
    });
  });
}
