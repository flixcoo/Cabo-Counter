import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:cabo_counter/data/db/tables/player_scores.dart';
import 'package:cabo_counter/data/db/tables/players_table.dart';
import 'package:cabo_counter/data/db/tables/round_scores_table.dart';
import 'package:cabo_counter/data/db/tables/rounds_table.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  GameSessionTable,
  PlayerScoresTable,
  PlayersTable,
  RoundScoresTable,
  RoundsTable
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'cabo-counter_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
