import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:flutter/foundation.dart';

class GameManager extends ChangeNotifier {
  List<GameSession> gameList = [];

  /// Adds a new game session to the list and sorts it by creation date.
  /// Takes a [GameSession] object as input. It then adds the session to the `gameList`,
  /// sorts the list in descending order based on the creation date, and notifies listeners of the change.
  /// It also saves the updated game sessions to local storage.
  void addGameSession(GameSession session) {
    gameList.add(session);
    gameList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    notifyListeners();
    LocalStorageService.saveGameSessions();
  }

  /// Removes a game session from the list and sorts it by creation date.
  /// Takes a [index] as input. It then removes the session at the specified index from the `gameList`,
  /// sorts the list in descending order based on the creation date, and notifies listeners of the change.
  /// It also saves the updated game sessions to local storage.
  void removeGameSession(int index) {
    gameList.removeAt(index);
    notifyListeners();
    LocalStorageService.saveGameSessions();
  }
}

final globals = GameManager();
