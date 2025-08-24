import 'package:cabo_counter/data/db/tables/player_table.dart';
import 'package:cabo_counter/data/db/tables/rounds_table.dart';
import 'package:drift/drift.dart';

class RoundScoresTable extends Table {
  TextColumn get roundId =>
      text().references(RoundsTable, #roundId, onDelete: KeyAction.cascade)();
  TextColumn get playerId => text().references(PlayerTable, #playerId, onDelete: KeyAction.cascade)();
  IntColumn get score => integer()();
  IntColumn get scoreUpdate => integer()();

  @override
  Set<Column<Object>> get primaryKey => {roundId, playerId};
}
