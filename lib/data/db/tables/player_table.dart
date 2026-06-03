import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:drift/drift.dart';

class PlayerTable extends Table {
  late final playerId = text()();
  late final gameId = text().references(
    GameSessionTable,
    #gameId,
    onDelete: KeyAction.cascade,
  )();
  late final totalScore = integer()();
  late final position = integer()();
  late final name = text()();

  @override
  Set<Column<Object>> get primaryKey => {playerId};
}
