class GameSession {
  final String gameTitle;
  final List<String> players;
  final int gameMode;
  int round = 1;
  String? winner;

  GameSession({
    required this.gameTitle,
    required this.players,
    required this.winner,
    required this.gameMode,
  });
  List<List<int>> playerScores = [
    [7, 1, 4, 2],
    [7, 0, 3, 4],
    [5, 5, 0, 0],
    [10, 3, 3, 2],
    [30, 10, 15, 5]
  ];

  @override
  String toString() {
    return ('GameSession: [gameTitle: $gameTitle, '
        'players: $players, winner: $winner, '
        'round: $round, gameMode: $gameMode, '
        'playerScores: $playerScores]');
  }

  void expandPlayerScoreLists() {
    for (int i = 0; i < playerScores.length; i++) {
      playerScores[i].add(0);
    }
  }

  void addRoundScoresToScoreList(List<int> roundScores, int roundNumber) {
    for (int i = 0; i < roundScores.length; i++) {
      playerScores[i][roundNumber] = (roundScores[i]);
    }
  }

  void sumPoints() {
    for (int i = 0; i < playerScores.length; i++) {
      playerScores[i][0] = 0;
      for (int j = 1; j < playerScores[i].length; j++) {
        playerScores[i][0] += playerScores[i][j];
      }
    }
  }
}
