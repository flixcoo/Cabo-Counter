import 'package:drift/drift.dart';

class GameSessionTable extends Table {
  late final gameId = text()();
  late final createdAt = dateTime()();
  late final gameTitle = text()();
  late final pointLimit = integer()();
  late final caboPenalty = integer()();
  late final isPointsLimitEnabled = boolean()();
  late final isGameFinished = boolean()();
  late final winner = text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {gameId};
}
