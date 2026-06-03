import 'package:cabo_counter/data/db/tables/player_table.dart';
import 'package:cabo_counter/data/db/tables/rounds_table.dart';
import 'package:drift/drift.dart';

class RoundScoresTable extends Table {
  late final roundId = text().references(
    RoundsTable,
    #roundId,
    onDelete: KeyAction.cascade,
  )();
  late final playerId = text().references(
    PlayerTable,
    #playerId,
    onDelete: KeyAction.cascade,
  )();
  late final score = integer()();
  late final scoreUpdate = integer()();

  @override
  Set<Column<Object>> get primaryKey => {roundId, playerId};
}
