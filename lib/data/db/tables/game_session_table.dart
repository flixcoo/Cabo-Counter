import 'package:drift/drift.dart';

class GameSessionTable extends Table {
  late final gameId = text()();
  late final createdAt = dateTime()();
  late final gameTitle = text()();
  late final pointLimit = integer()();
  late final caboPenalty = integer()();
  late final isPointsLimitEnabled = boolean()();
  late final isGameFinished = boolean().withDefault(const Constant(false))();
  late final winner = text().nullable()();
  late final roundNumber = integer().withDefault(const Constant(1))();

  @override
  Set<Column<Object>> get primaryKey => {gameId};
}
