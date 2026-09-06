import 'package:uuid/uuid.dart';

class Player {
  final String playerId;
  final String gameId;
  final String name;
  final int position;
  int totalScore;

  Player({
    String? playerId,
    required this.gameId,
    required this.name,
    required this.position,
    this.totalScore = 0,
  }) : playerId = playerId ?? const Uuid().v4();

  @override
  String toString() {
    return 'Player: [playerId: $playerId, gameId: $gameId, name: $name, position: $position]';
  }

  Map<String, dynamic> toJson() => {
    'playerId': playerId,
    'gameId': gameId,
    'name': name,
    'position': position,
    'totalScore': totalScore,
  };

  Player.fromJson(Map<String, dynamic> json)
    : playerId = json['playerId'],
      gameId = json['gameId'],
      name = json['name'],
      position = json['position'],
      totalScore = json['totalScore'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Player &&
          runtimeType == other.runtimeType &&
          playerId == other.playerId &&
          gameId == other.gameId &&
          name == other.name &&
          position == other.position &&
          totalScore == other.totalScore;

  @override
  int get hashCode =>
      Object.hash(playerId, gameId, name, position, totalScore);
}
