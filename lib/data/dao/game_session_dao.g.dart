// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_session_dao.dart';

// ignore_for_file: type=lint
mixin _$GameSessionDaoMixin on DatabaseAccessor<AppDatabase> {
  $GameSessionTableTable get gameSessionTable =>
      attachedDatabase.gameSessionTable;
  GameSessionDaoManager get managers => GameSessionDaoManager(this);
}

class GameSessionDaoManager {
  final _$GameSessionDaoMixin _db;
  GameSessionDaoManager(this._db);
  $$GameSessionTableTableTableManager get gameSessionTable =>
      $$GameSessionTableTableTableManager(
        _db.attachedDatabase,
        _db.gameSessionTable,
      );
}
