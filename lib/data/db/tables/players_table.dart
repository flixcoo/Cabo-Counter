import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:drift/drift.dart';

class PlayersTable extends Table {
  TextColumn get playerId =>
      text().references(GameSessionTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get position => integer()();
  TextColumn get name => text()();
}
