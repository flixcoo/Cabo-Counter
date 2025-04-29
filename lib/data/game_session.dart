/// This class represents a game session for the Cabo game.
/// [gameTitle] is the title of the game.
/// [players] is a string list of player names.
/// [gameHasPointLimit] is a boolean indicating if the game has the
/// default point limit of 101 points or not.
/// [createdAt] is the timestamp of when the game session was created.
/// [roundNumber] is the current round number.
/// [isGameFinished] is a boolean indicating if the game session is finished.
/// [winner] is the name of the player who won the game.
class GameSession {
  final DateTime createdAt = DateTime.now();
  final String gameTitle;
  final bool gameHasPointLimit;
  final List<String> players;
  List<List<int>> playerScores = List.generate(5, (_) => [0, 0]);
  int roundNumber = 1;
  bool isGameFinished = false;
  String winner = '';

  GameSession({
    required this.gameTitle,
    required this.players,
    required this.gameHasPointLimit,
  });

  @override
  String toString() {
    return ('GameSession: [createdAt: $createdAt, gameTitle: $gameTitle, '
        'gameHasPointLimit: $gameHasPointLimit, players: $players, '
        'playerScores: $playerScores, roundNumber: $roundNumber, '
        'isGameFinished: $isGameFinished, winner: $winner]');
  }

  // FIXME Debug
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

  /// Returns the length of all player names combined.
  int getLengthOfPlayerNames() {
    int length = 0;
    for (String player in players) {
      length += player.length;
    }
    return length;
  }

  /// Increases the round number by 1.
  void increaseRound() {
    roundNumber++;
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
    print('addRoundScoresToScoreList: $roundScores');
    for (int i = 0; i < roundScores.length; i++) {
      playerScores[i][roundNumber] = (roundScores[i]);
    }
  }

  /// Determines the winner of the game session.
  /// It iterates through the player scores and finds the player
  /// with the lowest score.
  void _determineWinner() {
    int score = playerScores[0][0];
    String lowestPlayer = players[0];
    for (int i = 0; i < players.length; i++) {
      if (playerScores[i][0] < score) {
        score = playerScores[i][0];
        lowestPlayer = players[i];
      }
    }
    winner = lowestPlayer;
  }

  /// Summarizes the points of all players in the first index of their
  /// score list. The method clears the first index of each player score
  /// list and then sums up the points from the second index to the last
  /// index. It then stores the result in the first index. This method is
  /// used to update the total points of each player after a round.
  /// If a player reaches the 101 points,
  void sumPoints() {
    for (int i = 0; i < playerScores.length; i++) {
      playerScores[i][0] = 0;
      for (int j = 1; j < playerScores[i].length; j++) {
        playerScores[i][0] += playerScores[i][j];
      }
      if (gameHasPointLimit) {
        print('playerScores[i][0]: ${playerScores[i][0]}');
        if (playerScores[i][0] == 100) {
          print('${players[i]} hat genau 100 Punkte erreicht, '
              'seine Punkte werden auf 50 Punkte reduziert');
          playerScores[i][playerScores[i].length - 1] -=
              50; // Subtract 50 from this round
          playerScores[i][0] -= 50; // Subtract 50 from the sum
        } else if (playerScores[i][0] > 100) {
          isGameFinished = true;
          print('${players[i]} hat die 100 Punkte ueberschritten, '
              'deswegen wurde das Spiel beendet');
          _determineWinner();
        }
      }
    }
    print('GameSession: sumPoints: $playerScores');
  }
}
