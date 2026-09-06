import 'package:uuid/uuid.dart';

/// This class represents a single round in the game.
/// It is stored within the [GameSession] class.
/// [roundNum] is the number of the round its representing.
/// [scores] is a list of the actual scores the players got.
/// [scoreUpdates] is a list of how the players scores updated this round.
/// [kamikazePlayerIndex] is the index of the player who got kamikaze. If no one got
/// kamikaze, this value is null.
class Round {
  final String id;
  final String gameSessionId;
  final int roundNum;
  final int caboPlayerIndex;
  final int? kamikazePlayerIndex;
  final List<int> scores;
  final List<int> scoreUpdates;

  Round({
    String? roundId,
    required this.gameSessionId,
    required this.roundNum,
    required this.caboPlayerIndex,
    required this.scores,
    required this.scoreUpdates,
    this.kamikazePlayerIndex,
  }) : id = roundId ?? const Uuid().v4();

  @override
  toString() {
    return '{id: $id, gameSessionId: $gameSessionId, roundNum: $roundNum, caboPlayerIndex: $caboPlayerIndex, '
        'kamikazePlayerIndex: $kamikazePlayerIndex, scores: $scores, '
        'scoreUpdates: $scoreUpdates}\n';
  }

  /// Converts the Round object to a JSON map.
  Map<String, dynamic> toJson() => {
    'id': id,
    'gameSessionId': gameSessionId,
    'roundNum': roundNum,
    'caboPlayerIndex': caboPlayerIndex,
    'kamikazePlayerIndex': kamikazePlayerIndex,
    'scores': scores,
    'scoreUpdates': scoreUpdates,
  };

  /// Creates a Round object from a JSON map.
  Round.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      gameSessionId = json['gameSessionId'],
      roundNum = json['roundNum'],
      caboPlayerIndex = json['caboPlayerIndex'],
      kamikazePlayerIndex = json['kamikazePlayerIndex'],
      scores = List<int>.from(json['scores']),
      scoreUpdates = List<int>.from(json['scoreUpdates']);
}
