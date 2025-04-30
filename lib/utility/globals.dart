import 'package:cabo_counter/data/game_session.dart';

class Globals {
  /// The [gameList] contains all active game sessions.
  static List<GameSession> gameList = [];

  static void addGameSession(GameSession session) {
    gameList.add(session);
    gameList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}
