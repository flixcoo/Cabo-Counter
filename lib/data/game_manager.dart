import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:flutter/foundation.dart';

class GameManager extends ChangeNotifier {
  List<GameSession> gameList = [];

  /// Adds a new game session to the list and sorts it by creation date.
  /// Takes a [GameSession] object as input. It then adds the session to the `gameList`,
  /// sorts the list in descending order based on the creation date, and notifies listeners of the change.
  /// It also saves the updated game sessions to local storage.
  /// Returns the index of the newly added session in the sorted list.
  Future<int> addGameSession(GameSession session) async {
    session.addListener(() {
      notifyListeners(); // Propagate session changes
    });
    gameList.add(session);
    print(
        '[game_manager.dart] Added game session: ${session.gameTitle} at ${session.createdAt}');
    gameList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    print(
        '[game_manager.dart] Sorted game sessions by creation date. Total sessions: ${gameList.length}');
    notifyListeners();
    await LocalStorageService.saveGameSessions();
    print('[game_manager.dart] Saved game sessions to local storage.');
    return gameList.indexOf(session);
  }

  /// Removes a game session from the list and sorts it by creation date.
  /// Takes a [index] as input. It then removes the session at the specified index from the `gameList`,
  /// sorts the list in descending order based on the creation date, and notifies listeners of the change.
  /// It also saves the updated game sessions to local storage.
  void removeGameSessionByIndex(int index) {
    gameList[index].removeListener(notifyListeners);
    gameList.removeAt(index);
    notifyListeners();
    LocalStorageService.saveGameSessions();
  }

  /// Removes a game session by its ID.
  /// Takes a String [id] as input. It finds the index of the game session with the matching ID
  /// in the `gameList`, and then calls `removeGameSessionByIndex` with that index.
  int getGameSessionIndexById(String id) {
    return gameList.indexWhere((session) => session.id.toString() == id);
  }
}

final gameManager = GameManager();
