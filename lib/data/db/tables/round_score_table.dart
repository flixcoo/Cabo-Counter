import 'package:cabo_counter/data/db/tables/player_table.dart';
import 'package:cabo_counter/data/db/tables/round_table.dart';
import 'package:drift/drift.dart';

class RoundScoreTable extends Table {
  TextColumn get roundId =>
      text().references(RoundTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get playerId =>
      text().references(PlayerTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get score => integer()();
  IntColumn get scoreUpdate => integer()();

  @override
  Set<Column<Object>> get primaryKey => {roundId, playerId};
}
