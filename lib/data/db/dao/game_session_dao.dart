import 'package:cabo_counter/data/db/database.dart';
import 'package:drift/drift.dart';

part 'game_session_dao.g.dart';

@DriftAccessor(tables: [])
class GameSessionDao extends DatabaseAccessor<AppDatabase>
    with _$GameSessionDaoMixin {
  GameSessionDao(super.db);
}
