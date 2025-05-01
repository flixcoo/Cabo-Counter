import 'package:cabo_counter/data/game_session.dart';

/// This class represents a single round in the game.
/// It is stored within the [GameSession] class.
/// [roundNum] is the number of the round its reppresenting.
/// [scores] is a list of the actual scores the players got.
/// [scoreUpdates] is a list of how the players scores updated this round.
/// [kamikazePlayerIndex] is the index of the player who got kamikaze. If no one got
/// kamikaze, this value is null.
class Round {
  final int roundNum;
  final List<int> scores;
  final List<int> scoreUpdates;
  final int? kamikazePlayerIndex;

  Round(
      {required this.roundNum,
      required this.scores,
      required this.scoreUpdates,
      this.kamikazePlayerIndex});

  @override
  toString() {
    return 'Round $roundNum: scores: $scores, scoreUpdates: $scoreUpdates, '
        'kamikazePlayerIndex: $kamikazePlayerIndex';
  }

  /// Converts the Round object to a JSON map.
  Map<String, dynamic> toJson() => {
        'roundNum': roundNum,
        'scores': scores,
        'scoreUpdates': scoreUpdates,
        'kamikazePlayerIndex': kamikazePlayerIndex,
      };

  /// Creates a Round object from a JSON map.
  Round.fromJson(Map<String, dynamic> json)
      : roundNum = json['roundNum'],
        scores = List<int>.from(json['scores']),
        scoreUpdates = List<int>.from(json['scoreUpdates']),
        kamikazePlayerIndex = json['kamikazePlayerIndex'];
}
