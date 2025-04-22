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

  /// Returns a string representation of the scores for a specific round.
  /// The method takes a round number as a parameter and returns a string
  /// containing the name of each player and their corressponding score in
  /// the given round.
  String printRoundScores(int round) {
    String result = '';
    for (int i = 0; i < players.length; i++) {
      result += '${players[i]}: ${playerScores[i][round]}\n';
    }
    return result;
  }

  /// Expands the player score lists by adding a new score of 0 for each player.
  /// This method is called when a new round starts so the lists in the
  /// active game view expands
  void expandPlayerScoreLists() {
    for (int i = 0; i < playerScores.length; i++) {
      playerScores[i].add(0);
    }
  }

  /// Sets the scores of the players for a specific round.
  /// This method takes a list of round scores and a round number as parameters.
  /// It then replaces the values for the given [roundNumber] in the
  /// playerScores. Its important that each index of the [roundScores] list
  /// corresponds to the index of the player in the [playerScores] list.
  void addRoundScoresToScoreList(List<int> roundScores, int roundNumber) {
    for (int i = 0; i < roundScores.length; i++) {
      playerScores[i][roundNumber] = (roundScores[i]);
    }
  }

  /// Summarizes the points of all players in the first index of their
  /// score list. The method clears the first index of each player score
  /// list and then sums up the points from the second index to the last
  /// index. It then stores the result in the first index. This method is
  /// used to update the total points of each player after a round.
  void sumPoints() {
    for (int i = 0; i < playerScores.length; i++) {
      playerScores[i][0] = 0;
      for (int j = 1; j < playerScores[i].length; j++) {
        playerScores[i][0] += playerScores[i][j];
      }
    }
  }
}
