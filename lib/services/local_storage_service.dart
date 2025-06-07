import 'dart:convert';
import 'dart:io';

import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/utility/globals.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/services.dart';
import 'package:json_schema/json_schema.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  static const String _fileName = 'game_data.json';
  static var logger = Logger(
    printer: PrettyPrinter(),
  );

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
      logger.i('Die Spieldaten wurden zwischengespeichert.');
    } catch (e) {
      logger.w('Fehler beim Speichern der Spieldaten. Exception: $e');
    }
  }

  /// Loads the game data from a local JSON file.
  static Future<bool> loadGameSessions() async {
    logger.d('Versuche, Daten zu laden...');
    try {
      final file = await _getFilePath();

      if (!await file.exists()) {
        logger.w('Es existiert noch keine Datei mit Spieldaten');
        return false;
      }

      logger.d('Es existiert bereits eine Datei mit Spieldaten');
      final jsonString = await file.readAsString();

      if (jsonString.isEmpty) {
        logger.w('Die gefundene Datei ist leer');
        return false;
      }

      if (!await validateJsonSchema(jsonString)) {
        logger.w('Die Datei konnte nicht validiert werden');
        Globals.gameList = [];
        return false;
      }
      logger.d('Die gefundene Datei hat Inhalt');
      logger.d('Die gefundene Datei wurde erfolgreich validiert');
      final jsonList = json.decode(jsonString) as List<dynamic>;

      Globals.gameList = jsonList
          .map((jsonItem) =>
              GameSession.fromJson(jsonItem as Map<String, dynamic>))
          .toList();

      logger.i('Die Spieldaten wurden erfolgreich geladen und verarbeitet');
      return true;
    } catch (e) {
      logger.e('Fehler beim Laden der Spieldaten:\n$e',
          error: 'JSON nicht geladen');
      Globals.gameList = [];
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
      logger.i('Die Spieldaten wurden exportiert. Dateipfad: $result');
      return true;
    } catch (e) {
      logger.w('Fehler beim Exportieren der Spieldaten. Exception: $e',
          error: 'JSON nicht exportiert');
      return false;
    }
  }

  /// Opens the file picker to import a JSON file and loads the game data from it.
  static Future<bool> importJsonFile() async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Wähle eine Datei mit Spieldaten aus',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null) {
      logger.d('Der Filepicker-Dialog wurde abgebrochen');
      return false;
    }

    try {
      final jsonString = await _readFileContent(result.files.single);

      if (!await validateJsonSchema(jsonString)) {
        return false;
      }
      final jsonData = json.decode(jsonString) as List<dynamic>;
      Globals.gameList = jsonData
          .map((jsonItem) =>
              GameSession.fromJson(jsonItem as Map<String, dynamic>))
          .toList();
      logger.i('Die Datei wurde erfolgreich Importiertn');
      return true;
    } on FormatException catch (e) {
      logger.e('Ungültiges JSON-Format. Exception: $e', error: 'Formatfehler');
      return false;
    } on Exception catch (e) {
      logger.e('Fehler beim Dateizugriff. Exception: $e',
          error: 'Dateizugriffsfehler');
      return false;
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
        logger.d('JSON ist erfolgreich validiert.');
        return true;
      }
      logger.w('JSON ist nicht gültig.\nFehler: ${result.errors}');
      return false;
    } catch (e) {
      logger.e('Fehler beim Validieren des JSON-Schemas: $e',
          error: 'Validierung fehlgeschlagen');
      return false;
    }
  }

  static Future<bool> deleteAllGames() async {
    try {
      Globals.gameList.clear();
      await saveGameSessions();
      logger.i('Alle Runden wurden erfolgreich gelöscht.');
      return true;
    } catch (e) {
      logger.e('Fehler beim Löschen aller Runden: $e',
          error: 'Löschen fehlgeschlagen');
      return false;
    }
  }
}
