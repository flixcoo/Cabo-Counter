import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:drift/drift.dart';

class RoundsTable extends Table {
  late final roundId = text()();
  late final gameId = text().references(
    GameSessionTable,
    #gameId,
    onDelete: KeyAction.cascade,
  )();
  late final roundNumber = integer()();
  late final caboPlayerIndex = integer()();
  late final kamikazePlayerIndex = integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {roundId};
}
