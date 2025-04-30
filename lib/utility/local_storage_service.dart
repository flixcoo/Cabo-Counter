import 'dart:convert';
import 'dart:io';

import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/utility/globals.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  static const String _fileName = 'game_data.json';

  /// Speichert GameSessions im App-Dokumentenverzeichnis
  static Future<void> saveGameSessions() async {
    try {
      final file = await _getLocalFile();
      final jsonFile = getJsonFile();
      await file.writeAsString(jsonFile);
      print('Daten gespeichert');
    } catch (e) {
      print('Fehler beim Speichern: $e');
    }
  }

  /// Lädt GameSessions aus dem App-Dokumentenverzeichnis
  static Future<void> loadGameSessions() async {
    print('Versuche, Daten zu laden...'); // FIXME Debug-Ausgabe
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        print('Datei existiert'); // FIXME Debug-Ausgabe
        final jsonString = await file.readAsString();
        if (jsonString.isNotEmpty) {
          print('Datei ist nicht leer'); // FIXME Debug-Ausgabe
          final jsonList = json.decode(jsonString) as List<dynamic>;
          print('JSON: $jsonList'); // FIXME Debug-Ausgabe
          Globals.gameList =
              jsonList.map((json) => GameSession.fromJson(json)).toList();
          print('Daten erfolgreich geladen');
        } else {
          print('Datei ist leer');
        }
      } else {
        print('Datei existiert nicht');
      }
    } catch (e) {
      print('Fehler beim Laden: $e');
      // Bei Fehler eine leere Liste setzen
      Globals.gameList = [];
    }
  }

  static String getJsonFile() {
    final jsonFile =
        Globals.gameList.map((session) => session.toJson()).toList();
    return json.encode(jsonFile);
  }

  static Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$_fileName';
    print('Speicherpfad: $path'); // FIXME Debug-Ausgabe
    return File(path);
  }
}
