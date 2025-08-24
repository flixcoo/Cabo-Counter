import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:drift/drift.dart';

class PlayerTable extends Table {
  TextColumn get playerId => text()();
  TextColumn get gameId => text()
      .references(GameSessionTable, #gameId, onDelete: KeyAction.cascade)();
  IntColumn get totalScore => integer()();
  IntColumn get position => integer()();
  TextColumn get name => text()();

  @override
  Set<Column<Object>> get primaryKey => {playerId};
}
