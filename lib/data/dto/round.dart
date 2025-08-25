/// This class represents a single round in the game.
/// It is stored within the [GameSession] class.
/// [roundNum] is the number of the round its reppresenting.
/// [scores] is a list of the actual scores the players got.
/// [scoreUpdates] is a list of how the players scores updated this round.
/// [kamikazePlayerIndex] is the index of the player who got kamikaze. If no one got
/// kamikaze, this value is null.
class Round {
  final String roundId;
  final String gameId;
  final int roundNum;
  final int caboPlayerIndex;
  final int? kamikazePlayerIndex;
  final List<int> scores;
  final List<int> scoreUpdates;

  Round({
    required this.roundId,
    required this.gameId,
    required this.roundNum,
    required this.caboPlayerIndex,
    required this.scores,
    required this.scoreUpdates,
    this.kamikazePlayerIndex,
  });

  @override
  toString() {
    return 'Round $roundNum, caboPlayerIndex: $caboPlayerIndex, '
        'kamikazePlayerIndex: $kamikazePlayerIndex, scores: $scores, '
        'scoreUpdates: $scoreUpdates, ';
  }

  /// Converts the Round object to a JSON map.
  Map<String, dynamic> toJson() => {
        'roundId': roundId,
        'gameId': gameId,
        'roundNum': roundNum,
        'caboPlayerIndex': caboPlayerIndex,
        'kamikazePlayerIndex': kamikazePlayerIndex,
        'scores': scores,
        'scoreUpdates': scoreUpdates,
      };

  /// Creates a Round object from a JSON map.
  Round.fromJson(Map<String, dynamic> json)
      : roundId = json['roundId'],
        gameId = json['gameId'],
        roundNum = json['roundNum'],
        caboPlayerIndex = json['caboPlayerIndex'],
        kamikazePlayerIndex = json['kamikazePlayerIndex'],
        scores = List<int>.from(json['scores']),
        scoreUpdates = List<int>.from(json['scoreUpdates']);
}
