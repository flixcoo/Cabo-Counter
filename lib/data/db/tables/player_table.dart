import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:drift/drift.dart';

class PlayerTable extends Table {
  TextColumn get id => text()();
  TextColumn get gameSessionId =>
      text().references(GameSessionTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get totalScore => integer()();
  IntColumn get position => integer()();
  TextColumn get name => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
