import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:flutter/foundation.dart';

class Globals extends ChangeNotifier {
  List<GameSession> gameList = [];
  int pointLimit = 100;
  int caboPenalty = 5;
  String appDevPhase = 'Alpha';

  void addGameSession(GameSession session) {
    gameList.add(session);
    gameList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    notifyListeners(); // Wichtig!
    LocalStorageService.saveGameSessions();
  }

  void removeGameSession(int index) {
    gameList.removeAt(index);
    notifyListeners(); // Wichtig!
    LocalStorageService.saveGameSessions();
  }
}

final globals = Globals(); // Globale Instanz
