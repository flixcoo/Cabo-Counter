import 'dart:convert';
import 'dart:io';

import 'package:cabo_counter/data/dto/game_manager.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/services.dart';
import 'package:json_schema/json_schema.dart';

enum ImportStatus {
  success,
  canceled,
  validationError,
  formatError,
  genericError
}

class DataTransferService {
  /// Writes the game session list to a JSON file and returns it as string.
  static String _getGameDataAsJsonFile() {
    final jsonFile =
        gameManager.gameList.map((session) => session.toJson()).toList();
    return json.encode(jsonFile);
  }

  /// Opens the file picker to export game data as a JSON file.
  /// This method will export the given [jsonString] as a JSON file. It opens
  /// the file picker with the choosen [fileName].
  static Future<bool> _exportJsonData(
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
        print('[data_transfer_service.dart]: Export abgebrochen');
      } else {
        print(
            '[data_transfer_service.dart] Die Spieldaten wurden exportiert. Dateipfad: $path');
      }
      return true;
    } catch (e) {
      print(
          '[data_transfer_service.dart] Fehler beim Exportieren der Spieldaten. Exception: $e');
      return false;
    }
  }

  /// Opens the file picker to export all game sessions as a JSON file.
  static Future<bool> exportGameData() async {
    String jsonString = _getGameDataAsJsonFile();
    String fileName = 'cabo_counter-game_data';
    return _exportJsonData(jsonString, fileName);
  }

  /// Opens the file picker to save a single game session as a JSON file.
  static Future<bool> exportSingleGameSession(GameSession session) async {
    String jsonString = json.encode(session.toJson());
    String fileName = 'cabo_counter-game_${session.gameId.substring(0, 7)}';
    return _exportJsonData(jsonString, fileName);
  }

  /// Opens the file picker to import a JSON file and loads the game data from it.
  static Future<ImportStatus> importJsonFile() async {
    final path = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (path == null) {
      print(
          '[data_transfer_service.dart] Der Filepicker-Dialog wurde abgebrochen');
      return ImportStatus.canceled;
    }

    try {
      final jsonString = await _readFileContent(path.files.single);

      // Checks if the JSON String is in the gameList format
      if (await _validateJsonSchema(jsonString, true)) {
        final jsonData = json.decode(jsonString) as List<dynamic>;
        List<GameSession> importedList = jsonData
            .map((jsonItem) =>
                GameSession.fromJson(jsonItem as Map<String, dynamic>))
            .toList();

        for (GameSession s in importedList) {
          _importSession(s);
        }
      } else if (await _validateJsonSchema(jsonString, false)) {
        // Checks if the JSON String is in the single game format
        final jsonData = json.decode(jsonString) as Map<String, dynamic>;
        _importSession(GameSession.fromJson(jsonData));
      } else {
        return ImportStatus.validationError;
      }

      print(
          '[data_transfer_service.dart] Die Datei wurde erfolgreich Importiert');
      return ImportStatus.success;
    } on FormatException catch (e) {
      print(
          '[data_transfer_service.dart] Ungültiges JSON-Format. Exception: $e');
      return ImportStatus.formatError;
    } on Exception catch (e) {
      print(
          '[data_transfer_service.dart] Fehler beim Dateizugriff. Exception: $e');
      return ImportStatus.genericError;
    }
  }

  /// Imports a single game session into the gameList.
  static Future<void> _importSession(GameSession session) async {
    if (gameManager.gameExistsInGameList(session.gameId)) {
      print(
          '[data_transfer_service.dart] Die Session mit der ID ${session.gameId} existiert bereits. Sie wird überschrieben.');
      gameManager.deleteGameById(session.gameId);
    }
    gameManager.addGameSession(session);
    print(
        '[data_transfer_service.dart] Die Session mit der ID ${session.gameId} wurde erfolgreich importiert.');
  }

  /// Helper method to read file content from either bytes or path
  static Future<String> _readFileContent(PlatformFile file) async {
    if (file.bytes != null) return utf8.decode(file.bytes!);
    if (file.path != null) return await File(file.path!).readAsString();

    throw Exception('Die Datei hat keinen lesbaren Inhalt');
  }

  /// Validates the JSON data against the schema.
  /// This method checks if the provided [jsonString] is valid against the
  /// JSON schema. It takes a boolean [isGameList] to determine
  /// which schema to use (game list or single game).
  static Future<bool> _validateJsonSchema(
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
        print(
            '[data_transfer_service.dart] JSON ist erfolgreich validiert. Typ: ${isGameList ? 'Game List' : 'Single Game'}');
        return true;
      }
      print(
          '[data_transfer_service.dart] JSON ist nicht gültig.\nFehler: ${result.errors}');
      return false;
    } catch (e) {
      print(
          '[data_transfer_service.dart] Fehler beim Validieren des JSON-Schemas: $e');
      return false;
    }
  }
}
