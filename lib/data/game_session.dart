import 'dart:math';

/// This class represents a game session for the Cabo game.
/// [gameTitle] is the title of the game.
/// [players] is a string list of player names.
/// [gameMode] is an integer representing the game mode.
/// 0 for the 101 points mode, 1 for unlimited
/// [createdAt] is the timestamp of when the game session was created.
/// [round] is the current round number.
/// [finished] is a boolean indicating if the game session is finished.
class GameSession {
  final String gameTitle;
  final List<String> players;
  final int gameMode;
  final DateTime createdAt = DateTime.now().subtract(Duration(
      milliseconds: Random().nextInt(
          Duration(days: 21).inMilliseconds + 1))); // DEBUG: Random Timestamp
  int round = 1;
  bool finished = false;
  String winner = '';

  GameSession({
    required this.gameTitle,
    required this.players,
    required this.gameMode,
  });
  List<List<int>> playerScores = List.generate(5, (_) => [0, 0]);

  @override
  String toString() {
    return ('GameSession: [gameTitle: $gameTitle, '
        'players: $players, '
        'round: $round, gameMode: $gameMode, '
        'playerScores: $playerScores]');
  }

  void increaseRound() {
    round++;
  }

  int getLengthOfPlayerNames() {
    int length = 0;
    for (String player in players) {
      length += player.length;
    }
    return length;
  }

  void _determineWinner() {
    int score = playerScores[0][0];
    String lowestPlayer = players[0];
    for (int i = 0; i < players.length; i++) {
      print('Player: ${players[i]}, Score: ${playerScores[i][0]}');
      if (playerScores[i][0] < score) {
        print(
            'New lowest player: ${players[i]} - Score: ${playerScores[i][0]}');
        score = playerScores[i][0];
        lowestPlayer = players[i];
      }
    }
    print('Der Gewinner ist: $lowestPlayer');
    winner = lowestPlayer;
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
    print('addRoundScoresToScoreList: $roundScores');
    for (int i = 0; i < roundScores.length; i++) {
      print(
          'i: $i, roundNumber: $roundNumber, playerScores[i].length: ${playerScores[i].length}');
      playerScores[i][roundNumber] = (roundScores[i]);
    }
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
      if (gameMode == 0 && playerScores[i][0] > 101) {
        finished = true;
        print('${players[i]} hat die 101 Punkte ueberschritten, '
            'deswegen wurde das Spiel beendet');
        _determineWinner();
      }
    }
  }
}
