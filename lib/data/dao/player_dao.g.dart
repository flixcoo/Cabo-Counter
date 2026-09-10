// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_dao.dart';

// ignore_for_file: type=lint
mixin _$PlayerDaoMixin on DatabaseAccessor<AppDatabase> {
  $GameSessionTableTable get gameSessionTable =>
      attachedDatabase.gameSessionTable;
  $PlayerTableTable get playerTable => attachedDatabase.playerTable;
  PlayerDaoManager get managers => PlayerDaoManager(this);
}

class PlayerDaoManager {
  final _$PlayerDaoMixin _db;
  PlayerDaoManager(this._db);
  $$GameSessionTableTableTableManager get gameSessionTable =>
      $$GameSessionTableTableTableManager(
        _db.attachedDatabase,
        _db.gameSessionTable,
      );
  $$PlayerTableTableTableManager get playerTable =>
      $$PlayerTableTableTableManager(_db.attachedDatabase, _db.playerTable);
}
