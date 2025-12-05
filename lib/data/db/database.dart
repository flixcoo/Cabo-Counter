import 'package:cabo_counter/data/dao/game_session_dao.dart';
import 'package:cabo_counter/data/dao/player_dao.dart';
import 'package:cabo_counter/data/dao/round_scores_dao.dart';
import 'package:cabo_counter/data/dao/rounds_dao.dart';
import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:cabo_counter/data/db/tables/player_table.dart';
import 'package:cabo_counter/data/db/tables/round_scores_table.dart';
import 'package:cabo_counter/data/db/tables/rounds_table.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(
    tables: [GameSessionTable, PlayerTable, RoundScoresTable, RoundsTable],
    daos: [GameSessionDao, PlayerDao, RoundsDao, RoundScoresDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    });
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'cabo-counter_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}

final databaseInstance = AppDatabase();
