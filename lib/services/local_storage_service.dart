import 'dart:convert';
import 'dart:io';

import 'package:cabo_counter/data/game_manager.dart';
import 'package:cabo_counter/data/game_session.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/services.dart';
import 'package:json_schema/json_schema.dart';
import 'package:path_provider/path_provider.dart';

enum ImportStatus {
  success,
  canceled,
  validationError,
  formatError,
  genericError
}

class LocalStorageService {
  static const String _fileName = 'game_data.json';

  /// Writes the game session list to a JSON file and returns it as string.
  static String getGameDataAsJsonFile() {
    final jsonFile =
        gameManager.gameList.map((session) => session.toJson()).toList();
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
    print('[local_storage_service.dart] Versuche, Daten zu speichern...');
    try {
      final file = await _getFilePath();
      final jsonFile = getGameDataAsJsonFile();
      await file.writeAsString(jsonFile);
      print(
          '[local_storage_service.dart] Die Spieldaten wurden zwischengespeichert.');
    } catch (e) {
      print(
          '[local_storage_service.dart] Fehler beim Speichern der Spieldaten. Exception: $e');
    }
  }

  /// Loads the game data from a local JSON file.
  static Future<bool> loadGameSessions() async {
    print('[local_storage_service.dart] Versuche, Daten zu laden...');
    try {
      final file = await _getFilePath();

      if (!await file.exists()) {
        print(
            '[local_storage_service.dart] Es existiert noch keine Datei mit Spieldaten');
        return false;
      }

      print(
          '[local_storage_service.dart] Es existiert bereits eine Datei mit Spieldaten');
      final jsonString = await file.readAsString();

      if (jsonString.isEmpty) {
        print('[local_storage_service.dart] Die gefundene Datei ist leer');
        return false;
      }

      if (!await validateJsonSchema(jsonString, true)) {
        print(
            '[local_storage_service.dart] Die Datei konnte nicht validiert werden');
        gameManager.gameList = [];
        return false;
      }
      print('[local_storage_service.dart] Die gefundene Datei hat Inhalt');
      print(
          '[local_storage_service.dart] Die gefundene Datei wurde erfolgreich validiert');
      final jsonList = json.decode(jsonString) as List<dynamic>;

      gameManager.gameList = jsonList
          .map((jsonItem) =>
              GameSession.fromJson(jsonItem as Map<String, dynamic>))
          .toList();

      for (GameSession session in gameManager.gameList) {
        print(
            '[local_storage_service.dart] Geladene Session: ${session.gameTitle} - ${session.id}');
      }

      print(
          '[local_storage_service.dart] Die Spieldaten wurden erfolgreich geladen und verarbeitet');
      return true;
    } catch (e) {
      print(
          '[local_storage_service.dart] Fehler beim Laden der Spieldaten:\n$e');
      gameManager.gameList = [];
      return false;
    }
  }

  /// Opens the file picker to export game data as a JSON file.
  /// This method will export the given [jsonString] as a JSON file. It opens
  /// the file picker with the choosen [fileName].
  static Future<bool> exportJsonData(
    String jsonString,
    String fileName,
  ) async {
    try {
      final bytes = Uint8List.fromList(utf8.encode(jsonString));
      final path = await FileSaver.instance.saveAs(
        name: fileName,
        bytes: bytes,
        ext: 'json',
        mimeType: MimeType.json,
      );
      if (path == null) {
        print('[local_storage_service.dart]: Export abgebrochen');
      } else {
        print(
            '[local_storage_service.dart] Die Spieldaten wurden exportiert. Dateipfad: $path');
      }
      return true;
    } catch (e) {
      print(
          '[local_storage_service.dart] Fehler beim Exportieren der Spieldaten. Exception: $e');
      return false;
    }
  }

  /// Opens the file picker to export all game sessions as a JSON file.
  static Future<bool> exportGameData() async {
    String jsonString = getGameDataAsJsonFile();
    String fileName = 'cabo_counter-game_data';
    return exportJsonData(jsonString, fileName);
  }

