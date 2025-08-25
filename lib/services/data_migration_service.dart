import 'dart:convert';
import 'dart:io';

import 'package:cabo_counter/data/dto/game_manager.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/services/data_transfer_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class DataMigrationService {
  static const String _fileName = 'game_data.json';

  /// Returns the path to the local JSON file.
  static Future<File> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$_fileName';
    print(path);
    return File(path);
  }

  /// Loads old game data from a local JSON file, migrates it to the new format,
  /// validates it, and adds it to the game manager.
  /// Returns a map with the result of the operation:
  /// - 'success': 1 if successful, 0 if no file found, -1 if error
  /// - 'gameCount': number of games loaded (only if successful)
  /// If no file is found, returns {'success': 0}.
  /// If an error occurs, returns {'success': -1}.
  static Future<Map<String, dynamic>> loadOldGameData() async {
    try {
      final file = await _getFilePath();

      if (!await file.exists()) {
        return {'success': 0};
      }

      final jsonString = await file.readAsString();
      if (jsonString.isEmpty) {
        return {'success': -1};
      }
      final migratedJsonString = _migrateJsonData(jsonString);
      if (!await DataTransferService.validateJsonSchema(
          migratedJsonString, true)) {
        return {'success': -1};
      }

      final jsonList = json.decode(migratedJsonString) as List<dynamic>;

      final gameList = jsonList
          .map((jsonItem) =>
              GameSession.fromJson(jsonItem as Map<String, dynamic>))
          .toList();

      for (GameSession session in gameList) {
        if (gameManager.gameExistsInGameList(session.gameId)) {
          gameManager.deleteGameById(session.gameId);
        }
        gameManager.addGameSession(session);
      }
      await _deleteOldGameDataFile();
      return {'success': 1, 'gameCount': gameList.length};
    } catch (e, stack) {
      print('$e\n$stack');
      return {'success': -1};
    }
  }

  /// Deletes the old game data file after successful migration.
  static Future<void> _deleteOldGameDataFile() async {
    try {
      final file = await _getFilePath();
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e, stack) {
      print('$e\n$stack');
    }
  }

  /// Migrates old JSON data to the new format.
  /// This function assumes the old format has:
  /// - A list of player names in 'players'
  /// - A list of player scores in 'playerScores'
  /// - A list of rounds in 'roundList' without unique IDs
  /// The new format will have:
  /// - A list of player objects with unique IDs and additional fields
  /// - Each round will have a unique 'roundId' and 'gameId'
  /// - The 'playerScores' field will be removed
  /// Returns the migrated JSON string.
  static String _migrateJsonData(String jsonString) {
    final List<dynamic> oldGameList = jsonDecode(jsonString);

    const uuid = Uuid();
    final migrated = oldGameList.map((game) {
      final gameId = game['id'] ?? uuid.v4();
      final players = _migratePlayers(game, gameId);
      final migratedRounds = _migrateRounds(game, gameId);

      final newGame = Map<String, dynamic>.from(game);
      newGame['players'] = players;
      newGame['roundList'] = migratedRounds;
      newGame.remove('playerScores');
      return newGame;
    }).toList();

    final migratedJsonString =
        const JsonEncoder.withIndent('  ').convert(migrated);

    return migratedJsonString;
  }

  /// Migrates old player data to include unique IDs and gameId.
  /// If a player already has a 'playerId' and 'gameId', they are
  /// kept. Otherwise, new IDs are generated.
  /// Returns the list of migrated players.
  static List<Map<String, Object>> _migratePlayers(
      dynamic game, String gameId) {
    const uuid = Uuid();
    final playerNames = List<String>.from(game['players']);
    final playerScores = List<int>.from(game['playerScores']);

    final players = List.generate(
      playerNames.length,
      (i) => {
        'playerId': uuid.v4(),
        'gameId': gameId,
        'name': playerNames[i],
        'position': i,
        'totalScore': playerScores[i],
      },
    );
    return players;
  }

  /// Migrates old rounds to include unique IDs and gameId.
  /// If a round already has a 'roundId' and 'gameId', they are kept.
  /// Otherwise, new IDs are generated.
  /// Returns the list of migrated rounds.
  static List<Map<String, dynamic>> _migrateRounds(
      dynamic game, String gameId) {
    const uuid = Uuid();
    final oldRounds = (game['roundList'] as List<dynamic>? ?? []);

    final migratedRounds = oldRounds.map((round) {
      final newRound = Map<String, dynamic>.from(round ?? {});
      newRound['roundId'] = (newRound['roundId'] is String &&
              (newRound['roundId'] as String).isNotEmpty)
          ? newRound['roundId']
          : uuid.v4();
      newRound['gameId'] = (newRound['gameId'] is String &&
              (newRound['gameId'] as String).isNotEmpty)
          ? newRound['gameId']
          : gameId;
      return newRound;
    }).toList();

    return migratedRounds;
  }
}
