// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $GameSessionTableTable extends GameSessionTable
    with TableInfo<$GameSessionTableTable, GameSessionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameSessionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameTitleMeta = const VerificationMeta(
    'gameTitle',
  );
  @override
  late final GeneratedColumn<String> gameTitle = GeneratedColumn<String>(
    'game_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointLimitMeta = const VerificationMeta(
    'pointLimit',
  );
  @override
  late final GeneratedColumn<int> pointLimit = GeneratedColumn<int>(
    'point_limit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caboPenaltyMeta = const VerificationMeta(
    'caboPenalty',
  );
  @override
  late final GeneratedColumn<int> caboPenalty = GeneratedColumn<int>(
    'cabo_penalty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPointsLimitEnabledMeta =
      const VerificationMeta('isPointsLimitEnabled');
  @override
  late final GeneratedColumn<bool> isPointsLimitEnabled = GeneratedColumn<bool>(
    'is_points_limit_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_points_limit_enabled" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isGameFinishedMeta = const VerificationMeta(
    'isGameFinished',
  );
  @override
  late final GeneratedColumn<bool> isGameFinished = GeneratedColumn<bool>(
    'is_game_finished',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_game_finished" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    gameId,
    createdAt,
    gameTitle,
    pointLimit,
    caboPenalty,
    isPointsLimitEnabled,
    isGameFinished,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_session_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GameSessionTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('game_title')) {
      context.handle(
        _gameTitleMeta,
        gameTitle.isAcceptableOrUnknown(data['game_title']!, _gameTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_gameTitleMeta);
    }
    if (data.containsKey('point_limit')) {
      context.handle(
        _pointLimitMeta,
        pointLimit.isAcceptableOrUnknown(data['point_limit']!, _pointLimitMeta),
      );
    } else if (isInserting) {
      context.missing(_pointLimitMeta);
    }
    if (data.containsKey('cabo_penalty')) {
      context.handle(
        _caboPenaltyMeta,
        caboPenalty.isAcceptableOrUnknown(
          data['cabo_penalty']!,
          _caboPenaltyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caboPenaltyMeta);
    }
    if (data.containsKey('is_points_limit_enabled')) {
      context.handle(
        _isPointsLimitEnabledMeta,
        isPointsLimitEnabled.isAcceptableOrUnknown(
          data['is_points_limit_enabled']!,
          _isPointsLimitEnabledMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isPointsLimitEnabledMeta);
    }
    if (data.containsKey('is_game_finished')) {
      context.handle(
        _isGameFinishedMeta,
        isGameFinished.isAcceptableOrUnknown(
          data['is_game_finished']!,
          _isGameFinishedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isGameFinishedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {gameId};
  @override
  GameSessionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameSessionTableData(
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      gameTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_title'],
      )!,
      pointLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}point_limit'],
      )!,
      caboPenalty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cabo_penalty'],
      )!,
      isPointsLimitEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_points_limit_enabled'],
      )!,
      isGameFinished: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_game_finished'],
      )!,
    );
  }

  @override
  $GameSessionTableTable createAlias(String alias) {
    return $GameSessionTableTable(attachedDatabase, alias);
  }
}

