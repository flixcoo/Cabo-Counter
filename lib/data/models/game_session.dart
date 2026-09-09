import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:uuid/uuid.dart';

/// This class represents a game session for  Cabo game.
///
/// [createdAt] is the timestamp of when the game session was created.
/// [title] is the title of the game.
/// [pointLimit] is the point limit of the game, or `null` if the game is
/// played without a point limit (unlimited mode).
/// [players] is a string list of player names.
/// [isGameFinished] is a boolean indicating if the game has ended yet.
class GameSession {
  final String id;
  final DateTime createdAt;
  final String title;
  final List<Player> players;
  final int? pointLimit;
  final int caboPenalty;
  bool isGameFinished;
  List<Round> roundList;

  GameSession({
    String? gameId,
    required this.createdAt,
    required this.title,
    required this.players,
    required this.pointLimit,
    required this.caboPenalty,
    this.isGameFinished = false,
    List<Round>? roundList,
  }) : id = gameId ?? const Uuid().v4(),
       roundList = roundList ?? [];

  int get roundNumber => roundList.length + (isGameFinished ? 0 : 1);
  bool get isPointsLimitEnabled => pointLimit != null;

  /// The players with the loweste score when the match is finished.
  String get winner {
    if (!isGameFinished || players.isEmpty) return '';
    final int minScore = players
        .map((p) => p.totalScore)
        .reduce((a, b) => a < b ? a : b);
    final lowestPlayers = players
        .where((p) => p.totalScore == minScore)
        .map((p) => p.name)
        .toList();
    if (lowestPlayers.length > 1) {
      return '${lowestPlayers.sublist(0, lowestPlayers.length - 1).join(', ')} & ${lowestPlayers.last}';
    }
    return lowestPlayers.first;
  }

  @override
  toString() {
    return 'GameSession: [id: $id, createdAt: $createdAt, title: $title, '
        'isPointsLimitEnabled: $isPointsLimitEnabled, pointLimit: $pointLimit, caboPenalty: $caboPenalty,'
        ' players: $players, roundList: $roundList, winner: $winner]';
  }

  /// Converts the GameSession object to a JSON map.
  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt.toIso8601String(),
    'title': title,
    'players': players.map((p) => p.toJson()).toList(),
    'pointLimit': pointLimit,
    'caboPenalty': caboPenalty,
    'isGameFinished': isGameFinished,
    'roundList': roundList.map((e) => e.toJson()).toList(),
  };

  /// Creates a GameSession object from a JSON map.
  GameSession.fromJson(Map<String, dynamic> json)
    : id = json['id'] ?? const Uuid().v4(),
      createdAt = DateTime.parse(json['createdAt']),
      title = json['title'],
      players = (json['players'] as List)
          .map((e) => Player.fromJson(e))
          .toList(),
      pointLimit = json['pointLimit'],
      caboPenalty = json['caboPenalty'],
      isGameFinished = json['isGameFinished'],
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
