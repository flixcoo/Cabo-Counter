import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:drift/drift.dart';

class RoundsTable extends Table {
  TextColumn get roundId => text()();
  TextColumn get gameId =>
      text().references(GameSessionTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get roundNumber => integer()();
  TextColumn get kamikazePlayer => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {roundId};
}
