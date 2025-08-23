import 'package:cabo_counter/data/dto/player.dart';
import 'package:cabo_counter/data/dto/round.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

/// This class represents a game session for  Cabo game.
/// [createdAt] is the timestamp of when the game session was created.
/// [gameTitle] is the title of the game.
/// [isPointsLimitEnabled] is a boolean indicating if the game has the default
/// point limit of 101 points or not.
/// [players] is a string list of player names.
/// [playerScores] is a list of the summed scores of all players.
/// [roundNumber] is the current round number.
/// [isGameFinished] is a boolean indicating if the game has ended yet.
/// [winner] is the name of the player who won the game.
class GameSession extends ChangeNotifier {
  final String id;
  final DateTime createdAt;
  final String gameTitle;
  final List<Player> players;
  final int pointLimit;
  final int caboPenalty;
  final bool isPointsLimitEnabled;
  bool isGameFinished;
  String winner;
  int roundNumber;
  List<Round> roundList;

  GameSession({
    required this.id,
    required this.createdAt,
    required this.gameTitle,
    required this.players,
    required this.pointLimit,
    required this.caboPenalty,
    required this.isPointsLimitEnabled,
    this.isGameFinished = false,
    this.winner = '',
    this.roundNumber = 1,
    List<Round>? roundList,
  }) : roundList = roundList ?? [];

  @override
  toString() {
    return 'GameSession: [id: $id, createdAt: $createdAt, gameTitle: $gameTitle, '
        'isPointsLimitEnabled: $isPointsLimitEnabled, pointLimit: $pointLimit, caboPenalty: $caboPenalty,'
        ' players: $players, roundList: $roundList, winner: $winner]';
  }

