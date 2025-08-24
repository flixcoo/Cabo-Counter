class Player {
  final String playerId;
  final String gameId;
  final String name;
  final int position;
  int totalScore;

  Player(
      {required this.playerId,
      required this.gameId,
      required this.name,
      required this.position,
      this.totalScore = 0});

  @override
  String toString() {
    return 'Player: [playerId: $playerId, gameId: $gameId, name: $name, position: $position]';
  }

  Map<String, dynamic> toJson() => {
        'playerId': playerId,
        'gameId': gameId,
        'name': name,
        'position': position,
        'totalScore': totalScore
      };

  Player.fromJson(Map<String, dynamic> json)
      : playerId = json['playerId'],
        gameId = json['gameId'],
        name = json['name'],
        position = json['position'],
        totalScore = json['totalScore'];
}
