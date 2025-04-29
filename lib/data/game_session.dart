import 'package:cabo_counter/data/round.dart';

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
  late List<int> playerScores;
  List<Round> roundList = [];
  int roundNumber = 1;
  bool isGameFinished = false;
  String winner = '';

  GameSession({
    required this.gameTitle,
    required this.gameHasPointLimit,
    required this.players,
  }) {
    playerScores = List.filled(players.length, 0);
  }

  @override
  String toString() {
    return ('GameSession: [createdAt: $createdAt, gameTitle: $gameTitle, '
        'gameHasPointLimit: $gameHasPointLimit, players: $players, '
        'playerScores: $playerScores, roundList: $roundList, '
        'roundNumber: $roundNumber, isGameFinished: $isGameFinished, '
        'winner: $winner]');
  }

  /// Returns the length of all player names combined.
  int getLengthOfPlayerNames() {
    int length = 0;
    for (String player in players) {
      length += player.length;
    }
    return length;
  }

  /// Assigns 50 points to all players except the kamikaze player.
  /// [kamikazePlayerIndex] is the index of the kamikaze player.
  void applyKamikaze(int roundNum, int kamikazePlayerIndex) {
    List<int> roundScores = List.generate(players.length, (_) => 0);
    List<int> scoreUpdates = List.generate(players.length, (_) => 0);
    for (int i = 0; i < roundScores.length; i++) {
      if (i != kamikazePlayerIndex) {
        scoreUpdates[i] += 50;
      }
    }
    addRoundScoresToList(
        roundNum, roundScores, scoreUpdates, kamikazePlayerIndex);
  }

  /// Checks the scores of the current round and assigns points to the players.
  /// There are three possible outcomes of a round:
  ///
  /// **Case 1**<br>
  /// The player who said CABO has the lowest score. They receive 0 points.
  /// Every other player gets their round score.
  ///
  /// **Case 2**<br>
  ///  The player who said CABO does not have the lowest score.
  ///  They receive 5 extra points added to their round score.
  ///  Every player with the lowest score gets 0 points.
  ///  Every other player gets their round score.
  void calculateScoredPoints(
      int roundNum, List<int> roundScores, int caboPlayerIndex) {
    print('Spieler: $players');
    print('Punkte: $roundScores');
    print('${players[caboPlayerIndex]} hat mit ${roundScores[caboPlayerIndex]} '
        'Punkten CABO gesagt');

    /// List of the index of the player(s) with the lowest score
    List<int> lowestScoreIndex = _getLowestScoreIndex(roundScores);
    print('Folgende Spieler haben die niedrigsten Punte:');
    for (int i in lowestScoreIndex) {
      print('${players[i]} (${roundScores[i]} Punkte)');
    }
    // The player who said CABO is one of the players which have the
    // fewest points.
    if (lowestScoreIndex.contains(caboPlayerIndex)) {
      print('${players[caboPlayerIndex]} hat CABO gesagt '
          'und bekommt 0 Punkte');
      print('Alle anderen Spieler bekommen ihre Punkte');
      _assignPoints(roundNum, roundScores, [caboPlayerIndex]);
    } else {
      // A player other than the one who said CABO has the fewest points.
      print('${players[caboPlayerIndex]} hat CABO gesagt, '
          'jedoch nicht die wenigsten Punkte.');
      print('Folgende:r Spieler haben die wenigsten Punkte:');
      for (int i in lowestScoreIndex) {
        print('${players[i]}: ${roundScores[i]} Punkte');
      }
      _assignPoints(roundNum, roundScores, lowestScoreIndex, caboPlayerIndex);
    }
  }

  /// Returns the index of the player with the lowest score. If there are
  /// multiple players with the same lowest score, all of them are returned.
  /// [roundScores] is a list of the scores of all players in the current round.
  List<int> _getLowestScoreIndex(List<int> roundScores) {
    int lowestScore = roundScores[0];
    List<int> lowestScoreIndex = [0];

    for (int i = 1; i < roundScores.length; i++) {
      if (roundScores[i] < lowestScore) {
        lowestScore = roundScores[i];
        lowestScoreIndex = [i];
      } else if (roundScores[i] == lowestScore) {
        lowestScoreIndex.add(i);
      }
    }
    return lowestScoreIndex;
  }

  /// Assigns points to the players based on the scores of the current round.
  /// [roundNum] is the number of the current round.
  /// [roundScores] is the raw list of the scores of all players in the current round.
  /// [winnerIndex] is the index of the player who receives 5 extra points
  void _assignPoints(int roundNum, List<int> roundScores, List<int> winnerIndex,
      [int loserIndex = -1]) {
    /// List of the updates for every player score
    List<int> scoreUpdates = [...roundScores];
    print('Folgende Punkte wurden aus der Runde übernommen:');
    for (int i = 0; i < scoreUpdates.length; i++) {
      print('${players[i]}: ${scoreUpdates[i]}');
    }
    for (int i in winnerIndex) {
      print('${players[i]} hat gewonnen und bekommt 0 Punkte');
      scoreUpdates[i] = 0;
    }
    if (loserIndex != -1) {
      print('${players[loserIndex]} bekommt 5 Fehlerpunkte');
      scoreUpdates[loserIndex] += 5;
    }
    print('Aktualisierte Punkte:');
    for (int i = 0; i < scoreUpdates.length; i++) {
      print('${players[i]}: ${scoreUpdates[i]}');
    }
    print('scoreUpdates: $scoreUpdates, roundScores: $roundScores');
    addRoundScoresToList(roundNum, roundScores, scoreUpdates);
  }

  /// Sets the scores of the players for a specific round.
  /// This method takes a list of round scores and a round number as parameters.
  /// It then replaces the values for the given [roundNum] in the
  /// playerScores. Its important that each index of the [roundScores] list
  /// corresponds to the index of the player in the [playerScores] list.
  void addRoundScoresToList(
      int roundNum, List<int> roundScores, List<int> scoreUpdates,
      [int? kamikazePlayerIndex]) {
    Round newRound = Round(
      roundNum: roundNum,
      scores: roundScores,
      scoreUpdates: scoreUpdates,
      kamikaze: kamikazePlayerIndex,
    );
    if (roundNum > roundList.length) {
      roundList.add(newRound);
    } else {
      roundList[roundNum - 1] = newRound;
    }
  }

  /// This method updates the points of each player after a round.
  /// It first uses the _sumPoints() method to calculate the total points of each player.
  /// Then, it checks if any player has reached 100 points. If so, it marks
  /// that player as having reached 100 points in that corresponding [Round] object.
  /// If the game has the point limit activated, it first applies the
  /// _subtractPointsForReachingHundred() method to subtract 50 points
  /// for every time a player reached 100 points in the game.
  /// It then checks if any player has exceeded 100 points. If so, it sets
  /// isGameFinished to true and calls the _setWinner() method to determine
  /// the winner.
  void updatePoints() {
    _sumPoints();
    if (gameHasPointLimit) {
      _checkHundredPointsReached();

      for (int i = 0; i < playerScores.length; i++) {
        if (playerScores[i] > 100) {
          isGameFinished = true;
          print('${players[i]} hat die 100 Punkte ueberschritten, '
              'deswegen wurde das Spiel beendet');
          _setWinner();
        }
      }
    }
  }

  /// Sums up the points of all players and stores the result in the
  /// playerScores list.
  void _sumPoints() {
    print('_sumPoints()');
    for (int i = 0; i < players.length; i++) {
      playerScores[i] = 0;
      for (int j = 0; j < roundList.length; j++) {
        playerScores[i] += roundList[j].scoreUpdates[i];
      }
    }
  }

  /// Checks if a player has reached 100 points in the current round.
  /// If so, it updates the [scoreUpdate] List by subtracting 50 points from
  /// the corresponding round update.
  void _checkHundredPointsReached() {
    for (int i = 0; i < players.length; i++) {
      if (playerScores[i] == 100) {
        print('${players[i]} hat genau 100 Punkte erreicht und bekommt '
            'deswegen 50 Punkte abgezogen');
        roundList[roundNumber - 1].scoreUpdates[i] -= 50;
      }
    }
    _sumPoints();
  }

  /// Determines the winner of the game session.
  /// It iterates through the player scores and finds the player
  /// with the lowest score.
  void _setWinner() {
    int score = playerScores[0];
    String lowestPlayer = players[0];
    for (int i = 0; i < players.length; i++) {
      if (playerScores[i] < score) {
        score = playerScores[i];
        lowestPlayer = players[i];
      }
    }
    winner = lowestPlayer;
  }

  /// Increases the round number by 1.
  void increaseRound() {
    roundNumber++;
  }
}