  /// Converts the GameSession object to a JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'gameTitle': gameTitle,
        'players': players,
        'pointLimit': pointLimit,
        'caboPenalty': caboPenalty,
        'isPointsLimitEnabled': isPointsLimitEnabled,
        'isGameFinished': isGameFinished,
        'winner': winner,
        'roundNumber': roundNumber,
        'roundList': roundList.map((e) => e.toJson()).toList()
      };

  /// Creates a GameSession object from a JSON map.
  GameSession.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? const Uuid().v1(),
        createdAt = DateTime.parse(json['createdAt']),
        gameTitle = json['gameTitle'],
        players = List<Player>.from(json['players']),
        pointLimit = json['pointLimit'],
        caboPenalty = json['caboPenalty'],
        isPointsLimitEnabled = json['isPointsLimitEnabled'],
        isGameFinished = json['isGameFinished'],
        winner = json['winner'],
        roundNumber = json['roundNumber'],
        roundList =
            (json['roundList'] as List).map((e) => Round.fromJson(e)).toList();

  /// Assigns 50 points to all players except the kamikaze player.
  /// [kamikazePlayerIndex] is the index of the kamikaze player.
  void applyKamikaze(int roundNum, int kamikazePlayerIndex) {
    List<int> roundScores = List.generate(players.length, (_) => 0);
    List<int> scoreUpdates = List.generate(players.length, (_) => 0);
    for (int i = 0; i < scoreUpdates.length; i++) {
      if (i != kamikazePlayerIndex) {
        scoreUpdates[i] += 50;
      }
    }
    addRoundScoresToList(
        roundNum, roundScores, scoreUpdates, 0, kamikazePlayerIndex);
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
      _assignPoints(roundNum, roundScores, caboPlayerIndex, [caboPlayerIndex]);
    } else {
      // A player other than the one who said CABO has the fewest points.
      print('${players[caboPlayerIndex]} hat CABO gesagt, '
          'jedoch nicht die wenigsten Punkte.');
      print('Folgende:r Spieler haben die wenigsten Punkte:');
      for (int i in lowestScoreIndex) {
        print('${players[i]}: ${roundScores[i]} Punkte');
      }
      _assignPoints(roundNum, roundScores, caboPlayerIndex, lowestScoreIndex,
          caboPlayerIndex);
    }
  }

  /// The _getLowestScoreIndex method but forwarded for testing purposes.
  @visibleForTesting
  List<int> testingGetLowestScoreIndex(List<int> roundScores) =>
      _getLowestScoreIndex(roundScores);

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

  @visibleForTesting
  void testingAssignPoints(int roundNum, List<int> roundScores,
          int caboPlayerIndex, List<int> winnerIndex, [int? loserIndex]) =>
      _assignPoints(
          roundNum, roundScores, caboPlayerIndex, winnerIndex, loserIndex);

  /// Assigns points to the players based on the scores of the current round.
  /// [roundNum] is the number of the current round.
  /// [roundScores] is the raw list of the scores of all players in the current round.
  /// [winnerIndex] is the index of the player who receives 5 extra points
  void _assignPoints(int roundNum, List<int> roundScores, int caboPlayerIndex,
      List<int> winnerIndex,
      [int? loserIndex]) {
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
    if (loserIndex != null) {
      print('${players[loserIndex]} bekommt 5 Fehlerpunkte');
      scoreUpdates[loserIndex] += 5;
    }
    print('Aktualisierte Punkte:');
    for (int i = 0; i < scoreUpdates.length; i++) {
      print('${players[i]}: ${scoreUpdates[i]}');
    }
    print('scoreUpdates: $scoreUpdates, roundScores: $roundScores');
    addRoundScoresToList(roundNum, roundScores, scoreUpdates, caboPlayerIndex);
  }

  /// Sets the scores of the players for a specific round.
  /// This method takes a list of round scores and a round number as parameters.
  /// It then replaces the values for the given [roundNum] in the
  /// playerScores. Its important that each index of the [roundScores] list
  /// corresponds to the index of the player in the [playerScores] list.
  void addRoundScoresToList(
    int roundNum,
    List<int> roundScores,
    List<int> scoreUpdates,
    int caboPlayerIndex, [
    int? kamikazePlayerIndex,
  ]) {
    Round newRound = Round(
      roundId: const Uuid().v1(),
      gameId: id,
      roundNum: roundNum,
      caboPlayerIndex: caboPlayerIndex,
      kamikazePlayerIndex: kamikazePlayerIndex,
      scores: roundScores,
      scoreUpdates: scoreUpdates,
    );
    if (roundNum > roundList.length) {
      roundList.add(newRound);
    } else {
      roundList[roundNum - 1] = newRound;
    }
    notifyListeners();
  }

  /// This method updates the points of each player after a round.
  /// It first uses the _sumPoints() method to calculate the total points of each player.
  /// Then, it checks if any player has reached 100 points. If so, saves their indices and marks
  /// that player as having reached 100 points in that corresponding [Round] object.
  /// If the game has the point limit activated, it first applies the
  /// _subtractPointsForReachingHundred() method to subtract 50 points
  /// for every time a player reached 100 points in the game.
  /// It then checks if any player has exceeded 100 points. If so, it sets
  /// isGameFinished to true and calls the _setWinner() method to determine
  /// the winner.
  /// It returns a list of players indices who reached 100 points (bonus player)
  /// in the current round for the [RoundView] to show a popup
  List<int> updatePoints() {
    List<int> bonusPlayers = [];
    _sumPoints();

    if (isPointsLimitEnabled) {
      bonusPlayers = _checkHundredPointsReached();
      bool limitExceeded = false;

      for (int i = 0; i < players.length; i++) {
        if (players[i].totalScore > pointLimit) {
          isGameFinished = true;
          limitExceeded = true;
          print('${players[i]} hat die 100 Punkte ueberschritten, '
              'deswegen wurde das Spiel beendet');
          setWinner();
        }
      }
      if (!limitExceeded) {
        isGameFinished = false;
      }
    }
    notifyListeners();
    return bonusPlayers;
  }

  @visibleForTesting
  void testingSumPoints() => _sumPoints();

  /// Sums up the points of all players and stores the result in the
  /// playerScores list.
  void _sumPoints() {
    for (int i = 0; i < players.length; i++) {
      players[i].totalScore = 0;
      for (int j = 0; j < roundList.length; j++) {
        players[i].totalScore += roundList[j].scoreUpdates[i];
      }
    }
    notifyListeners();
  }

  /// Checks if a player has reached 100 points in the current round.
  /// If so, it updates the [scoreUpdate] List by subtracting 50 points from
  /// the corresponding round update.
  List<int> _checkHundredPointsReached() {
    List<int> bonusPlayers = [];
    for (int i = 0; i < players.length; i++) {
      if (players[i].totalScore == pointLimit) {
        bonusPlayers.add(i);
        print('${players[i]} hat genau 100 Punkte erreicht und bekommt '
            'deswegen ${(pointLimit / 2).round()} Punkte abgezogen');
        roundList[roundNumber - 1].scoreUpdates[i] -= (pointLimit / 2).round();
      }
    }
    _sumPoints();
    return bonusPlayers;
  }

  List<int> getPlayerScoresAsList() {
    return players.map((player) => player.totalScore).toList();
  }

  List<String> getPlayerNamesAsList() {
    return players.map((player) => player.name).toList();
  }

  /// Determines the winner of the game session.
  /// It iterates through the player scores and finds the player
  /// with the lowest score.
  void setWinner() {
    int minScore = getPlayerScoresAsList().reduce((a, b) => a < b ? a : b);
    List<String> lowestPlayers = [];
    for (int i = 0; i < players.length; i++) {
      if (players[i].totalScore == minScore) {
        lowestPlayers.add(players[i].name);
      }
    }
    if (lowestPlayers.length > 1) {
      winner =
          '${lowestPlayers.sublist(0, lowestPlayers.length - 1).join(', ')} & ${lowestPlayers.last}';
    } else {
      winner = lowestPlayers.first;
    }
    notifyListeners();
  }

  /// Increases the round number by 1.
  void increaseRound() {
    roundNumber++;
    print('roundNumber erhöht: $roundNumber — Hash: ${identityHashCode(this)}');

    notifyListeners();
  }
}