  /// Opens the file picker to save a single game session as a JSON file.
  static Future<bool> exportSingleGameSession(GameSession session) async {
    String jsonString = json.encode(session.toJson());
    String fileName = 'cabo_counter-game_${session.id.substring(0, 7)}';
    return exportJsonData(jsonString, fileName);
  }

  /// Opens the file picker to import a JSON file and loads the game data from it.
  static Future<ImportStatus> importJsonFile() async {
    final path = await FilePicker.platform.pickFiles(
      dialogTitle: 'Wähle eine Datei mit Spieldaten aus',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (path == null) {
      print(
          '[local_storage_service.dart] Der Filepicker-Dialog wurde abgebrochen');
      return ImportStatus.canceled;
    }

    try {
      final jsonString = await _readFileContent(path.files.single);
      final jsonData = json.decode(jsonString) as List<dynamic>;

      if (await validateJsonSchema(jsonString, true)) {
        print(
            '[local_storage_service.dart] Die Datei wurde erfolgreich als Liste validiert');
        List<GameSession> tempList = jsonData
            .map((jsonItem) =>
                GameSession.fromJson(jsonItem as Map<String, dynamic>))
            .toList();

        for (GameSession s in tempList) {
          importSession(s);
        }
      } else if (await validateJsonSchema(jsonString, false)) {
        print(
            '[local_storage_service.dart] Die Datei wurde erfolgreich als einzelnes Spiel validiert');
        importSession(GameSession.fromJson(jsonData as Map<String, dynamic>));
      } else {
        return ImportStatus.validationError;
      }

      print(
          '[local_storage_service.dart] Die Datei wurde erfolgreich Importiert');
      await saveGameSessions();
      return ImportStatus.success;
    } on FormatException catch (e) {
      print(
          '[local_storage_service.dart] Ungültiges JSON-Format. Exception: $e');
      return ImportStatus.formatError;
    } on Exception catch (e) {
      print(
          '[local_storage_service.dart] Fehler beim Dateizugriff. Exception: $e');
      return ImportStatus.genericError;
    }
  }

  /// Imports a single game session into the gameList.
  static Future<void> importSession(GameSession session) async {
    if (gameManager.gameList.any((s) => s.id == session.id)) {
      print(
          '[local_storage_service.dart] Die Session mit der ID ${session.id} existiert bereits. Sie wird aktualisiert.');
      gameManager.gameList.removeWhere((s) => s.id == session.id);
    }
    gameManager.gameList.add(session);
    print(
        '[local_storage_service.dart] Die Session mit der ID ${session.id} wurde erfolgreich importiert.');
  }

  /// Helper method to read file content from either bytes or path
  static Future<String> _readFileContent(PlatformFile file) async {
    if (file.bytes != null) return utf8.decode(file.bytes!);
    if (file.path != null) return await File(file.path!).readAsString();

    throw Exception('Die Datei hat keinen lesbaren Inhalt');
  }

  /// Validates the JSON data against the schema.
  static Future<bool> validateJsonSchema(
      String jsonString, bool isGameList) async {
    final String schemaString;

    if (isGameList) {
      schemaString =
          await rootBundle.loadString('assets/game_list-schema.json');
    } else {
      schemaString = await rootBundle.loadString('assets/game-schema.json');
    }

    try {
      final schema = JsonSchema.create(json.decode(schemaString));
      final jsonData = json.decode(jsonString);
      final result = schema.validate(jsonData);

      if (result.isValid) {
        print('[local_storage_service.dart] JSON ist erfolgreich validiert.');
        return true;
      }
      print(
          '[local_storage_service.dart] JSON ist nicht gültig.\nFehler: ${result.errors}');
      return false;
    } catch (e) {
      print(
          '[local_storage_service.dart] Fehler beim Validieren des JSON-Schemas: $e');
      return false;
    }
  }

  static Future<bool> deleteAllGames() async {
    try {
      gameManager.gameList.clear();
      await saveGameSessions();
      print(
          '[local_storage_service.dart] Alle Runden wurden erfolgreich gelöscht.');
      return true;
    } catch (e) {
      print(
          '[local_storage_service.dart] Fehler beim Löschen aller Runden: $e');
      return false;
    }
  }
}
