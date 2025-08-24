import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class GameManager extends ChangeNotifier {
  List<GameSession> gameList = [];

  /// Adds a new game session to the list and sorts it by creation date.
  /// Takes a [GameSession] object as input. It then adds the session to the `gameList`,
  /// sorts the list in descending order based on the creation date, and notifies listeners of the change.
  /// It also saves the updated game sessions to local storage.
  /// Returns the index of the newly added session in the sorted list.
  int addGameSession(GameSession session, AppDatabase db) {
    session.addListener(() {
      notifyListeners(); // Propagate session changes
    });
    gameList.add(session);
    gameList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    notifyListeners();
    LocalStorageService.saveGameSessions();
    db.gameSessionDao.insertGameSession(session);
    return gameList.indexOf(session);
  }

  void addGameSessionFromDataBase(GameSession session) {
    session.addListener(() {
      notifyListeners();
    });
    gameList.add(session);
    gameList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    notifyListeners();
  }

  /// Retrieves a game session by its id.
  /// Takes a String [id] as input. It searches the `gameList` for a session
  /// with a matching id and returns it if found.
  /// If no session is found, it returns null.
  GameSession? getGameSessionById(String id) {
    return gameList.firstWhereOrNull((session) => session.gameId == id);
  }

  /// Removes a game session by its ID.
  /// Takes a String [id] as input. It removes the game session with the matching id
  /// from the `gameList`, deletes it from the database, and notifies listeners of the change.
  /// If no session with the given ID exists, the method does nothing.
  void removeGameSessionById(String id) {
    gameList.removeWhere((session) => session.gameId == id);
    db.gameSessionDao.deleteGameSession(id);
    notifyListeners();
  }

  /// Retrieves a game session by its ID.
  /// Takes a String [id] as input. It finds the game session with the matching id
  bool gameExistsInGameList(String id) {
    return gameList.any((session) => session.gameId.toString() == id);
  }

  /// Ends a game session if its in unlimited mode.
  /// Takes a String [gameId] as input. It finds the index of the game
  /// session with the matching ID marks it as finished,
  void endGame(String gameId) {
    final int index =
        gameList.indexWhere((session) => session.gameId.toString() == gameId);

    // Game session not found or not in unlimited mode
    if (index == -1 || gameList[index].isPointsLimitEnabled == true) return;

    gameList[index].endGame();
    db.gameSessionDao.endGame(gameId);
    notifyListeners();
    LocalStorageService.saveGameSessions();
  }
}

final gameManager = GameManager();
