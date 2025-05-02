import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/utility/globals.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  static const String _fileName = 'game_data.json';

  /// Writes the game session list to a  JSON file and returns it as string.
  static String getJsonFile() {
    final jsonFile =
        Globals.gameList.map((session) => session.toJson()).toList();
    return json.encode(jsonFile);
  }

  /// Returns the path to the local JSON file.
  static Future<File> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$_fileName';
    return File(path);
  }

  /// Saves the game sessions to a local JSON file.
  static Future<void> saveGameSessions() async {
    try {
      final file = await _getFilePath();
      final jsonFile = getJsonFile();
      await file.writeAsString(jsonFile);
      print('Daten gespeichert');
    } catch (e) {
      print('Fehler beim Speichern: $e');
    }
  }

  /// Loads the game data from a local JSON file.
  static Future<void> loadGameSessions() async {
    print('Versuche, Daten zu laden...');
    try {
      final file = await _getFilePath();
      if (await file.exists()) {
        print('Es existiert bereits eine Datei mit Spieldaten');
        final jsonString = await file.readAsString();
        if (jsonString.isNotEmpty) {
          print('Die gefundene Datei ist nicht leer');
          final jsonList = json.decode(jsonString) as List<dynamic>;
          Globals.gameList = jsonList
              .map((jsonItem) =>
                  GameSession.fromJson(jsonItem as Map<String, dynamic>))
              .toList()
              .cast<GameSession>();
          print('Die Daten wurden erfolgreich geladen');
        } else {
          print('Die Datei ist leer');
        }
      } else {
        print('Es existiert bisher noch keine Datei mit Spieldaten');
      }
    } catch (e) {
      print('Fehler beim Laden der Spieldaten:\n$e');
      Globals.gameList = [];
    }
  }

  /// Opens the file picker to save a JSON file with the current game data.
  static Future<bool> exportJsonFile() async {
    final jsonString = getJsonFile();
    try {
      final bytes = Uint8List.fromList(utf8.encode(jsonString));
      final result = await FileSaver.instance.saveAs(
        name: 'cabo_counter_data',
        bytes: bytes,
        ext: 'json',
        mimeType: MimeType.json,
      );
      print('Datei gespeichert: $result');
      return true;
    } catch (e) {
      print('Fehler beim Speichern: $e');
      return false;
    }
  }

  /// Opens the file picker to import a JSON file and loads the game data from it.
  static Future<bool> importJsonFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Wähle eine Datei mit Spieldaten aus',
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      String jsonString = '';
      if (result != null) {
        if (result.files.single.bytes != null) {
          final Uint8List fileBytes = result.files.single.bytes!;
          jsonString = utf8.decode(fileBytes);
        } else if (result.files.single.path != null) {
          final file = File(result.files.single.path!);
          jsonString = await file.readAsString();
        }
        final jsonList = json.decode(jsonString) as List<dynamic>;
        print('JSON Inhalt: $jsonList');
        Globals.gameList = jsonList
            .map((jsonItem) =>
                GameSession.fromJson(jsonItem as Map<String, dynamic>))
            .toList();
        return true;
      } else {
        print('Der Dialog wurde abgebrochen');
        return true;
      }
    } catch (e) {
      print('Fehler beim Importieren: $e');
      return false;
    }
  }
}
