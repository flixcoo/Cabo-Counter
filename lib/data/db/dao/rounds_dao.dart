import 'package:cabo_counter/data/db/database.dart';
import 'package:drift/drift.dart';

part 'rounds_dao.g.dart';

@DriftAccessor(tables: [])
class RoundsDao extends DatabaseAccessor<AppDatabase> with _$RoundsDaoMixin {
  RoundsDao(super.db);
}
