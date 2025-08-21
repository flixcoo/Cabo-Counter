import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:cabo_counter/data/db/tables/players_table.dart';
import 'package:drift/drift.dart';

class PlayerScoresTable extends Table {
  TextColumn get roundId =>
      text().references(GameSessionTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get playerName => text().references(PlayersTable, #name)();
  IntColumn get totalScore => integer()();

  @override
  Set<Column<Object>> get primaryKey => {roundId, playerName};
}
