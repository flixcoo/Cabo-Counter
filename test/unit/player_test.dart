import 'package:cabo_counter/data/models/player.dart';
import 'package:test/test.dart';

void main() {
  late Player player1;
  late Player player2;

  setUp(() {
    player1 = Player(gameSessionId: 'testGameId', name: 'player1', position: 0);

    player2 = Player(gameSessionId: 'testGameId', name: 'player2', position: 2);
  });

  group('Player Test', () {});
  test('toJson()/fromJson() works correctly', () {
    var jsonMap = player1.toJson();
    var copy = Player.fromJson(jsonMap);
    expect(copy, player1);

    jsonMap = player2.toJson();
    copy = Player.fromJson(jsonMap);
    expect(copy, player2);
  });
}
