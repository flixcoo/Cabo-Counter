import 'package:cabo_counter/data/db/database.dart';
import 'package:drift/drift.dart';

part 'player_scores_dao.g.dart';

@DriftAccessor(tables: [])
class PlayerScoresDao extends DatabaseAccessor<AppDatabase>
    with _$PlayerScoresDaoMixin {
  PlayerScoresDao(super.db);
}
