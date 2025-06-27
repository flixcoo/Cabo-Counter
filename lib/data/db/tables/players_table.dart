import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:drift/drift.dart';

class PlayersTable extends Table {
  TextColumn get id =>
      text().references(GameSessionTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
}
