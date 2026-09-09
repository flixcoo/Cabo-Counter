// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_scores_dao.dart';

// ignore_for_file: type=lint
mixin _$RoundScoresDaoMixin on DatabaseAccessor<AppDatabase> {
  $GameSessionTableTable get gameSessionTable =>
      attachedDatabase.gameSessionTable;
  $RoundsTableTable get roundsTable => attachedDatabase.roundsTable;
  $PlayerTableTable get playerTable => attachedDatabase.playerTable;
  $RoundScoresTableTable get roundScoresTable =>
      attachedDatabase.roundScoresTable;
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
  $$RoundsTableTableTableManager get roundsTable =>
      $$RoundsTableTableTableManager(_db.attachedDatabase, _db.roundsTable);
  $$PlayerTableTableTableManager get playerTable =>
      $$PlayerTableTableTableManager(_db.attachedDatabase, _db.playerTable);
  $$RoundScoresTableTableTableManager get roundScoresTable =>
      $$RoundScoresTableTableTableManager(
        _db.attachedDatabase,
        _db.roundScoresTable,
      );
}