class GameSessionTableData extends DataClass
    implements Insertable<GameSessionTableData> {
  final String gameId;
  final DateTime createdAt;
  final String gameTitle;
  final int pointLimit;
  final int caboPenalty;
  final bool isPointsLimitEnabled;
  final bool isGameFinished;
  const GameSessionTableData({
    required this.gameId,
    required this.createdAt,
    required this.gameTitle,
    required this.pointLimit,
    required this.caboPenalty,
    required this.isPointsLimitEnabled,
    required this.isGameFinished,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['game_id'] = Variable<String>(gameId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['game_title'] = Variable<String>(gameTitle);
    map['point_limit'] = Variable<int>(pointLimit);
    map['cabo_penalty'] = Variable<int>(caboPenalty);
    map['is_points_limit_enabled'] = Variable<bool>(isPointsLimitEnabled);
    map['is_game_finished'] = Variable<bool>(isGameFinished);
    return map;
  }

  GameSessionTableCompanion toCompanion(bool nullToAbsent) {
    return GameSessionTableCompanion(
      gameId: Value(gameId),
      createdAt: Value(createdAt),
      gameTitle: Value(gameTitle),
      pointLimit: Value(pointLimit),
      caboPenalty: Value(caboPenalty),
      isPointsLimitEnabled: Value(isPointsLimitEnabled),
      isGameFinished: Value(isGameFinished),
    );
  }

  factory GameSessionTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameSessionTableData(
      gameId: serializer.fromJson<String>(json['gameId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      gameTitle: serializer.fromJson<String>(json['gameTitle']),
      pointLimit: serializer.fromJson<int>(json['pointLimit']),
      caboPenalty: serializer.fromJson<int>(json['caboPenalty']),
      isPointsLimitEnabled: serializer.fromJson<bool>(
        json['isPointsLimitEnabled'],
      ),
      isGameFinished: serializer.fromJson<bool>(json['isGameFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'gameId': serializer.toJson<String>(gameId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'gameTitle': serializer.toJson<String>(gameTitle),
      'pointLimit': serializer.toJson<int>(pointLimit),
      'caboPenalty': serializer.toJson<int>(caboPenalty),
      'isPointsLimitEnabled': serializer.toJson<bool>(isPointsLimitEnabled),
      'isGameFinished': serializer.toJson<bool>(isGameFinished),
    };
  }

  GameSessionTableData copyWith({
    String? gameId,
    DateTime? createdAt,
    String? gameTitle,
    int? pointLimit,
    int? caboPenalty,
    bool? isPointsLimitEnabled,
    bool? isGameFinished,
  }) => GameSessionTableData(
    gameId: gameId ?? this.gameId,
    createdAt: createdAt ?? this.createdAt,
    gameTitle: gameTitle ?? this.gameTitle,
    pointLimit: pointLimit ?? this.pointLimit,
    caboPenalty: caboPenalty ?? this.caboPenalty,
    isPointsLimitEnabled: isPointsLimitEnabled ?? this.isPointsLimitEnabled,
    isGameFinished: isGameFinished ?? this.isGameFinished,
  );
  GameSessionTableData copyWithCompanion(GameSessionTableCompanion data) {
    return GameSessionTableData(
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      gameTitle: data.gameTitle.present ? data.gameTitle.value : this.gameTitle,
      pointLimit: data.pointLimit.present
          ? data.pointLimit.value
          : this.pointLimit,
      caboPenalty: data.caboPenalty.present
          ? data.caboPenalty.value
          : this.caboPenalty,
      isPointsLimitEnabled: data.isPointsLimitEnabled.present
          ? data.isPointsLimitEnabled.value
          : this.isPointsLimitEnabled,
      isGameFinished: data.isGameFinished.present
          ? data.isGameFinished.value
          : this.isGameFinished,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameSessionTableData(')
          ..write('gameId: $gameId, ')
          ..write('createdAt: $createdAt, ')
          ..write('gameTitle: $gameTitle, ')
          ..write('pointLimit: $pointLimit, ')
          ..write('caboPenalty: $caboPenalty, ')
          ..write('isPointsLimitEnabled: $isPointsLimitEnabled, ')
          ..write('isGameFinished: $isGameFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    gameId,
    createdAt,
    gameTitle,
    pointLimit,
    caboPenalty,
    isPointsLimitEnabled,
    isGameFinished,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameSessionTableData &&
          other.gameId == this.gameId &&
          other.createdAt == this.createdAt &&
          other.gameTitle == this.gameTitle &&
          other.pointLimit == this.pointLimit &&
          other.caboPenalty == this.caboPenalty &&
          other.isPointsLimitEnabled == this.isPointsLimitEnabled &&
          other.isGameFinished == this.isGameFinished);
}

class GameSessionTableCompanion extends UpdateCompanion<GameSessionTableData> {
  final Value<String> gameId;
  final Value<DateTime> createdAt;
  final Value<String> gameTitle;
  final Value<int> pointLimit;
  final Value<int> caboPenalty;
  final Value<bool> isPointsLimitEnabled;
  final Value<bool> isGameFinished;
  final Value<int> rowid;
  const GameSessionTableCompanion({
    this.gameId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.gameTitle = const Value.absent(),
    this.pointLimit = const Value.absent(),
    this.caboPenalty = const Value.absent(),
    this.isPointsLimitEnabled = const Value.absent(),
    this.isGameFinished = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameSessionTableCompanion.insert({
    required String gameId,
    required DateTime createdAt,
    required String gameTitle,
    required int pointLimit,
    required int caboPenalty,
    required bool isPointsLimitEnabled,
    required bool isGameFinished,
    this.rowid = const Value.absent(),
  }) : gameId = Value(gameId),
       createdAt = Value(createdAt),
       gameTitle = Value(gameTitle),
       pointLimit = Value(pointLimit),
       caboPenalty = Value(caboPenalty),
       isPointsLimitEnabled = Value(isPointsLimitEnabled),
       isGameFinished = Value(isGameFinished);
  static Insertable<GameSessionTableData> custom({
    Expression<String>? gameId,
    Expression<DateTime>? createdAt,
    Expression<String>? gameTitle,
    Expression<int>? pointLimit,
    Expression<int>? caboPenalty,
    Expression<bool>? isPointsLimitEnabled,
    Expression<bool>? isGameFinished,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (gameId != null) 'game_id': gameId,
      if (createdAt != null) 'created_at': createdAt,
      if (gameTitle != null) 'game_title': gameTitle,
      if (pointLimit != null) 'point_limit': pointLimit,
      if (caboPenalty != null) 'cabo_penalty': caboPenalty,
      if (isPointsLimitEnabled != null)
        'is_points_limit_enabled': isPointsLimitEnabled,
      if (isGameFinished != null) 'is_game_finished': isGameFinished,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameSessionTableCompanion copyWith({
    Value<String>? gameId,
    Value<DateTime>? createdAt,
    Value<String>? gameTitle,
    Value<int>? pointLimit,
    Value<int>? caboPenalty,
    Value<bool>? isPointsLimitEnabled,
    Value<bool>? isGameFinished,
    Value<int>? rowid,
  }) {
    return GameSessionTableCompanion(
      gameId: gameId ?? this.gameId,
      createdAt: createdAt ?? this.createdAt,
      gameTitle: gameTitle ?? this.gameTitle,
      pointLimit: pointLimit ?? this.pointLimit,
      caboPenalty: caboPenalty ?? this.caboPenalty,
      isPointsLimitEnabled: isPointsLimitEnabled ?? this.isPointsLimitEnabled,
      isGameFinished: isGameFinished ?? this.isGameFinished,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (gameTitle.present) {
      map['game_title'] = Variable<String>(gameTitle.value);
    }
    if (pointLimit.present) {
      map['point_limit'] = Variable<int>(pointLimit.value);
    }
    if (caboPenalty.present) {
      map['cabo_penalty'] = Variable<int>(caboPenalty.value);
    }
    if (isPointsLimitEnabled.present) {
      map['is_points_limit_enabled'] = Variable<bool>(
        isPointsLimitEnabled.value,
      );
    }
    if (isGameFinished.present) {
      map['is_game_finished'] = Variable<bool>(isGameFinished.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameSessionTableCompanion(')
          ..write('gameId: $gameId, ')
          ..write('createdAt: $createdAt, ')
          ..write('gameTitle: $gameTitle, ')
          ..write('pointLimit: $pointLimit, ')
          ..write('caboPenalty: $caboPenalty, ')
          ..write('isPointsLimitEnabled: $isPointsLimitEnabled, ')
          ..write('isGameFinished: $isGameFinished, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlayerTableTable extends PlayerTable
    with TableInfo<$PlayerTableTable, PlayerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES game_session_table (game_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _totalScoreMeta = const VerificationMeta(
    'totalScore',
  );
  @override
  late final GeneratedColumn<int> totalScore = GeneratedColumn<int>(
    'total_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    playerId,
    gameId,
    totalScore,
    position,
    name,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayerTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('total_score')) {
      context.handle(
        _totalScoreMeta,
        totalScore.isAcceptableOrUnknown(data['total_score']!, _totalScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_totalScoreMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playerId};
  @override
  PlayerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerTableData(
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
      totalScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_score'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $PlayerTableTable createAlias(String alias) {
    return $PlayerTableTable(attachedDatabase, alias);
  }
}

class PlayerTableData extends DataClass implements Insertable<PlayerTableData> {
  final String playerId;
  final String gameId;
  final int totalScore;
  final int position;
  final String name;
  const PlayerTableData({
    required this.playerId,
    required this.gameId,
    required this.totalScore,
    required this.position,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['player_id'] = Variable<String>(playerId);
    map['game_id'] = Variable<String>(gameId);
    map['total_score'] = Variable<int>(totalScore);
    map['position'] = Variable<int>(position);
    map['name'] = Variable<String>(name);
    return map;
  }

  PlayerTableCompanion toCompanion(bool nullToAbsent) {
    return PlayerTableCompanion(
      playerId: Value(playerId),
      gameId: Value(gameId),
      totalScore: Value(totalScore),
      position: Value(position),
      name: Value(name),
    );
  }

  factory PlayerTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerTableData(
      playerId: serializer.fromJson<String>(json['playerId']),
      gameId: serializer.fromJson<String>(json['gameId']),
      totalScore: serializer.fromJson<int>(json['totalScore']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playerId': serializer.toJson<String>(playerId),
      'gameId': serializer.toJson<String>(gameId),
      'totalScore': serializer.toJson<int>(totalScore),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
    };
  }

  PlayerTableData copyWith({
    String? playerId,
    String? gameId,
    int? totalScore,
    int? position,
    String? name,
  }) => PlayerTableData(
    playerId: playerId ?? this.playerId,
    gameId: gameId ?? this.gameId,
    totalScore: totalScore ?? this.totalScore,
    position: position ?? this.position,
    name: name ?? this.name,
  );
  PlayerTableData copyWithCompanion(PlayerTableCompanion data) {
    return PlayerTableData(
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      totalScore: data.totalScore.present
          ? data.totalScore.value
          : this.totalScore,
      position: data.position.present ? data.position.value : this.position,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerTableData(')
          ..write('playerId: $playerId, ')
          ..write('gameId: $gameId, ')
          ..write('totalScore: $totalScore, ')
          ..write('position: $position, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(playerId, gameId, totalScore, position, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerTableData &&
          other.playerId == this.playerId &&
          other.gameId == this.gameId &&
          other.totalScore == this.totalScore &&
          other.position == this.position &&
          other.name == this.name);
}

class PlayerTableCompanion extends UpdateCompanion<PlayerTableData> {
  final Value<String> playerId;
  final Value<String> gameId;
  final Value<int> totalScore;
  final Value<int> position;
  final Value<String> name;
  final Value<int> rowid;
  const PlayerTableCompanion({
    this.playerId = const Value.absent(),
    this.gameId = const Value.absent(),
    this.totalScore = const Value.absent(),
    this.position = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayerTableCompanion.insert({
    required String playerId,
    required String gameId,
    required int totalScore,
    required int position,
    required String name,
    this.rowid = const Value.absent(),
  }) : playerId = Value(playerId),
       gameId = Value(gameId),
       totalScore = Value(totalScore),
       position = Value(position),
       name = Value(name);
  static Insertable<PlayerTableData> custom({
    Expression<String>? playerId,
    Expression<String>? gameId,
    Expression<int>? totalScore,
    Expression<int>? position,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (playerId != null) 'player_id': playerId,
      if (gameId != null) 'game_id': gameId,
      if (totalScore != null) 'total_score': totalScore,
      if (position != null) 'position': position,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayerTableCompanion copyWith({
    Value<String>? playerId,
    Value<String>? gameId,
    Value<int>? totalScore,
    Value<int>? position,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return PlayerTableCompanion(
      playerId: playerId ?? this.playerId,
      gameId: gameId ?? this.gameId,
      totalScore: totalScore ?? this.totalScore,
      position: position ?? this.position,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (totalScore.present) {
      map['total_score'] = Variable<int>(totalScore.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerTableCompanion(')
          ..write('playerId: $playerId, ')
          ..write('gameId: $gameId, ')
          ..write('totalScore: $totalScore, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoundsTableTable extends RoundsTable
    with TableInfo<$RoundsTableTable, RoundsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoundsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _roundIdMeta = const VerificationMeta(
    'roundId',
  );
  @override
  late final GeneratedColumn<String> roundId = GeneratedColumn<String>(
    'round_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES game_session_table (game_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _roundNumberMeta = const VerificationMeta(
    'roundNumber',
  );
  @override
  late final GeneratedColumn<int> roundNumber = GeneratedColumn<int>(
    'round_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caboPlayerIndexMeta = const VerificationMeta(
    'caboPlayerIndex',
  );
  @override
  late final GeneratedColumn<int> caboPlayerIndex = GeneratedColumn<int>(
    'cabo_player_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kamikazePlayerIndexMeta =
      const VerificationMeta('kamikazePlayerIndex');
  @override
  late final GeneratedColumn<int> kamikazePlayerIndex = GeneratedColumn<int>(
    'kamikaze_player_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    roundId,
    gameId,
    roundNumber,
    caboPlayerIndex,
    kamikazePlayerIndex,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rounds_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoundsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('round_id')) {
      context.handle(
        _roundIdMeta,
        roundId.isAcceptableOrUnknown(data['round_id']!, _roundIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roundIdMeta);
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('round_number')) {
      context.handle(
        _roundNumberMeta,
        roundNumber.isAcceptableOrUnknown(
          data['round_number']!,
          _roundNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roundNumberMeta);
    }
    if (data.containsKey('cabo_player_index')) {
      context.handle(
        _caboPlayerIndexMeta,
        caboPlayerIndex.isAcceptableOrUnknown(
          data['cabo_player_index']!,
          _caboPlayerIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caboPlayerIndexMeta);
    }
    if (data.containsKey('kamikaze_player_index')) {
      context.handle(
        _kamikazePlayerIndexMeta,
        kamikazePlayerIndex.isAcceptableOrUnknown(
          data['kamikaze_player_index']!,
          _kamikazePlayerIndexMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {roundId};
  @override
  RoundsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoundsTableData(
      roundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}round_id'],
      )!,
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
      roundNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round_number'],
      )!,
      caboPlayerIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cabo_player_index'],
      )!,
      kamikazePlayerIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kamikaze_player_index'],
      ),
    );
  }

  @override
  $RoundsTableTable createAlias(String alias) {
    return $RoundsTableTable(attachedDatabase, alias);
  }
}

class RoundsTableData extends DataClass implements Insertable<RoundsTableData> {
  final String roundId;
  final String gameId;
  final int roundNumber;
  final int caboPlayerIndex;
  final int? kamikazePlayerIndex;
  const RoundsTableData({
    required this.roundId,
    required this.gameId,
    required this.roundNumber,
    required this.caboPlayerIndex,
    this.kamikazePlayerIndex,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['round_id'] = Variable<String>(roundId);
    map['game_id'] = Variable<String>(gameId);
    map['round_number'] = Variable<int>(roundNumber);
    map['cabo_player_index'] = Variable<int>(caboPlayerIndex);
    if (!nullToAbsent || kamikazePlayerIndex != null) {
      map['kamikaze_player_index'] = Variable<int>(kamikazePlayerIndex);
    }
    return map;
  }

  RoundsTableCompanion toCompanion(bool nullToAbsent) {
    return RoundsTableCompanion(
      roundId: Value(roundId),
      gameId: Value(gameId),
      roundNumber: Value(roundNumber),
      caboPlayerIndex: Value(caboPlayerIndex),
      kamikazePlayerIndex: kamikazePlayerIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(kamikazePlayerIndex),
    );
  }

  factory RoundsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoundsTableData(
      roundId: serializer.fromJson<String>(json['roundId']),
      gameId: serializer.fromJson<String>(json['gameId']),
      roundNumber: serializer.fromJson<int>(json['roundNumber']),
      caboPlayerIndex: serializer.fromJson<int>(json['caboPlayerIndex']),
      kamikazePlayerIndex: serializer.fromJson<int?>(
        json['kamikazePlayerIndex'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'roundId': serializer.toJson<String>(roundId),
      'gameId': serializer.toJson<String>(gameId),
      'roundNumber': serializer.toJson<int>(roundNumber),
      'caboPlayerIndex': serializer.toJson<int>(caboPlayerIndex),
      'kamikazePlayerIndex': serializer.toJson<int?>(kamikazePlayerIndex),
    };
  }

  RoundsTableData copyWith({
    String? roundId,
    String? gameId,
    int? roundNumber,
    int? caboPlayerIndex,
    Value<int?> kamikazePlayerIndex = const Value.absent(),
  }) => RoundsTableData(
    roundId: roundId ?? this.roundId,
    gameId: gameId ?? this.gameId,
    roundNumber: roundNumber ?? this.roundNumber,
    caboPlayerIndex: caboPlayerIndex ?? this.caboPlayerIndex,
    kamikazePlayerIndex: kamikazePlayerIndex.present
        ? kamikazePlayerIndex.value
        : this.kamikazePlayerIndex,
  );
  RoundsTableData copyWithCompanion(RoundsTableCompanion data) {
    return RoundsTableData(
      roundId: data.roundId.present ? data.roundId.value : this.roundId,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      roundNumber: data.roundNumber.present
          ? data.roundNumber.value
          : this.roundNumber,
      caboPlayerIndex: data.caboPlayerIndex.present
          ? data.caboPlayerIndex.value
          : this.caboPlayerIndex,
      kamikazePlayerIndex: data.kamikazePlayerIndex.present
          ? data.kamikazePlayerIndex.value
          : this.kamikazePlayerIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoundsTableData(')
          ..write('roundId: $roundId, ')
          ..write('gameId: $gameId, ')
          ..write('roundNumber: $roundNumber, ')
          ..write('caboPlayerIndex: $caboPlayerIndex, ')
          ..write('kamikazePlayerIndex: $kamikazePlayerIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    roundId,
    gameId,
    roundNumber,
    caboPlayerIndex,
    kamikazePlayerIndex,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoundsTableData &&
          other.roundId == this.roundId &&
          other.gameId == this.gameId &&
          other.roundNumber == this.roundNumber &&
          other.caboPlayerIndex == this.caboPlayerIndex &&
          other.kamikazePlayerIndex == this.kamikazePlayerIndex);
}

class RoundsTableCompanion extends UpdateCompanion<RoundsTableData> {
  final Value<String> roundId;
  final Value<String> gameId;
  final Value<int> roundNumber;
  final Value<int> caboPlayerIndex;
  final Value<int?> kamikazePlayerIndex;
  final Value<int> rowid;
  const RoundsTableCompanion({
    this.roundId = const Value.absent(),
    this.gameId = const Value.absent(),
    this.roundNumber = const Value.absent(),
    this.caboPlayerIndex = const Value.absent(),
    this.kamikazePlayerIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoundsTableCompanion.insert({
    required String roundId,
    required String gameId,
    required int roundNumber,
    required int caboPlayerIndex,
    this.kamikazePlayerIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : roundId = Value(roundId),
       gameId = Value(gameId),
       roundNumber = Value(roundNumber),
       caboPlayerIndex = Value(caboPlayerIndex);
  static Insertable<RoundsTableData> custom({
    Expression<String>? roundId,
    Expression<String>? gameId,
    Expression<int>? roundNumber,
    Expression<int>? caboPlayerIndex,
    Expression<int>? kamikazePlayerIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (roundId != null) 'round_id': roundId,
      if (gameId != null) 'game_id': gameId,
      if (roundNumber != null) 'round_number': roundNumber,
      if (caboPlayerIndex != null) 'cabo_player_index': caboPlayerIndex,
      if (kamikazePlayerIndex != null)
        'kamikaze_player_index': kamikazePlayerIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoundsTableCompanion copyWith({
    Value<String>? roundId,
    Value<String>? gameId,
    Value<int>? roundNumber,
    Value<int>? caboPlayerIndex,
    Value<int?>? kamikazePlayerIndex,
    Value<int>? rowid,
  }) {
    return RoundsTableCompanion(
      roundId: roundId ?? this.roundId,
      gameId: gameId ?? this.gameId,
      roundNumber: roundNumber ?? this.roundNumber,
      caboPlayerIndex: caboPlayerIndex ?? this.caboPlayerIndex,
      kamikazePlayerIndex: kamikazePlayerIndex ?? this.kamikazePlayerIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (roundId.present) {
      map['round_id'] = Variable<String>(roundId.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (roundNumber.present) {
      map['round_number'] = Variable<int>(roundNumber.value);
    }
    if (caboPlayerIndex.present) {
      map['cabo_player_index'] = Variable<int>(caboPlayerIndex.value);
    }
    if (kamikazePlayerIndex.present) {
      map['kamikaze_player_index'] = Variable<int>(kamikazePlayerIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoundsTableCompanion(')
          ..write('roundId: $roundId, ')
          ..write('gameId: $gameId, ')
          ..write('roundNumber: $roundNumber, ')
          ..write('caboPlayerIndex: $caboPlayerIndex, ')
          ..write('kamikazePlayerIndex: $kamikazePlayerIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoundScoresTableTable extends RoundScoresTable
    with TableInfo<$RoundScoresTableTable, RoundScoresTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoundScoresTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _roundIdMeta = const VerificationMeta(
    'roundId',
  );
  @override
  late final GeneratedColumn<String> roundId = GeneratedColumn<String>(
    'round_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rounds_table (round_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES player_table (player_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreUpdateMeta = const VerificationMeta(
    'scoreUpdate',
  );
  @override
  late final GeneratedColumn<int> scoreUpdate = GeneratedColumn<int>(
    'score_update',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [roundId, playerId, score, scoreUpdate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'round_scores_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoundScoresTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('round_id')) {
      context.handle(
        _roundIdMeta,
        roundId.isAcceptableOrUnknown(data['round_id']!, _roundIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roundIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('score_update')) {
      context.handle(
        _scoreUpdateMeta,
        scoreUpdate.isAcceptableOrUnknown(
          data['score_update']!,
          _scoreUpdateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scoreUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {roundId, playerId};
  @override
  RoundScoresTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoundScoresTableData(
      roundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}round_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      scoreUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_update'],
      )!,
    );
  }

  @override
  $RoundScoresTableTable createAlias(String alias) {
    return $RoundScoresTableTable(attachedDatabase, alias);
  }
}

class RoundScoresTableData extends DataClass
    implements Insertable<RoundScoresTableData> {
  final String roundId;
  final String playerId;
  final int score;
  final int scoreUpdate;
  const RoundScoresTableData({
    required this.roundId,
    required this.playerId,
    required this.score,
    required this.scoreUpdate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['round_id'] = Variable<String>(roundId);
    map['player_id'] = Variable<String>(playerId);
    map['score'] = Variable<int>(score);
    map['score_update'] = Variable<int>(scoreUpdate);
    return map;
  }

  RoundScoresTableCompanion toCompanion(bool nullToAbsent) {
    return RoundScoresTableCompanion(
      roundId: Value(roundId),
      playerId: Value(playerId),
      score: Value(score),
      scoreUpdate: Value(scoreUpdate),
    );
  }

  factory RoundScoresTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoundScoresTableData(
      roundId: serializer.fromJson<String>(json['roundId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      score: serializer.fromJson<int>(json['score']),
      scoreUpdate: serializer.fromJson<int>(json['scoreUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'roundId': serializer.toJson<String>(roundId),
      'playerId': serializer.toJson<String>(playerId),
      'score': serializer.toJson<int>(score),
      'scoreUpdate': serializer.toJson<int>(scoreUpdate),
    };
  }

  RoundScoresTableData copyWith({
    String? roundId,
    String? playerId,
    int? score,
    int? scoreUpdate,
  }) => RoundScoresTableData(
    roundId: roundId ?? this.roundId,
    playerId: playerId ?? this.playerId,
    score: score ?? this.score,
    scoreUpdate: scoreUpdate ?? this.scoreUpdate,
  );
  RoundScoresTableData copyWithCompanion(RoundScoresTableCompanion data) {
    return RoundScoresTableData(
      roundId: data.roundId.present ? data.roundId.value : this.roundId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      score: data.score.present ? data.score.value : this.score,
      scoreUpdate: data.scoreUpdate.present
          ? data.scoreUpdate.value
          : this.scoreUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoundScoresTableData(')
          ..write('roundId: $roundId, ')
          ..write('playerId: $playerId, ')
          ..write('score: $score, ')
          ..write('scoreUpdate: $scoreUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(roundId, playerId, score, scoreUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoundScoresTableData &&
          other.roundId == this.roundId &&
          other.playerId == this.playerId &&
          other.score == this.score &&
          other.scoreUpdate == this.scoreUpdate);
}

class RoundScoresTableCompanion extends UpdateCompanion<RoundScoresTableData> {
  final Value<String> roundId;
  final Value<String> playerId;
  final Value<int> score;
  final Value<int> scoreUpdate;
  final Value<int> rowid;
  const RoundScoresTableCompanion({
    this.roundId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.score = const Value.absent(),
    this.scoreUpdate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoundScoresTableCompanion.insert({
    required String roundId,
    required String playerId,
    required int score,
    required int scoreUpdate,
    this.rowid = const Value.absent(),
  }) : roundId = Value(roundId),
       playerId = Value(playerId),
       score = Value(score),
       scoreUpdate = Value(scoreUpdate);
  static Insertable<RoundScoresTableData> custom({
    Expression<String>? roundId,
    Expression<String>? playerId,
    Expression<int>? score,
    Expression<int>? scoreUpdate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (roundId != null) 'round_id': roundId,
      if (playerId != null) 'player_id': playerId,
      if (score != null) 'score': score,
      if (scoreUpdate != null) 'score_update': scoreUpdate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoundScoresTableCompanion copyWith({
    Value<String>? roundId,
    Value<String>? playerId,
    Value<int>? score,
    Value<int>? scoreUpdate,
    Value<int>? rowid,
  }) {
    return RoundScoresTableCompanion(
      roundId: roundId ?? this.roundId,
      playerId: playerId ?? this.playerId,
      score: score ?? this.score,
      scoreUpdate: scoreUpdate ?? this.scoreUpdate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (roundId.present) {
      map['round_id'] = Variable<String>(roundId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (scoreUpdate.present) {
      map['score_update'] = Variable<int>(scoreUpdate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoundScoresTableCompanion(')
          ..write('roundId: $roundId, ')
          ..write('playerId: $playerId, ')
          ..write('score: $score, ')
          ..write('scoreUpdate: $scoreUpdate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GameSessionTableTable gameSessionTable = $GameSessionTableTable(
    this,
  );
  late final $PlayerTableTable playerTable = $PlayerTableTable(this);
  late final $RoundsTableTable roundsTable = $RoundsTableTable(this);
  late final $RoundScoresTableTable roundScoresTable = $RoundScoresTableTable(
    this,
  );
  late final GameSessionDao gameSessionDao = GameSessionDao(
    this as AppDatabase,
  );
  late final PlayerDao playerDao = PlayerDao(this as AppDatabase);
  late final RoundsDao roundsDao = RoundsDao(this as AppDatabase);
  late final RoundScoresDao roundScoresDao = RoundScoresDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    gameSessionTable,
    playerTable,
    roundsTable,
    roundScoresTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'game_session_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('player_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'game_session_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('rounds_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'rounds_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('round_scores_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'player_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('round_scores_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$GameSessionTableTableCreateCompanionBuilder =
    GameSessionTableCompanion Function({
      required String gameId,
      required DateTime createdAt,
      required String gameTitle,
      required int pointLimit,
      required int caboPenalty,
      required bool isPointsLimitEnabled,
      required bool isGameFinished,
      Value<int> rowid,
    });
typedef $$GameSessionTableTableUpdateCompanionBuilder =
    GameSessionTableCompanion Function({
      Value<String> gameId,
      Value<DateTime> createdAt,
      Value<String> gameTitle,
      Value<int> pointLimit,
      Value<int> caboPenalty,
      Value<bool> isPointsLimitEnabled,
      Value<bool> isGameFinished,
      Value<int> rowid,
    });

final class $$GameSessionTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GameSessionTableTable,
          GameSessionTableData
        > {
  $$GameSessionTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PlayerTableTable, List<PlayerTableData>>
  _playerTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.playerTable,
    aliasName: 'game_session_table__game_id__player_table__game_id',
  );

  $$PlayerTableTableProcessedTableManager get playerTableRefs {
    final manager = $$PlayerTableTableTableManager($_db, $_db.playerTable)
        .filter(
          (f) => f.gameId.gameId.sqlEquals($_itemColumn<String>('game_id')!),
        );

    final cache = $_typedResult.readTableOrNull(_playerTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RoundsTableTable, List<RoundsTableData>>
  _roundsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roundsTable,
    aliasName: 'game_session_table__game_id__rounds_table__game_id',
  );

  $$RoundsTableTableProcessedTableManager get roundsTableRefs {
    final manager = $$RoundsTableTableTableManager($_db, $_db.roundsTable)
        .filter(
          (f) => f.gameId.gameId.sqlEquals($_itemColumn<String>('game_id')!),
        );

    final cache = $_typedResult.readTableOrNull(_roundsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GameSessionTableTableFilterComposer
    extends Composer<_$AppDatabase, $GameSessionTableTable> {
  $$GameSessionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get gameId => $composableBuilder(
    column: $table.gameId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gameTitle => $composableBuilder(
    column: $table.gameTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointLimit => $composableBuilder(
    column: $table.pointLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caboPenalty => $composableBuilder(
    column: $table.caboPenalty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPointsLimitEnabled => $composableBuilder(
    column: $table.isPointsLimitEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isGameFinished => $composableBuilder(
    column: $table.isGameFinished,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> playerTableRefs(
    Expression<bool> Function($$PlayerTableTableFilterComposer f) f,
  ) {
    final $$PlayerTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableFilterComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> roundsTableRefs(
    Expression<bool> Function($$RoundsTableTableFilterComposer f) f,
  ) {
    final $$RoundsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.roundsTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundsTableTableFilterComposer(
            $db: $db,
            $table: $db.roundsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GameSessionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GameSessionTableTable> {
  $$GameSessionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get gameId => $composableBuilder(
    column: $table.gameId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gameTitle => $composableBuilder(
    column: $table.gameTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointLimit => $composableBuilder(
    column: $table.pointLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caboPenalty => $composableBuilder(
    column: $table.caboPenalty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPointsLimitEnabled => $composableBuilder(
    column: $table.isPointsLimitEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isGameFinished => $composableBuilder(
    column: $table.isGameFinished,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GameSessionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameSessionTableTable> {
  $$GameSessionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get gameId =>
      $composableBuilder(column: $table.gameId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get gameTitle =>
      $composableBuilder(column: $table.gameTitle, builder: (column) => column);

  GeneratedColumn<int> get pointLimit => $composableBuilder(
    column: $table.pointLimit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get caboPenalty => $composableBuilder(
    column: $table.caboPenalty,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPointsLimitEnabled => $composableBuilder(
    column: $table.isPointsLimitEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isGameFinished => $composableBuilder(
    column: $table.isGameFinished,
    builder: (column) => column,
  );

  Expression<T> playerTableRefs<T extends Object>(
    Expression<T> Function($$PlayerTableTableAnnotationComposer a) f,
  ) {
    final $$PlayerTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableAnnotationComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> roundsTableRefs<T extends Object>(
    Expression<T> Function($$RoundsTableTableAnnotationComposer a) f,
  ) {
    final $$RoundsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.roundsTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.roundsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GameSessionTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GameSessionTableTable,
          GameSessionTableData,
          $$GameSessionTableTableFilterComposer,
          $$GameSessionTableTableOrderingComposer,
          $$GameSessionTableTableAnnotationComposer,
          $$GameSessionTableTableCreateCompanionBuilder,
          $$GameSessionTableTableUpdateCompanionBuilder,
          (GameSessionTableData, $$GameSessionTableTableReferences),
          GameSessionTableData,
          PrefetchHooks Function({bool playerTableRefs, bool roundsTableRefs})
        > {
  $$GameSessionTableTableTableManager(
    _$AppDatabase db,
    $GameSessionTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameSessionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameSessionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameSessionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> gameId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> gameTitle = const Value.absent(),
                Value<int> pointLimit = const Value.absent(),
                Value<int> caboPenalty = const Value.absent(),
                Value<bool> isPointsLimitEnabled = const Value.absent(),
                Value<bool> isGameFinished = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GameSessionTableCompanion(
                gameId: gameId,
                createdAt: createdAt,
                gameTitle: gameTitle,
                pointLimit: pointLimit,
                caboPenalty: caboPenalty,
                isPointsLimitEnabled: isPointsLimitEnabled,
                isGameFinished: isGameFinished,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String gameId,
                required DateTime createdAt,
                required String gameTitle,
                required int pointLimit,
                required int caboPenalty,
                required bool isPointsLimitEnabled,
                required bool isGameFinished,
                Value<int> rowid = const Value.absent(),
              }) => GameSessionTableCompanion.insert(
                gameId: gameId,
                createdAt: createdAt,
                gameTitle: gameTitle,
                pointLimit: pointLimit,
                caboPenalty: caboPenalty,
                isPointsLimitEnabled: isPointsLimitEnabled,
                isGameFinished: isGameFinished,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GameSessionTableTable, GameSessionTableData>(
                    table,
                  ),
                  $$GameSessionTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({playerTableRefs = false, roundsTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (playerTableRefs) db.playerTable,
                    if (roundsTableRefs) db.roundsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (playerTableRefs)
                        await $_getPrefetchedData<
                          GameSessionTableData,
                          $GameSessionTableTable,
                          PlayerTableData
                        >(
                          currentTable: table,
                          referencedTable: $$GameSessionTableTableReferences
                              ._playerTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GameSessionTableTableReferences(
                                db,
                                table,
                                p0,
                              ).playerTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gameId == item.gameId,
                              ),
                          typedResults: items,
                        ),
                      if (roundsTableRefs)
                        await $_getPrefetchedData<
                          GameSessionTableData,
                          $GameSessionTableTable,
                          RoundsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$GameSessionTableTableReferences
                              ._roundsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GameSessionTableTableReferences(
                                db,
                                table,
                                p0,
                              ).roundsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gameId == item.gameId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GameSessionTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GameSessionTableTable,
      GameSessionTableData,
      $$GameSessionTableTableFilterComposer,
      $$GameSessionTableTableOrderingComposer,
      $$GameSessionTableTableAnnotationComposer,
      $$GameSessionTableTableCreateCompanionBuilder,
      $$GameSessionTableTableUpdateCompanionBuilder,
      (GameSessionTableData, $$GameSessionTableTableReferences),
      GameSessionTableData,
      PrefetchHooks Function({bool playerTableRefs, bool roundsTableRefs})
    >;
typedef $$PlayerTableTableCreateCompanionBuilder =
    PlayerTableCompanion Function({
      required String playerId,
      required String gameId,
      required int totalScore,
      required int position,
      required String name,
      Value<int> rowid,
    });
typedef $$PlayerTableTableUpdateCompanionBuilder =
    PlayerTableCompanion Function({
      Value<String> playerId,
      Value<String> gameId,
      Value<int> totalScore,
      Value<int> position,
      Value<String> name,
      Value<int> rowid,
    });

final class $$PlayerTableTableReferences
    extends BaseReferences<_$AppDatabase, $PlayerTableTable, PlayerTableData> {
  $$PlayerTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GameSessionTableTable _gameIdTable(_$AppDatabase db) => db
      .gameSessionTable
      .createAlias('player_table__game_id__game_session_table__game_id');

  $$GameSessionTableTableProcessedTableManager get gameId {
    final $_column = $_itemColumn<String>('game_id')!;

    final manager = $$GameSessionTableTableTableManager(
      $_db,
      $_db.gameSessionTable,
    ).filter((f) => f.gameId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RoundScoresTableTable, List<RoundScoresTableData>>
  _roundScoresTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roundScoresTable,
    aliasName: 'player_table__player_id__round_scores_table__player_id',
  );

  $$RoundScoresTableTableProcessedTableManager get roundScoresTableRefs {
    final manager =
        $$RoundScoresTableTableTableManager($_db, $_db.roundScoresTable).filter(
          (f) =>
              f.playerId.playerId.sqlEquals($_itemColumn<String>('player_id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _roundScoresTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlayerTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlayerTableTable> {
  $$PlayerTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$GameSessionTableTableFilterComposer get gameId {
    final $$GameSessionTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameSessionTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameSessionTableTableFilterComposer(
            $db: $db,
            $table: $db.gameSessionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> roundScoresTableRefs(
    Expression<bool> Function($$RoundScoresTableTableFilterComposer f) f,
  ) {
    final $$RoundScoresTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.roundScoresTable,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundScoresTableTableFilterComposer(
            $db: $db,
            $table: $db.roundScoresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayerTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayerTableTable> {
  $$PlayerTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$GameSessionTableTableOrderingComposer get gameId {
    final $$GameSessionTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameSessionTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameSessionTableTableOrderingComposer(
            $db: $db,
            $table: $db.gameSessionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayerTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayerTableTable> {
  $$PlayerTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$GameSessionTableTableAnnotationComposer get gameId {
    final $$GameSessionTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameSessionTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameSessionTableTableAnnotationComposer(
            $db: $db,
            $table: $db.gameSessionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> roundScoresTableRefs<T extends Object>(
    Expression<T> Function($$RoundScoresTableTableAnnotationComposer a) f,
  ) {
    final $$RoundScoresTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.roundScoresTable,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundScoresTableTableAnnotationComposer(
            $db: $db,
            $table: $db.roundScoresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayerTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayerTableTable,
          PlayerTableData,
          $$PlayerTableTableFilterComposer,
          $$PlayerTableTableOrderingComposer,
          $$PlayerTableTableAnnotationComposer,
          $$PlayerTableTableCreateCompanionBuilder,
          $$PlayerTableTableUpdateCompanionBuilder,
          (PlayerTableData, $$PlayerTableTableReferences),
          PlayerTableData,
          PrefetchHooks Function({bool gameId, bool roundScoresTableRefs})
        > {
  $$PlayerTableTableTableManager(_$AppDatabase db, $PlayerTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> playerId = const Value.absent(),
                Value<String> gameId = const Value.absent(),
                Value<int> totalScore = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayerTableCompanion(
                playerId: playerId,
                gameId: gameId,
                totalScore: totalScore,
                position: position,
                name: name,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String playerId,
                required String gameId,
                required int totalScore,
                required int position,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) => PlayerTableCompanion.insert(
                playerId: playerId,
                gameId: gameId,
                totalScore: totalScore,
                position: position,
                name: name,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlayerTableTable, PlayerTableData>(table),
                  $$PlayerTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({gameId = false, roundScoresTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (roundScoresTableRefs) db.roundScoresTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (gameId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gameId,
                            referencedTable: $$PlayerTableTableReferences
                                ._gameIdTable(db),
                            referencedColumn: $$PlayerTableTableReferences
                                ._gameIdTable(db)
                                .gameId,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (roundScoresTableRefs)
                        await $_getPrefetchedData<
                          PlayerTableData,
                          $PlayerTableTable,
                          RoundScoresTableData
                        >(
                          currentTable: table,
                          referencedTable: $$PlayerTableTableReferences
                              ._roundScoresTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayerTableTableReferences(
                                db,
                                table,
                                p0,
                              ).roundScoresTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.playerId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlayerTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayerTableTable,
      PlayerTableData,
      $$PlayerTableTableFilterComposer,
      $$PlayerTableTableOrderingComposer,
      $$PlayerTableTableAnnotationComposer,
      $$PlayerTableTableCreateCompanionBuilder,
      $$PlayerTableTableUpdateCompanionBuilder,
      (PlayerTableData, $$PlayerTableTableReferences),
      PlayerTableData,
      PrefetchHooks Function({bool gameId, bool roundScoresTableRefs})
    >;
typedef $$RoundsTableTableCreateCompanionBuilder =
    RoundsTableCompanion Function({
      required String roundId,
      required String gameId,
      required int roundNumber,
      required int caboPlayerIndex,
      Value<int?> kamikazePlayerIndex,
      Value<int> rowid,
    });
typedef $$RoundsTableTableUpdateCompanionBuilder =
    RoundsTableCompanion Function({
      Value<String> roundId,
      Value<String> gameId,
      Value<int> roundNumber,
      Value<int> caboPlayerIndex,
      Value<int?> kamikazePlayerIndex,
      Value<int> rowid,
    });

final class $$RoundsTableTableReferences
    extends BaseReferences<_$AppDatabase, $RoundsTableTable, RoundsTableData> {
  $$RoundsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GameSessionTableTable _gameIdTable(_$AppDatabase db) => db
      .gameSessionTable
      .createAlias('rounds_table__game_id__game_session_table__game_id');

  $$GameSessionTableTableProcessedTableManager get gameId {
    final $_column = $_itemColumn<String>('game_id')!;

    final manager = $$GameSessionTableTableTableManager(
      $_db,
      $_db.gameSessionTable,
    ).filter((f) => f.gameId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RoundScoresTableTable, List<RoundScoresTableData>>
  _roundScoresTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roundScoresTable,
    aliasName: 'rounds_table__round_id__round_scores_table__round_id',
  );

  $$RoundScoresTableTableProcessedTableManager get roundScoresTableRefs {
    final manager =
        $$RoundScoresTableTableTableManager($_db, $_db.roundScoresTable).filter(
          (f) => f.roundId.roundId.sqlEquals($_itemColumn<String>('round_id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _roundScoresTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoundsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoundsTableTable> {
  $$RoundsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get roundId => $composableBuilder(
    column: $table.roundId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caboPlayerIndex => $composableBuilder(
    column: $table.caboPlayerIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kamikazePlayerIndex => $composableBuilder(
    column: $table.kamikazePlayerIndex,
    builder: (column) => ColumnFilters(column),
  );

  $$GameSessionTableTableFilterComposer get gameId {
    final $$GameSessionTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameSessionTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameSessionTableTableFilterComposer(
            $db: $db,
            $table: $db.gameSessionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> roundScoresTableRefs(
    Expression<bool> Function($$RoundScoresTableTableFilterComposer f) f,
  ) {
    final $$RoundScoresTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundScoresTable,
      getReferencedColumn: (t) => t.roundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundScoresTableTableFilterComposer(
            $db: $db,
            $table: $db.roundScoresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoundsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoundsTableTable> {
  $$RoundsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get roundId => $composableBuilder(
    column: $table.roundId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caboPlayerIndex => $composableBuilder(
    column: $table.caboPlayerIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kamikazePlayerIndex => $composableBuilder(
    column: $table.kamikazePlayerIndex,
    builder: (column) => ColumnOrderings(column),
  );

  $$GameSessionTableTableOrderingComposer get gameId {
    final $$GameSessionTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameSessionTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameSessionTableTableOrderingComposer(
            $db: $db,
            $table: $db.gameSessionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoundsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoundsTableTable> {
  $$RoundsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get roundId =>
      $composableBuilder(column: $table.roundId, builder: (column) => column);

  GeneratedColumn<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get caboPlayerIndex => $composableBuilder(
    column: $table.caboPlayerIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get kamikazePlayerIndex => $composableBuilder(
    column: $table.kamikazePlayerIndex,
    builder: (column) => column,
  );

  $$GameSessionTableTableAnnotationComposer get gameId {
    final $$GameSessionTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameSessionTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameSessionTableTableAnnotationComposer(
            $db: $db,
            $table: $db.gameSessionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> roundScoresTableRefs<T extends Object>(
    Expression<T> Function($$RoundScoresTableTableAnnotationComposer a) f,
  ) {
    final $$RoundScoresTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundScoresTable,
      getReferencedColumn: (t) => t.roundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundScoresTableTableAnnotationComposer(
            $db: $db,
            $table: $db.roundScoresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoundsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoundsTableTable,
          RoundsTableData,
          $$RoundsTableTableFilterComposer,
          $$RoundsTableTableOrderingComposer,
          $$RoundsTableTableAnnotationComposer,
          $$RoundsTableTableCreateCompanionBuilder,
          $$RoundsTableTableUpdateCompanionBuilder,
          (RoundsTableData, $$RoundsTableTableReferences),
          RoundsTableData,
          PrefetchHooks Function({bool gameId, bool roundScoresTableRefs})
        > {
  $$RoundsTableTableTableManager(_$AppDatabase db, $RoundsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoundsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoundsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoundsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> roundId = const Value.absent(),
                Value<String> gameId = const Value.absent(),
                Value<int> roundNumber = const Value.absent(),
                Value<int> caboPlayerIndex = const Value.absent(),
                Value<int?> kamikazePlayerIndex = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoundsTableCompanion(
                roundId: roundId,
                gameId: gameId,
                roundNumber: roundNumber,
                caboPlayerIndex: caboPlayerIndex,
                kamikazePlayerIndex: kamikazePlayerIndex,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String roundId,
                required String gameId,
                required int roundNumber,
                required int caboPlayerIndex,
                Value<int?> kamikazePlayerIndex = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoundsTableCompanion.insert(
                roundId: roundId,
                gameId: gameId,
                roundNumber: roundNumber,
                caboPlayerIndex: caboPlayerIndex,
                kamikazePlayerIndex: kamikazePlayerIndex,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoundsTableTable, RoundsTableData>(table),
                  $$RoundsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({gameId = false, roundScoresTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (roundScoresTableRefs) db.roundScoresTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (gameId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gameId,
                            referencedTable: $$RoundsTableTableReferences
                                ._gameIdTable(db),
                            referencedColumn: $$RoundsTableTableReferences
                                ._gameIdTable(db)
                                .gameId,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (roundScoresTableRefs)
                        await $_getPrefetchedData<
                          RoundsTableData,
                          $RoundsTableTable,
                          RoundScoresTableData
                        >(
                          currentTable: table,
                          referencedTable: $$RoundsTableTableReferences
                              ._roundScoresTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoundsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).roundScoresTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.roundId == item.roundId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RoundsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoundsTableTable,
      RoundsTableData,
      $$RoundsTableTableFilterComposer,
      $$RoundsTableTableOrderingComposer,
      $$RoundsTableTableAnnotationComposer,
      $$RoundsTableTableCreateCompanionBuilder,
      $$RoundsTableTableUpdateCompanionBuilder,
      (RoundsTableData, $$RoundsTableTableReferences),
      RoundsTableData,
      PrefetchHooks Function({bool gameId, bool roundScoresTableRefs})
    >;
typedef $$RoundScoresTableTableCreateCompanionBuilder =
    RoundScoresTableCompanion Function({
      required String roundId,
      required String playerId,
      required int score,
      required int scoreUpdate,
      Value<int> rowid,
    });
typedef $$RoundScoresTableTableUpdateCompanionBuilder =
    RoundScoresTableCompanion Function({
      Value<String> roundId,
      Value<String> playerId,
      Value<int> score,
      Value<int> scoreUpdate,
      Value<int> rowid,
    });

final class $$RoundScoresTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RoundScoresTableTable,
          RoundScoresTableData
        > {
  $$RoundScoresTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RoundsTableTable _roundIdTable(_$AppDatabase db) => db.roundsTable
      .createAlias('round_scores_table__round_id__rounds_table__round_id');

  $$RoundsTableTableProcessedTableManager get roundId {
    final $_column = $_itemColumn<String>('round_id')!;

    final manager = $$RoundsTableTableTableManager(
      $_db,
      $_db.roundsTable,
    ).filter((f) => f.roundId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roundIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayerTableTable _playerIdTable(_$AppDatabase db) => db.playerTable
      .createAlias('round_scores_table__player_id__player_table__player_id');

  $$PlayerTableTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<String>('player_id')!;

    final manager = $$PlayerTableTableTableManager(
      $_db,
      $_db.playerTable,
    ).filter((f) => f.playerId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RoundScoresTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoundScoresTableTable> {
  $$RoundScoresTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreUpdate => $composableBuilder(
    column: $table.scoreUpdate,
    builder: (column) => ColumnFilters(column),
  );

  $$RoundsTableTableFilterComposer get roundId {
    final $$RoundsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundsTable,
      getReferencedColumn: (t) => t.roundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundsTableTableFilterComposer(
            $db: $db,
            $table: $db.roundsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayerTableTableFilterComposer get playerId {
    final $$PlayerTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableFilterComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoundScoresTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoundScoresTableTable> {
  $$RoundScoresTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreUpdate => $composableBuilder(
    column: $table.scoreUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoundsTableTableOrderingComposer get roundId {
    final $$RoundsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundsTable,
      getReferencedColumn: (t) => t.roundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundsTableTableOrderingComposer(
            $db: $db,
            $table: $db.roundsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayerTableTableOrderingComposer get playerId {
    final $$PlayerTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableOrderingComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoundScoresTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoundScoresTableTable> {
  $$RoundScoresTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get scoreUpdate => $composableBuilder(
    column: $table.scoreUpdate,
    builder: (column) => column,
  );

  $$RoundsTableTableAnnotationComposer get roundId {
    final $$RoundsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundsTable,
      getReferencedColumn: (t) => t.roundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.roundsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayerTableTableAnnotationComposer get playerId {
    final $$PlayerTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableAnnotationComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoundScoresTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoundScoresTableTable,
          RoundScoresTableData,
          $$RoundScoresTableTableFilterComposer,
          $$RoundScoresTableTableOrderingComposer,
          $$RoundScoresTableTableAnnotationComposer,
          $$RoundScoresTableTableCreateCompanionBuilder,
          $$RoundScoresTableTableUpdateCompanionBuilder,
          (RoundScoresTableData, $$RoundScoresTableTableReferences),
          RoundScoresTableData,
          PrefetchHooks Function({bool roundId, bool playerId})
        > {
  $$RoundScoresTableTableTableManager(
    _$AppDatabase db,
    $RoundScoresTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoundScoresTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoundScoresTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoundScoresTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> roundId = const Value.absent(),
                Value<String> playerId = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> scoreUpdate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoundScoresTableCompanion(
                roundId: roundId,
                playerId: playerId,
                score: score,
                scoreUpdate: scoreUpdate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String roundId,
                required String playerId,
                required int score,
                required int scoreUpdate,
                Value<int> rowid = const Value.absent(),
              }) => RoundScoresTableCompanion.insert(
                roundId: roundId,
                playerId: playerId,
                score: score,
                scoreUpdate: scoreUpdate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoundScoresTableTable, RoundScoresTableData>(
                    table,
                  ),
                  $$RoundScoresTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({roundId = false, playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (roundId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.roundId,
                        referencedTable: $$RoundScoresTableTableReferences
                            ._roundIdTable(db),
                        referencedColumn: $$RoundScoresTableTableReferences
                            ._roundIdTable(db)
                            .roundId,
                      ) as T;
                    }
                    if (playerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.playerId,
                        referencedTable: $$RoundScoresTableTableReferences
                            ._playerIdTable(db),
                        referencedColumn: $$RoundScoresTableTableReferences
                            ._playerIdTable(db)
                            .playerId,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RoundScoresTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoundScoresTableTable,
      RoundScoresTableData,
      $$RoundScoresTableTableFilterComposer,
      $$RoundScoresTableTableOrderingComposer,
      $$RoundScoresTableTableAnnotationComposer,
      $$RoundScoresTableTableCreateCompanionBuilder,
      $$RoundScoresTableTableUpdateCompanionBuilder,
      (RoundScoresTableData, $$RoundScoresTableTableReferences),
      RoundScoresTableData,
      PrefetchHooks Function({bool roundId, bool playerId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GameSessionTableTableTableManager get gameSessionTable =>
      $$GameSessionTableTableTableManager(_db, _db.gameSessionTable);
  $$PlayerTableTableTableManager get playerTable =>
      $$PlayerTableTableTableManager(_db, _db.playerTable);
  $$RoundsTableTableTableManager get roundsTable =>
      $$RoundsTableTableTableManager(_db, _db.roundsTable);
  $$RoundScoresTableTableTableManager get roundScoresTable =>
      $$RoundScoresTableTableTableManager(_db, _db.roundScoresTable);
}
