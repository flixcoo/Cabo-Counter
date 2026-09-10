// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rounds_dao.dart';

// ignore_for_file: type=lint
mixin _$RoundDaoMixin on DatabaseAccessor<AppDatabase> {
  $GameSessionTableTable get gameSessionTable =>
      attachedDatabase.gameSessionTable;
  $RoundTableTable get roundTable => attachedDatabase.roundTable;
  $PlayerTableTable get playerTable => attachedDatabase.playerTable;
  $RoundScoreTableTable get roundScoreTable => attachedDatabase.roundScoreTable;
  RoundDaoManager get managers => RoundDaoManager(this);
}

class RoundDaoManager {
  final _$RoundDaoMixin _db;
  RoundDaoManager(this._db);
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
