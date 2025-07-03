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

  /// Writes the game session list to a  JSON file and returns it as string.
  static String getJsonFile() {
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
      final jsonFile = getJsonFile();
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

      if (!await validateJsonSchema(jsonString)) {
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
      print(
          '[local_storage_service.dart] Die Spieldaten wurden exportiert. Dateipfad: $result');
      return true;
    } catch (e) {
      print(
          '[local_storage_service.dart] Fehler beim Exportieren der Spieldaten. Exception: $e');
      return false;
    }
  }

  /// Opens the file picker to import a JSON file and loads the game data from it.
  static Future<ImportStatus> importJsonFile() async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Wähle eine Datei mit Spieldaten aus',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null) {
      print(
          '[local_storage_service.dart] Der Filepicker-Dialog wurde abgebrochen');
      return ImportStatus.canceled;
    }

    try {
      final jsonString = await _readFileContent(result.files.single);

      if (!await validateJsonSchema(jsonString)) {
        return ImportStatus.validationError;
      }
      final jsonData = json.decode(jsonString) as List<dynamic>;
      gameManager.gameList = jsonData
          .map((jsonItem) =>
              GameSession.fromJson(jsonItem as Map<String, dynamic>))
          .toList();
      print(
          '[local_storage_service.dart] Die Datei wurde erfolgreich Importiertn');
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

  /// Helper method to read file content from either bytes or path
  static Future<String> _readFileContent(PlatformFile file) async {
    if (file.bytes != null) return utf8.decode(file.bytes!);
    if (file.path != null) return await File(file.path!).readAsString();

    throw Exception('Die Datei hat keinen lesbaren Inhalt');
  }

  /// Validates the JSON data against the schema.
  static Future<bool> validateJsonSchema(String jsonString) async {
    try {
      final schemaString = await rootBundle.loadString('assets/schema.json');
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
