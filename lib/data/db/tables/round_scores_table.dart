import 'package:cabo_counter/data/db/tables/rounds_table.dart';
import 'package:drift/drift.dart';

class RoundScoresTable extends Table {
  TextColumn get roundId =>
      text().references(RoundsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get playerName => text()();
  IntColumn get score => integer()();
  IntColumn get scoreUpdate => integer()();

  @override
  Set<Column<Object>> get primaryKey => {roundId, playerName};
}
