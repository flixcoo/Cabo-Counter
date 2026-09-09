import 'package:uuid/uuid.dart';

/// This class represents a single round in the game.
/// - [kamikazePlayerIndex] is the index of the player who got kamikaze. If no one got
/// - [scores] is a list of the actual scores the players got.
/// - [scoreUpdates] is a list of how the players scores updated this round.
/// kamikaze, this value is null.
class Round {
  final String id;
  final String gameSessionId;
  final int caboPlayerIndex;
  final int? kamikazePlayerIndex;
  final List<int> scores;
  final List<int> scoreUpdates;

  Round({
    String? roundId,
    required this.gameSessionId,
    required this.caboPlayerIndex,
    required this.scores,
    required this.scoreUpdates,
    this.kamikazePlayerIndex,
  }) : id = roundId ?? const Uuid().v4();

  @override
  toString() {
    return '{id: $id, gameSessionId: $gameSessionId, caboPlayerIndex: $caboPlayerIndex, '
        'kamikazePlayerIndex: $kamikazePlayerIndex, scores: $scores, '
        'scoreUpdates: $scoreUpdates}\n';
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'gameSessionId': gameSessionId,
    'caboPlayerIndex': caboPlayerIndex,
    'kamikazePlayerIndex': kamikazePlayerIndex,
    'scores': scores,
    'scoreUpdates': scoreUpdates,
  };

  Round.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      gameSessionId = json['gameSessionId'],
      caboPlayerIndex = json['caboPlayerIndex'],
      kamikazePlayerIndex = json['kamikazePlayerIndex'],
      scores = List<int>.from(json['scores']),
      scoreUpdates = List<int>.from(json['scoreUpdates']);
}
