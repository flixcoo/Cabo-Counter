import 'package:cabo_counter/data/db/database.dart';
import 'package:drift/drift.dart';

/// A single, self-contained schema migration.
abstract class Migration {
  const Migration();

  /// The schema version this migration upgrades the database *to*.
  int get to;

  /// Applies the migration.
  Future<void> apply(AppDatabase db, Migrator migrator);
}
