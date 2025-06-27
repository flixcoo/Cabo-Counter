import 'package:cabo_counter/data/db/database.dart';
import 'package:drift/drift.dart';

part 'round_scores_dao.g.dart';

@DriftAccessor(tables: [])
class RoundScoresDao extends DatabaseAccessor<AppDatabase>
    with _$RoundScoresDaoMixin {
  RoundScoresDao(super.db);
}
