import 'package:uuid/uuid.dart';

class Player {
  final String id;
  final String gameSessionId;
  final String name;
  final int position;
  int totalScore;

  Player({
    String? id,
    required this.gameSessionId,
    required this.name,
    required this.position,
    this.totalScore = 0,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
    'id': id,
    'gameSessionId': gameSessionId,
    'name': name,
    'position': position,
    'totalScore': totalScore,
  };

  Player.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      gameSessionId = json['gameSessionId'],
      name = json['name'],
      position = json['position'],
      totalScore = json['totalScore'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Player &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          gameSessionId == other.gameSessionId &&
          name == other.name &&
          position == other.position &&
          totalScore == other.totalScore;

  @override
  int get hashCode =>
      Object.hash(id, gameSessionId, name, position, totalScore);
}
