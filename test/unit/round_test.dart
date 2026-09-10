import 'package:cabo_counter/data/models/round.dart';
import 'package:test/test.dart';

void main() {
  late Round round1;
  late Round round2;

  setUp(() {
    round1 = Round(
      roundId: 'testRoundId',
      gameSessionId: 'testGameId',
      caboPlayerIndex: 0,
      kamikazePlayerIndex: null,
      scores: [10, 20, 30],
      scoreUpdates: [0, 20, 30],
    );

    round2 = Round(
      roundId: 'testRoundId',
      gameSessionId: 'testGameId',
      caboPlayerIndex: 0,
      kamikazePlayerIndex: 0,
      scores: [0, 0, 0],
      scoreUpdates: [0, 50, 50],
    );
  });

  group('Round Test', () {});

  test('toJson()/fromJson() works correctly', () {
    var jsonMap = round1.toJson();
    var copy = Round.fromJson(jsonMap);
    expect(copy, round1);

    jsonMap = round2.toJson();
    copy = Round.fromJson(jsonMap);
    expect(copy, round2);
  });
}
