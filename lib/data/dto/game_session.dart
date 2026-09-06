import 'package:cabo_counter/data/dto/player.dart';
import 'package:cabo_counter/data/dto/round.dart';
import 'package:uuid/uuid.dart';

/// This class represents a game session for  Cabo game.
///
/// [createdAt] is the timestamp of when the game session was created.
/// [gameTitle] is the title of the game.
/// [isPointsLimitEnabled] is a boolean indicating if the game has the default
/// point limit of 101 points or not.
/// [players] is a string list of player names.
/// [roundNumber] is the current round number.
/// [isGameFinished] is a boolean indicating if the game has ended yet.
/// [winner] is the name of the player who won the game.
class GameSession {
  final String gameId;
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
    String? gameId,
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
  }) : gameId = gameId ?? const Uuid().v4(),
       roundList = roundList ?? [];

  @override
  toString() {
    return 'GameSession: [id: $gameId, createdAt: $createdAt, gameTitle: $gameTitle, '
        'isPointsLimitEnabled: $isPointsLimitEnabled, pointLimit: $pointLimit, caboPenalty: $caboPenalty,'
        ' players: $players, roundList: $roundList, winner: $winner]';
  }

  /// Converts the GameSession object to a JSON map.
  Map<String, dynamic> toJson() => {
    'id': gameId,
    'createdAt': createdAt.toIso8601String(),
    'gameTitle': gameTitle,
    'players': players.map((p) => p.toJson()).toList(),
    'pointLimit': pointLimit,
    'caboPenalty': caboPenalty,
    'isPointsLimitEnabled': isPointsLimitEnabled,
    'isGameFinished': isGameFinished,
    'winner': winner,
    'roundNumber': roundNumber,
    'roundList': roundList.map((e) => e.toJson()).toList(),
  };

  /// Creates a GameSession object from a JSON map.
  GameSession.fromJson(Map<String, dynamic> json)
    : gameId = json['id'] ?? const Uuid().v4(),
      createdAt = DateTime.parse(json['createdAt']),
      gameTitle = json['gameTitle'],
      players = (json['players'] as List)
          .map((e) => Player.fromJson(e))
          .toList(),
      pointLimit = json['pointLimit'],
      caboPenalty = json['caboPenalty'],
      isPointsLimitEnabled = json['isPointsLimitEnabled'],
      isGameFinished = json['isGameFinished'],
      winner = json['winner'],
      roundNumber = json['roundNumber'],
      roundList = (json['roundList'] as List)
          .map((e) => Round.fromJson(e))
          .toList();

  /// Returns the summed scores of all players as a list.
  List<int> getPlayerScoresAsList() {
    return players.map((player) => player.totalScore).toList();
  }

  /// Returns the names of all players as a list.
  List<String> getPlayerNamesAsList() {
    return players.map((player) => player.name).toList();
  }
}
