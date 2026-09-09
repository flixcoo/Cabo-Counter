import 'package:drift/drift.dart';

class GameSessionTable extends Table {
  TextColumn get gameId => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get gameTitle => text()();
  IntColumn get pointLimit => integer().nullable()();
  IntColumn get caboPenalty => integer()();
  BoolColumn get isGameFinished => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {gameId};
}
