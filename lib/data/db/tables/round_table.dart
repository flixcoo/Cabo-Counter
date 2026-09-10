import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:drift/drift.dart';

class RoundTable extends Table {
  TextColumn get id => text()();
  TextColumn get gameSessionId =>
      text().references(GameSessionTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get roundNumber => integer()();
  IntColumn get caboPlayerIndex => integer()();
  IntColumn get kamikazePlayerIndex => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
