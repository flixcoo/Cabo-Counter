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
  daos: [GameSessionDao, PlayerDao, RoundsDao, RoundScoresDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (migrator, from, to) async {
        if (from < 3) {
          await migrator.alterTable(
            TableMigration(
              gameSessionTable,
              columnTransformer: {
                gameSessionTable.pointLimit: const CustomExpression<int>(
                  'CASE WHEN is_points_limit_enabled THEN point_limit ELSE NULL END',
                ),
              },
            ),
          );
        }
        if (from < 4) {
          await customStatement(
            'ALTER TABLE game_session_table RENAME COLUMN game_id TO id',
          );
          await customStatement(
            'ALTER TABLE player_table RENAME COLUMN player_id TO id',
          );
          await customStatement(
            'ALTER TABLE player_table RENAME COLUMN game_id TO game_session_id',
          );
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
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
