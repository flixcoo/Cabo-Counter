import 'dart:convert';
import 'dart:io';

import 'package:cabo_counter/data/game_session.dart';
import 'package:cabo_counter/utility/globals.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/services.dart';
import 'package:json_schema/json_schema.dart';
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
  static Future<bool> loadGameSessions() async {
    print('Versuche, Daten zu laden...');
    try {
      final file = await _getFilePath();

      if (!await file.exists()) {
        print('Es existiert noch keine Datei mit Spieldaten');
        return false;
      }

      print('Es existiert bereits eine Datei mit Spieldaten');
      final jsonString = await file.readAsString();

      if (jsonString.isEmpty) {
        print('Die gefundene Datei ist leer');
        return false;
      }

      if (!await validateJsonSchema(jsonString)) {
        print('Die Datei konnte nicht validiert werden');
        Globals.gameList = [];
        return false;
      }

      print('Die gefundene Datei ist nicht leer und validiert');
      final jsonList = json.decode(jsonString) as List<dynamic>;

      Globals.gameList = jsonList
          .map((jsonItem) =>
              GameSession.fromJson(jsonItem as Map<String, dynamic>))
          .toList();

      print('Die Daten wurden erfolgreich geladen und verarbeitet');
      return true;
    } catch (e) {
      print('Fehler beim Laden der Spieldaten:\n$e');
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
      print('Datei gespeichert: $result');
      return true;
    } catch (e) {
      print('Fehler beim Speichern: $e');
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
      print('Der Dialog wurde abgebrochen');
      return false;
    }

    try {
      final jsonString = await _readFileContent(result.files.single);

      if (!await validateJsonSchema(jsonString)) {
        return false;
      }
      final jsonData = json.decode(jsonString) as List<dynamic>;
      print('JSON Inhalt: $jsonData');
      Globals.gameList = jsonData
          .map((jsonItem) =>
              GameSession.fromJson(jsonItem as Map<String, dynamic>))
          .toList();
      return true;
    } on FormatException catch (e) {
      print('Ungültiges JSON-Format: $e');
      return false;
    } on Exception catch (e) {
      print('Fehler beim Dateizugriff: $e');
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
        print('JSON ist erfolgreich validiert.');
        return true;
      }
      print('JSON ist nicht gültig: ${result.errors}');
      return false;
    } catch (e) {
      print('Fehler beim Validieren des JSON-Schemas: $e');
      return false;
    }
  }
}
