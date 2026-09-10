// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_scores_dao.dart';

// ignore_for_file: type=lint
mixin _$RoundScoresDaoMixin on DatabaseAccessor<AppDatabase> {
  $GameSessionTableTable get gameSessionTable =>
      attachedDatabase.gameSessionTable;
  $RoundTableTable get roundTable => attachedDatabase.roundTable;
  $PlayerTableTable get playerTable => attachedDatabase.playerTable;
  $RoundScoreTableTable get roundScoreTable => attachedDatabase.roundScoreTable;
  RoundScoresDaoManager get managers => RoundScoresDaoManager(this);
}

class RoundScoresDaoManager {
  final _$RoundScoresDaoMixin _db;
  RoundScoresDaoManager(this._db);
  $$GameSessionTableTableTableManager get gameSessionTable =>
      $$GameSessionTableTableTableManager(
        _db.attachedDatabase,
        _db.gameSessionTable,
      );
  $$RoundTableTableTableManager get roundTable =>
      $$RoundTableTableTableManager(_db.attachedDatabase, _db.roundTable);
  $$PlayerTableTableTableManager get playerTable =>
      $$PlayerTableTableTableManager(_db.attachedDatabase, _db.playerTable);
  $$RoundScoreTableTableTableManager get roundScoreTable =>
      $$RoundScoreTableTableTableManager(
        _db.attachedDatabase,
        _db.roundScoreTable,
      );
}
