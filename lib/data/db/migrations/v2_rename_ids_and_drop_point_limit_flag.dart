import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/db/migrations/migration_strategy.dart';
import 'package:drift/drift.dart';

/// v1 -> v2
/// - Drops `isPointsLimitEnabled` and folds it into a nullable `pointLimit`.
/// - Renames the primary keys / foreign keys to the new naming scheme
///   (`id`, `gameSessionId`).
/// - Renames the tables `rounds_table` -> `round_table` and
///   `round_scores_table` -> `round_score_table`.
class V2RenameIdsAndDropPointLimitFlag extends Migration {
  const V2RenameIdsAndDropPointLimitFlag();

  @override
  int get to => 2;

  @override
  Future<void> apply(AppDatabase db, Migrator migrator) async {
    // Rename GameSessionTable.gameId -> id
    await db.customStatement(
      'ALTER TABLE game_session_table RENAME COLUMN game_id TO id',
    );

    // Deleting isPointLimitEnabled
    await migrator.alterTable(
      TableMigration(
        db.gameSessionTable,
        columnTransformer: {
          db.gameSessionTable.pointLimit: const CustomExpression<int>(
            'CASE WHEN is_points_limit_enabled THEN point_limit ELSE NULL END',
          ),
        },
      ),
    );

    // Rename PlayerTable.playerId -> id
    await db.customStatement(
      'ALTER TABLE player_table RENAME COLUMN player_id TO id',
    );

    // Rename PlayerTable.gameId -> gameSessionId
    await db.customStatement(
      'ALTER TABLE player_table RENAME COLUMN game_id TO game_session_id',
    );

    // Rename RoundsTable.roundId -> id
    await db.customStatement(
      'ALTER TABLE rounds_table RENAME COLUMN round_id TO id',
    );

    // Rename RoundsTable.gameId -> gameSessionId
    await db.customStatement(
      'ALTER TABLE rounds_table RENAME COLUMN game_id TO game_session_id',
    );

    // Rename table RoundsTable -> RoundTable
    await db.customStatement('ALTER TABLE rounds_table RENAME TO round_table');

    // Rename table RoundScoresTable -> RoundScoreTable
    await db.customStatement(
      'ALTER TABLE round_scores_table RENAME TO round_score_table',
    );
  }
}
