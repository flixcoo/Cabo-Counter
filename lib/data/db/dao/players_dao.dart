import 'package:cabo_counter/data/db/database.dart';
import 'package:drift/drift.dart';

part 'players_dao.g.dart';

@DriftAccessor(tables: [])
class PlayersDao extends DatabaseAccessor<AppDatabase> with _$PlayersDaoMixin {
  PlayersDao(super.db);
}
