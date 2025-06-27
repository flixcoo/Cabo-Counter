// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $GameSessionTableTable extends GameSessionTable
    with TableInfo<$GameSessionTableTable, GameSessionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameSessionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _gameTitleMeta =
      const VerificationMeta('gameTitle');
  @override
  late final GeneratedColumn<String> gameTitle = GeneratedColumn<String>(
      'game_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pointLimitMeta =
      const VerificationMeta('pointLimit');
  @override
  late final GeneratedColumn<int> pointLimit = GeneratedColumn<int>(
      'point_limit', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _caboPenaltyMeta =
      const VerificationMeta('caboPenalty');
  @override
  late final GeneratedColumn<int> caboPenalty = GeneratedColumn<int>(
      'cabo_penalty', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isPointsLimitEnabledMeta =
      const VerificationMeta('isPointsLimitEnabled');
  @override
  late final GeneratedColumn<bool> isPointsLimitEnabled = GeneratedColumn<bool>(
      'is_points_limit_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_points_limit_enabled" IN (0, 1))'));
  static const VerificationMeta _isGameFinishedMeta =
      const VerificationMeta('isGameFinished');
  @override
  late final GeneratedColumn<bool> isGameFinished = GeneratedColumn<bool>(
      'is_game_finished', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_game_finished" IN (0, 1))'));
  static const VerificationMeta _winnerMeta = const VerificationMeta('winner');
  @override
  late final GeneratedColumn<String> winner = GeneratedColumn<String>(
      'winner', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roundNumberMeta =
      const VerificationMeta('roundNumber');
  @override
  late final GeneratedColumn<int> roundNumber = GeneratedColumn<int>(
      'round_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        gameTitle,
        pointLimit,
        caboPenalty,
        isPointsLimitEnabled,
        isGameFinished,
        winner,
        roundNumber
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_session_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<GameSessionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('game_title')) {
      context.handle(_gameTitleMeta,
          gameTitle.isAcceptableOrUnknown(data['game_title']!, _gameTitleMeta));
    } else if (isInserting) {
      context.missing(_gameTitleMeta);
    }
    if (data.containsKey('point_limit')) {
      context.handle(
          _pointLimitMeta,
          pointLimit.isAcceptableOrUnknown(
              data['point_limit']!, _pointLimitMeta));
    } else if (isInserting) {
      context.missing(_pointLimitMeta);
    }
    if (data.containsKey('cabo_penalty')) {
      context.handle(
          _caboPenaltyMeta,
          caboPenalty.isAcceptableOrUnknown(
              data['cabo_penalty']!, _caboPenaltyMeta));
    } else if (isInserting) {
      context.missing(_caboPenaltyMeta);
    }
    if (data.containsKey('is_points_limit_enabled')) {
      context.handle(
          _isPointsLimitEnabledMeta,
          isPointsLimitEnabled.isAcceptableOrUnknown(
              data['is_points_limit_enabled']!, _isPointsLimitEnabledMeta));
    } else if (isInserting) {
      context.missing(_isPointsLimitEnabledMeta);
    }
    if (data.containsKey('is_game_finished')) {
      context.handle(
          _isGameFinishedMeta,
          isGameFinished.isAcceptableOrUnknown(
              data['is_game_finished']!, _isGameFinishedMeta));
    } else if (isInserting) {
      context.missing(_isGameFinishedMeta);
    }
    if (data.containsKey('winner')) {
      context.handle(_winnerMeta,
          winner.isAcceptableOrUnknown(data['winner']!, _winnerMeta));
    }
    if (data.containsKey('round_number')) {
      context.handle(
          _roundNumberMeta,
          roundNumber.isAcceptableOrUnknown(
              data['round_number']!, _roundNumberMeta));
    } else if (isInserting) {
      context.missing(_roundNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameSessionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameSessionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      gameTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}game_title'])!,
      pointLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}point_limit'])!,
      caboPenalty: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cabo_penalty'])!,
      isPointsLimitEnabled: attachedDatabase.typeMapping.read(DriftSqlType.bool,
          data['${effectivePrefix}is_points_limit_enabled'])!,
      isGameFinished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_game_finished'])!,
      winner: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}winner']),
      roundNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}round_number'])!,
    );
  }

  @override
  $GameSessionTableTable createAlias(String alias) {
    return $GameSessionTableTable(attachedDatabase, alias);
  }
}

class GameSessionTableData extends DataClass
    implements Insertable<GameSessionTableData> {
  final String id;
  final DateTime createdAt;
  final String gameTitle;
  final int pointLimit;
  final int caboPenalty;
  final bool isPointsLimitEnabled;
  final bool isGameFinished;
  final String? winner;
  final int roundNumber;
  const GameSessionTableData(
      {required this.id,
      required this.createdAt,
      required this.gameTitle,
      required this.pointLimit,
      required this.caboPenalty,
      required this.isPointsLimitEnabled,
      required this.isGameFinished,
      this.winner,
      required this.roundNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['game_title'] = Variable<String>(gameTitle);
    map['point_limit'] = Variable<int>(pointLimit);
    map['cabo_penalty'] = Variable<int>(caboPenalty);
    map['is_points_limit_enabled'] = Variable<bool>(isPointsLimitEnabled);
    map['is_game_finished'] = Variable<bool>(isGameFinished);
    if (!nullToAbsent || winner != null) {
      map['winner'] = Variable<String>(winner);
    }
    map['round_number'] = Variable<int>(roundNumber);
    return map;
  }

  GameSessionTableCompanion toCompanion(bool nullToAbsent) {
    return GameSessionTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      gameTitle: Value(gameTitle),
      pointLimit: Value(pointLimit),
      caboPenalty: Value(caboPenalty),
      isPointsLimitEnabled: Value(isPointsLimitEnabled),
      isGameFinished: Value(isGameFinished),
      winner:
          winner == null && nullToAbsent ? const Value.absent() : Value(winner),
      roundNumber: Value(roundNumber),
    );
  }

  factory GameSessionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameSessionTableData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      gameTitle: serializer.fromJson<String>(json['gameTitle']),
      pointLimit: serializer.fromJson<int>(json['pointLimit']),
      caboPenalty: serializer.fromJson<int>(json['caboPenalty']),
      isPointsLimitEnabled:
          serializer.fromJson<bool>(json['isPointsLimitEnabled']),
      isGameFinished: serializer.fromJson<bool>(json['isGameFinished']),
      winner: serializer.fromJson<String?>(json['winner']),
      roundNumber: serializer.fromJson<int>(json['roundNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'gameTitle': serializer.toJson<String>(gameTitle),
      'pointLimit': serializer.toJson<int>(pointLimit),
      'caboPenalty': serializer.toJson<int>(caboPenalty),
      'isPointsLimitEnabled': serializer.toJson<bool>(isPointsLimitEnabled),
      'isGameFinished': serializer.toJson<bool>(isGameFinished),
      'winner': serializer.toJson<String?>(winner),
      'roundNumber': serializer.toJson<int>(roundNumber),
    };
  }

  GameSessionTableData copyWith(
          {String? id,
          DateTime? createdAt,
          String? gameTitle,
          int? pointLimit,
          int? caboPenalty,
          bool? isPointsLimitEnabled,
          bool? isGameFinished,
          Value<String?> winner = const Value.absent(),
          int? roundNumber}) =>
      GameSessionTableData(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        gameTitle: gameTitle ?? this.gameTitle,
        pointLimit: pointLimit ?? this.pointLimit,
        caboPenalty: caboPenalty ?? this.caboPenalty,
        isPointsLimitEnabled: isPointsLimitEnabled ?? this.isPointsLimitEnabled,
        isGameFinished: isGameFinished ?? this.isGameFinished,
        winner: winner.present ? winner.value : this.winner,
        roundNumber: roundNumber ?? this.roundNumber,
      );
  GameSessionTableData copyWithCompanion(GameSessionTableCompanion data) {
    return GameSessionTableData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      gameTitle: data.gameTitle.present ? data.gameTitle.value : this.gameTitle,
      pointLimit:
          data.pointLimit.present ? data.pointLimit.value : this.pointLimit,
      caboPenalty:
          data.caboPenalty.present ? data.caboPenalty.value : this.caboPenalty,
      isPointsLimitEnabled: data.isPointsLimitEnabled.present
          ? data.isPointsLimitEnabled.value
          : this.isPointsLimitEnabled,
      isGameFinished: data.isGameFinished.present
          ? data.isGameFinished.value
          : this.isGameFinished,
      winner: data.winner.present ? data.winner.value : this.winner,
      roundNumber:
          data.roundNumber.present ? data.roundNumber.value : this.roundNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameSessionTableData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('gameTitle: $gameTitle, ')
          ..write('pointLimit: $pointLimit, ')
          ..write('caboPenalty: $caboPenalty, ')
          ..write('isPointsLimitEnabled: $isPointsLimitEnabled, ')
          ..write('isGameFinished: $isGameFinished, ')
          ..write('winner: $winner, ')
          ..write('roundNumber: $roundNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, gameTitle, pointLimit,
      caboPenalty, isPointsLimitEnabled, isGameFinished, winner, roundNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameSessionTableData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.gameTitle == this.gameTitle &&
          other.pointLimit == this.pointLimit &&
          other.caboPenalty == this.caboPenalty &&
          other.isPointsLimitEnabled == this.isPointsLimitEnabled &&
          other.isGameFinished == this.isGameFinished &&
          other.winner == this.winner &&
          other.roundNumber == this.roundNumber);
}

class GameSessionTableCompanion extends UpdateCompanion<GameSessionTableData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<String> gameTitle;
  final Value<int> pointLimit;
  final Value<int> caboPenalty;
  final Value<bool> isPointsLimitEnabled;
  final Value<bool> isGameFinished;
  final Value<String?> winner;
  final Value<int> roundNumber;
  final Value<int> rowid;
  const GameSessionTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.gameTitle = const Value.absent(),
    this.pointLimit = const Value.absent(),
    this.caboPenalty = const Value.absent(),
    this.isPointsLimitEnabled = const Value.absent(),
    this.isGameFinished = const Value.absent(),
    this.winner = const Value.absent(),
    this.roundNumber = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameSessionTableCompanion.insert({
    required String id,
    required DateTime createdAt,
    required String gameTitle,
    required int pointLimit,
    required int caboPenalty,
    required bool isPointsLimitEnabled,
    required bool isGameFinished,
    this.winner = const Value.absent(),
    required int roundNumber,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        createdAt = Value(createdAt),
        gameTitle = Value(gameTitle),
        pointLimit = Value(pointLimit),
        caboPenalty = Value(caboPenalty),
        isPointsLimitEnabled = Value(isPointsLimitEnabled),
        isGameFinished = Value(isGameFinished),
        roundNumber = Value(roundNumber);
  static Insertable<GameSessionTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? gameTitle,
    Expression<int>? pointLimit,
    Expression<int>? caboPenalty,
    Expression<bool>? isPointsLimitEnabled,
    Expression<bool>? isGameFinished,
    Expression<String>? winner,
    Expression<int>? roundNumber,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (gameTitle != null) 'game_title': gameTitle,
      if (pointLimit != null) 'point_limit': pointLimit,
      if (caboPenalty != null) 'cabo_penalty': caboPenalty,
      if (isPointsLimitEnabled != null)
        'is_points_limit_enabled': isPointsLimitEnabled,
      if (isGameFinished != null) 'is_game_finished': isGameFinished,
      if (winner != null) 'winner': winner,
      if (roundNumber != null) 'round_number': roundNumber,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameSessionTableCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<String>? gameTitle,
      Value<int>? pointLimit,
      Value<int>? caboPenalty,
      Value<bool>? isPointsLimitEnabled,
      Value<bool>? isGameFinished,
      Value<String?>? winner,
      Value<int>? roundNumber,
      Value<int>? rowid}) {
    return GameSessionTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      gameTitle: gameTitle ?? this.gameTitle,
      pointLimit: pointLimit ?? this.pointLimit,
      caboPenalty: caboPenalty ?? this.caboPenalty,
      isPointsLimitEnabled: isPointsLimitEnabled ?? this.isPointsLimitEnabled,
      isGameFinished: isGameFinished ?? this.isGameFinished,
      winner: winner ?? this.winner,
      roundNumber: roundNumber ?? this.roundNumber,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
      map['is_points_limit_enabled'] =
          Variable<bool>(isPointsLimitEnabled.value);
    }
    if (isGameFinished.present) {
      map['is_game_finished'] = Variable<bool>(isGameFinished.value);
    }
    if (winner.present) {
      map['winner'] = Variable<String>(winner.value);
    }
    if (roundNumber.present) {
      map['round_number'] = Variable<int>(roundNumber.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameSessionTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('gameTitle: $gameTitle, ')
          ..write('pointLimit: $pointLimit, ')
          ..write('caboPenalty: $caboPenalty, ')
          ..write('isPointsLimitEnabled: $isPointsLimitEnabled, ')
          ..write('isGameFinished: $isGameFinished, ')
          ..write('winner: $winner, ')
          ..write('roundNumber: $roundNumber, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlayersTableTable extends PlayersTable
    with TableInfo<$PlayersTableTable, PlayersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES game_session_table (id) ON DELETE CASCADE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players_table';
  @override
  VerificationContext validateIntegrity(Insertable<PlayersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PlayersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $PlayersTableTable createAlias(String alias) {
    return $PlayersTableTable(attachedDatabase, alias);
  }
}

class PlayersTableData extends DataClass
    implements Insertable<PlayersTableData> {
  final String id;
  final String name;
  const PlayersTableData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  PlayersTableCompanion toCompanion(bool nullToAbsent) {
    return PlayersTableCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory PlayersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayersTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  PlayersTableData copyWith({String? id, String? name}) => PlayersTableData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  PlayersTableData copyWithCompanion(PlayersTableCompanion data) {
    return PlayersTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayersTableData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayersTableData &&
          other.id == this.id &&
          other.name == this.name);
}

class PlayersTableCompanion extends UpdateCompanion<PlayersTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const PlayersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayersTableCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<PlayersTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayersTableCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return PlayersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
    return (StringBuffer('PlayersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlayerScoresTableTable extends PlayerScoresTable
    with TableInfo<$PlayerScoresTableTable, PlayerScoresTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerScoresTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _roundIdMeta =
      const VerificationMeta('roundId');
  @override
  late final GeneratedColumn<String> roundId = GeneratedColumn<String>(
      'round_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES game_session_table (id) ON DELETE CASCADE'));
  static const VerificationMeta _playerNameMeta =
      const VerificationMeta('playerName');
  @override
  late final GeneratedColumn<String> playerName = GeneratedColumn<String>(
      'player_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES players_table (name)'));
  static const VerificationMeta _totalScoreMeta =
      const VerificationMeta('totalScore');
  @override
  late final GeneratedColumn<int> totalScore = GeneratedColumn<int>(
      'total_score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [roundId, playerName, totalScore];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_scores_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlayerScoresTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('round_id')) {
      context.handle(_roundIdMeta,
          roundId.isAcceptableOrUnknown(data['round_id']!, _roundIdMeta));
    } else if (isInserting) {
      context.missing(_roundIdMeta);
    }
    if (data.containsKey('player_name')) {
      context.handle(
          _playerNameMeta,
          playerName.isAcceptableOrUnknown(
              data['player_name']!, _playerNameMeta));
    } else if (isInserting) {
      context.missing(_playerNameMeta);
    }
    if (data.containsKey('total_score')) {
      context.handle(
          _totalScoreMeta,
          totalScore.isAcceptableOrUnknown(
              data['total_score']!, _totalScoreMeta));
    } else if (isInserting) {
      context.missing(_totalScoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {roundId, playerName};
  @override
  PlayerScoresTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerScoresTableData(
      roundId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}round_id'])!,
      playerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_name'])!,
      totalScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_score'])!,
    );
  }

  @override
  $PlayerScoresTableTable createAlias(String alias) {
    return $PlayerScoresTableTable(attachedDatabase, alias);
  }
}

class PlayerScoresTableData extends DataClass
    implements Insertable<PlayerScoresTableData> {
  final String roundId;
  final String playerName;
  final int totalScore;
  const PlayerScoresTableData(
      {required this.roundId,
      required this.playerName,
      required this.totalScore});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['round_id'] = Variable<String>(roundId);
    map['player_name'] = Variable<String>(playerName);
    map['total_score'] = Variable<int>(totalScore);
    return map;
  }

  PlayerScoresTableCompanion toCompanion(bool nullToAbsent) {
    return PlayerScoresTableCompanion(
      roundId: Value(roundId),
      playerName: Value(playerName),
      totalScore: Value(totalScore),
    );
  }

  factory PlayerScoresTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerScoresTableData(
      roundId: serializer.fromJson<String>(json['roundId']),
      playerName: serializer.fromJson<String>(json['playerName']),
      totalScore: serializer.fromJson<int>(json['totalScore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'roundId': serializer.toJson<String>(roundId),
      'playerName': serializer.toJson<String>(playerName),
      'totalScore': serializer.toJson<int>(totalScore),
    };
  }

  PlayerScoresTableData copyWith(
          {String? roundId, String? playerName, int? totalScore}) =>
      PlayerScoresTableData(
        roundId: roundId ?? this.roundId,
        playerName: playerName ?? this.playerName,
        totalScore: totalScore ?? this.totalScore,
      );
  PlayerScoresTableData copyWithCompanion(PlayerScoresTableCompanion data) {
    return PlayerScoresTableData(
      roundId: data.roundId.present ? data.roundId.value : this.roundId,
      playerName:
          data.playerName.present ? data.playerName.value : this.playerName,
      totalScore:
          data.totalScore.present ? data.totalScore.value : this.totalScore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerScoresTableData(')
          ..write('roundId: $roundId, ')
          ..write('playerName: $playerName, ')
          ..write('totalScore: $totalScore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(roundId, playerName, totalScore);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerScoresTableData &&
          other.roundId == this.roundId &&
          other.playerName == this.playerName &&
          other.totalScore == this.totalScore);
}

class PlayerScoresTableCompanion
    extends UpdateCompanion<PlayerScoresTableData> {
  final Value<String> roundId;
  final Value<String> playerName;
  final Value<int> totalScore;
  final Value<int> rowid;
  const PlayerScoresTableCompanion({
    this.roundId = const Value.absent(),
    this.playerName = const Value.absent(),
    this.totalScore = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayerScoresTableCompanion.insert({
    required String roundId,
    required String playerName,
    required int totalScore,
    this.rowid = const Value.absent(),
  })  : roundId = Value(roundId),
        playerName = Value(playerName),
        totalScore = Value(totalScore);
  static Insertable<PlayerScoresTableData> custom({
    Expression<String>? roundId,
    Expression<String>? playerName,
    Expression<int>? totalScore,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (roundId != null) 'round_id': roundId,
      if (playerName != null) 'player_name': playerName,
      if (totalScore != null) 'total_score': totalScore,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayerScoresTableCompanion copyWith(
      {Value<String>? roundId,
      Value<String>? playerName,
      Value<int>? totalScore,
      Value<int>? rowid}) {
    return PlayerScoresTableCompanion(
      roundId: roundId ?? this.roundId,
      playerName: playerName ?? this.playerName,
      totalScore: totalScore ?? this.totalScore,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (roundId.present) {
      map['round_id'] = Variable<String>(roundId.value);
    }
    if (playerName.present) {
      map['player_name'] = Variable<String>(playerName.value);
    }
    if (totalScore.present) {
      map['total_score'] = Variable<int>(totalScore.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerScoresTableCompanion(')
          ..write('roundId: $roundId, ')
          ..write('playerName: $playerName, ')
          ..write('totalScore: $totalScore, ')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
      'game_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES game_session_table (id) ON DELETE CASCADE'));
  static const VerificationMeta _roundNumberMeta =
      const VerificationMeta('roundNumber');
  @override
  late final GeneratedColumn<int> roundNumber = GeneratedColumn<int>(
      'round_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _kamikazePlayerMeta =
      const VerificationMeta('kamikazePlayer');
  @override
  late final GeneratedColumn<String> kamikazePlayer = GeneratedColumn<String>(
      'kamikaze_player', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, gameId, roundNumber, kamikazePlayer];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rounds_table';
  @override
  VerificationContext validateIntegrity(Insertable<RoundsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('game_id')) {
      context.handle(_gameIdMeta,
          gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta));
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('round_number')) {
      context.handle(
          _roundNumberMeta,
          roundNumber.isAcceptableOrUnknown(
              data['round_number']!, _roundNumberMeta));
    } else if (isInserting) {
      context.missing(_roundNumberMeta);
    }
    if (data.containsKey('kamikaze_player')) {
      context.handle(
          _kamikazePlayerMeta,
          kamikazePlayer.isAcceptableOrUnknown(
              data['kamikaze_player']!, _kamikazePlayerMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoundsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoundsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      gameId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}game_id'])!,
      roundNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}round_number'])!,
      kamikazePlayer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kamikaze_player']),
    );
  }

  @override
  $RoundsTableTable createAlias(String alias) {
    return $RoundsTableTable(attachedDatabase, alias);
  }
}

class RoundsTableData extends DataClass implements Insertable<RoundsTableData> {
  final String id;
  final String gameId;
  final int roundNumber;
  final String? kamikazePlayer;
  const RoundsTableData(
      {required this.id,
      required this.gameId,
      required this.roundNumber,
      this.kamikazePlayer});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['game_id'] = Variable<String>(gameId);
    map['round_number'] = Variable<int>(roundNumber);
    if (!nullToAbsent || kamikazePlayer != null) {
      map['kamikaze_player'] = Variable<String>(kamikazePlayer);
    }
    return map;
  }

  RoundsTableCompanion toCompanion(bool nullToAbsent) {
    return RoundsTableCompanion(
      id: Value(id),
      gameId: Value(gameId),
      roundNumber: Value(roundNumber),
      kamikazePlayer: kamikazePlayer == null && nullToAbsent
          ? const Value.absent()
          : Value(kamikazePlayer),
    );
  }

  factory RoundsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoundsTableData(
      id: serializer.fromJson<String>(json['id']),
      gameId: serializer.fromJson<String>(json['gameId']),
      roundNumber: serializer.fromJson<int>(json['roundNumber']),
      kamikazePlayer: serializer.fromJson<String?>(json['kamikazePlayer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gameId': serializer.toJson<String>(gameId),
      'roundNumber': serializer.toJson<int>(roundNumber),
      'kamikazePlayer': serializer.toJson<String?>(kamikazePlayer),
    };
  }

  RoundsTableData copyWith(
          {String? id,
          String? gameId,
          int? roundNumber,
          Value<String?> kamikazePlayer = const Value.absent()}) =>
      RoundsTableData(
        id: id ?? this.id,
        gameId: gameId ?? this.gameId,
        roundNumber: roundNumber ?? this.roundNumber,
        kamikazePlayer:
            kamikazePlayer.present ? kamikazePlayer.value : this.kamikazePlayer,
      );
  RoundsTableData copyWithCompanion(RoundsTableCompanion data) {
    return RoundsTableData(
      id: data.id.present ? data.id.value : this.id,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      roundNumber:
          data.roundNumber.present ? data.roundNumber.value : this.roundNumber,
      kamikazePlayer: data.kamikazePlayer.present
          ? data.kamikazePlayer.value
          : this.kamikazePlayer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoundsTableData(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('roundNumber: $roundNumber, ')
          ..write('kamikazePlayer: $kamikazePlayer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, gameId, roundNumber, kamikazePlayer);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoundsTableData &&
          other.id == this.id &&
          other.gameId == this.gameId &&
          other.roundNumber == this.roundNumber &&
          other.kamikazePlayer == this.kamikazePlayer);
}

class RoundsTableCompanion extends UpdateCompanion<RoundsTableData> {
  final Value<String> id;
  final Value<String> gameId;
  final Value<int> roundNumber;
  final Value<String?> kamikazePlayer;
  final Value<int> rowid;
  const RoundsTableCompanion({
    this.id = const Value.absent(),
    this.gameId = const Value.absent(),
    this.roundNumber = const Value.absent(),
    this.kamikazePlayer = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoundsTableCompanion.insert({
    required String id,
    required String gameId,
    required int roundNumber,
    this.kamikazePlayer = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        gameId = Value(gameId),
        roundNumber = Value(roundNumber);
  static Insertable<RoundsTableData> custom({
    Expression<String>? id,
    Expression<String>? gameId,
    Expression<int>? roundNumber,
    Expression<String>? kamikazePlayer,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gameId != null) 'game_id': gameId,
      if (roundNumber != null) 'round_number': roundNumber,
      if (kamikazePlayer != null) 'kamikaze_player': kamikazePlayer,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoundsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? gameId,
      Value<int>? roundNumber,
      Value<String?>? kamikazePlayer,
      Value<int>? rowid}) {
    return RoundsTableCompanion(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      roundNumber: roundNumber ?? this.roundNumber,
      kamikazePlayer: kamikazePlayer ?? this.kamikazePlayer,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (roundNumber.present) {
      map['round_number'] = Variable<int>(roundNumber.value);
    }
    if (kamikazePlayer.present) {
      map['kamikaze_player'] = Variable<String>(kamikazePlayer.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoundsTableCompanion(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('roundNumber: $roundNumber, ')
          ..write('kamikazePlayer: $kamikazePlayer, ')
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
  static const VerificationMeta _roundIdMeta =
      const VerificationMeta('roundId');
  @override
  late final GeneratedColumn<String> roundId = GeneratedColumn<String>(
      'round_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES rounds_table (id) ON DELETE CASCADE'));
  static const VerificationMeta _playerNameMeta =
      const VerificationMeta('playerName');
  @override
  late final GeneratedColumn<String> playerName = GeneratedColumn<String>(
      'player_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _scoreUpdateMeta =
      const VerificationMeta('scoreUpdate');
  @override
  late final GeneratedColumn<int> scoreUpdate = GeneratedColumn<int>(
      'score_update', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [roundId, playerName, score, scoreUpdate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'round_scores_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<RoundScoresTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('round_id')) {
      context.handle(_roundIdMeta,
          roundId.isAcceptableOrUnknown(data['round_id']!, _roundIdMeta));
    } else if (isInserting) {
      context.missing(_roundIdMeta);
    }
    if (data.containsKey('player_name')) {
      context.handle(
          _playerNameMeta,
          playerName.isAcceptableOrUnknown(
              data['player_name']!, _playerNameMeta));
    } else if (isInserting) {
      context.missing(_playerNameMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('score_update')) {
      context.handle(
          _scoreUpdateMeta,
          scoreUpdate.isAcceptableOrUnknown(
              data['score_update']!, _scoreUpdateMeta));
    } else if (isInserting) {
      context.missing(_scoreUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {roundId, playerName};
  @override
  RoundScoresTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoundScoresTableData(
      roundId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}round_id'])!,
      playerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_name'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score'])!,
      scoreUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score_update'])!,
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
  final String playerName;
  final int score;
  final int scoreUpdate;
  const RoundScoresTableData(
      {required this.roundId,
      required this.playerName,
      required this.score,
      required this.scoreUpdate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['round_id'] = Variable<String>(roundId);
    map['player_name'] = Variable<String>(playerName);
    map['score'] = Variable<int>(score);
    map['score_update'] = Variable<int>(scoreUpdate);
    return map;
  }

  RoundScoresTableCompanion toCompanion(bool nullToAbsent) {
    return RoundScoresTableCompanion(
      roundId: Value(roundId),
      playerName: Value(playerName),
      score: Value(score),
      scoreUpdate: Value(scoreUpdate),
    );
  }

  factory RoundScoresTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoundScoresTableData(
      roundId: serializer.fromJson<String>(json['roundId']),
      playerName: serializer.fromJson<String>(json['playerName']),
      score: serializer.fromJson<int>(json['score']),
      scoreUpdate: serializer.fromJson<int>(json['scoreUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'roundId': serializer.toJson<String>(roundId),
      'playerName': serializer.toJson<String>(playerName),
      'score': serializer.toJson<int>(score),
      'scoreUpdate': serializer.toJson<int>(scoreUpdate),
    };
  }

  RoundScoresTableData copyWith(
          {String? roundId,
          String? playerName,
          int? score,
          int? scoreUpdate}) =>
      RoundScoresTableData(
        roundId: roundId ?? this.roundId,
        playerName: playerName ?? this.playerName,
        score: score ?? this.score,
        scoreUpdate: scoreUpdate ?? this.scoreUpdate,
      );
  RoundScoresTableData copyWithCompanion(RoundScoresTableCompanion data) {
    return RoundScoresTableData(
      roundId: data.roundId.present ? data.roundId.value : this.roundId,
      playerName:
          data.playerName.present ? data.playerName.value : this.playerName,
      score: data.score.present ? data.score.value : this.score,
      scoreUpdate:
          data.scoreUpdate.present ? data.scoreUpdate.value : this.scoreUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoundScoresTableData(')
          ..write('roundId: $roundId, ')
          ..write('playerName: $playerName, ')
          ..write('score: $score, ')
          ..write('scoreUpdate: $scoreUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(roundId, playerName, score, scoreUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoundScoresTableData &&
          other.roundId == this.roundId &&
          other.playerName == this.playerName &&
          other.score == this.score &&
          other.scoreUpdate == this.scoreUpdate);
}

class RoundScoresTableCompanion extends UpdateCompanion<RoundScoresTableData> {
  final Value<String> roundId;
  final Value<String> playerName;
  final Value<int> score;
  final Value<int> scoreUpdate;
  final Value<int> rowid;
  const RoundScoresTableCompanion({
    this.roundId = const Value.absent(),
    this.playerName = const Value.absent(),
    this.score = const Value.absent(),
    this.scoreUpdate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoundScoresTableCompanion.insert({
    required String roundId,
    required String playerName,
    required int score,
    required int scoreUpdate,
    this.rowid = const Value.absent(),
  })  : roundId = Value(roundId),
        playerName = Value(playerName),
        score = Value(score),
        scoreUpdate = Value(scoreUpdate);
  static Insertable<RoundScoresTableData> custom({
    Expression<String>? roundId,
    Expression<String>? playerName,
    Expression<int>? score,
    Expression<int>? scoreUpdate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (roundId != null) 'round_id': roundId,
      if (playerName != null) 'player_name': playerName,
      if (score != null) 'score': score,
      if (scoreUpdate != null) 'score_update': scoreUpdate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoundScoresTableCompanion copyWith(
      {Value<String>? roundId,
      Value<String>? playerName,
      Value<int>? score,
      Value<int>? scoreUpdate,
      Value<int>? rowid}) {
    return RoundScoresTableCompanion(
      roundId: roundId ?? this.roundId,
      playerName: playerName ?? this.playerName,
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
    if (playerName.present) {
      map['player_name'] = Variable<String>(playerName.value);
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
          ..write('playerName: $playerName, ')
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
  late final $GameSessionTableTable gameSessionTable =
      $GameSessionTableTable(this);
  late final $PlayersTableTable playersTable = $PlayersTableTable(this);
  late final $PlayerScoresTableTable playerScoresTable =
      $PlayerScoresTableTable(this);
  late final $RoundsTableTable roundsTable = $RoundsTableTable(this);
  late final $RoundScoresTableTable roundScoresTable =
      $RoundScoresTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        gameSessionTable,
        playersTable,
        playerScoresTable,
        roundsTable,
        roundScoresTable
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('game_session_table',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('players_table', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('game_session_table',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('player_scores_table', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('game_session_table',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('rounds_table', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('rounds_table',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('round_scores_table', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$GameSessionTableTableCreateCompanionBuilder
    = GameSessionTableCompanion Function({
  required String id,
  required DateTime createdAt,
  required String gameTitle,
  required int pointLimit,
  required int caboPenalty,
  required bool isPointsLimitEnabled,
  required bool isGameFinished,
  Value<String?> winner,
  required int roundNumber,
  Value<int> rowid,
});
typedef $$GameSessionTableTableUpdateCompanionBuilder
    = GameSessionTableCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<String> gameTitle,
  Value<int> pointLimit,
  Value<int> caboPenalty,
  Value<bool> isPointsLimitEnabled,
  Value<bool> isGameFinished,
  Value<String?> winner,
  Value<int> roundNumber,
  Value<int> rowid,
});

final class $$GameSessionTableTableReferences extends BaseReferences<
    _$AppDatabase, $GameSessionTableTable, GameSessionTableData> {
  $$GameSessionTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlayersTableTable, List<PlayersTableData>>
      _playersTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.playersTable,
          aliasName:
              $_aliasNameGenerator(db.gameSessionTable.id, db.playersTable.id));

  $$PlayersTableTableProcessedTableManager get playersTableRefs {
    final manager = $$PlayersTableTableTableManager($_db, $_db.playersTable)
        .filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_playersTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PlayerScoresTableTable,
      List<PlayerScoresTableData>> _playerScoresTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.playerScoresTable,
          aliasName: $_aliasNameGenerator(
              db.gameSessionTable.id, db.playerScoresTable.roundId));

  $$PlayerScoresTableTableProcessedTableManager get playerScoresTableRefs {
    final manager =
        $$PlayerScoresTableTableTableManager($_db, $_db.playerScoresTable)
            .filter((f) => f.roundId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_playerScoresTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RoundsTableTable, List<RoundsTableData>>
      _roundsTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.roundsTable,
              aliasName: $_aliasNameGenerator(
                  db.gameSessionTable.id, db.roundsTable.gameId));

  $$RoundsTableTableProcessedTableManager get roundsTableRefs {
    final manager = $$RoundsTableTableTableManager($_db, $_db.roundsTable)
        .filter((f) => f.gameId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_roundsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gameTitle => $composableBuilder(
      column: $table.gameTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pointLimit => $composableBuilder(
      column: $table.pointLimit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get caboPenalty => $composableBuilder(
      column: $table.caboPenalty, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPointsLimitEnabled => $composableBuilder(
      column: $table.isPointsLimitEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isGameFinished => $composableBuilder(
      column: $table.isGameFinished,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get winner => $composableBuilder(
      column: $table.winner, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get roundNumber => $composableBuilder(
      column: $table.roundNumber, builder: (column) => ColumnFilters(column));

  Expression<bool> playersTableRefs(
      Expression<bool> Function($$PlayersTableTableFilterComposer f) f) {
    final $$PlayersTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.playersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableTableFilterComposer(
              $db: $db,
              $table: $db.playersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> playerScoresTableRefs(
      Expression<bool> Function($$PlayerScoresTableTableFilterComposer f) f) {
    final $$PlayerScoresTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.playerScoresTable,
        getReferencedColumn: (t) => t.roundId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayerScoresTableTableFilterComposer(
              $db: $db,
              $table: $db.playerScoresTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> roundsTableRefs(
      Expression<bool> Function($$RoundsTableTableFilterComposer f) f) {
    final $$RoundsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.roundsTable,
        getReferencedColumn: (t) => t.gameId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundsTableTableFilterComposer(
              $db: $db,
              $table: $db.roundsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gameTitle => $composableBuilder(
      column: $table.gameTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pointLimit => $composableBuilder(
      column: $table.pointLimit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get caboPenalty => $composableBuilder(
      column: $table.caboPenalty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPointsLimitEnabled => $composableBuilder(
      column: $table.isPointsLimitEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isGameFinished => $composableBuilder(
      column: $table.isGameFinished,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get winner => $composableBuilder(
      column: $table.winner, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get roundNumber => $composableBuilder(
      column: $table.roundNumber, builder: (column) => ColumnOrderings(column));
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get gameTitle =>
      $composableBuilder(column: $table.gameTitle, builder: (column) => column);

  GeneratedColumn<int> get pointLimit => $composableBuilder(
      column: $table.pointLimit, builder: (column) => column);

  GeneratedColumn<int> get caboPenalty => $composableBuilder(
      column: $table.caboPenalty, builder: (column) => column);

  GeneratedColumn<bool> get isPointsLimitEnabled => $composableBuilder(
      column: $table.isPointsLimitEnabled, builder: (column) => column);

  GeneratedColumn<bool> get isGameFinished => $composableBuilder(
      column: $table.isGameFinished, builder: (column) => column);

  GeneratedColumn<String> get winner =>
      $composableBuilder(column: $table.winner, builder: (column) => column);

  GeneratedColumn<int> get roundNumber => $composableBuilder(
      column: $table.roundNumber, builder: (column) => column);

  Expression<T> playersTableRefs<T extends Object>(
      Expression<T> Function($$PlayersTableTableAnnotationComposer a) f) {
    final $$PlayersTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.playersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableTableAnnotationComposer(
              $db: $db,
              $table: $db.playersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> playerScoresTableRefs<T extends Object>(
      Expression<T> Function($$PlayerScoresTableTableAnnotationComposer a) f) {
    final $$PlayerScoresTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.playerScoresTable,
            getReferencedColumn: (t) => t.roundId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlayerScoresTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.playerScoresTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> roundsTableRefs<T extends Object>(
      Expression<T> Function($$RoundsTableTableAnnotationComposer a) f) {
    final $$RoundsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.roundsTable,
        getReferencedColumn: (t) => t.gameId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.roundsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GameSessionTableTableTableManager extends RootTableManager<
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
    PrefetchHooks Function(
        {bool playersTableRefs,
        bool playerScoresTableRefs,
        bool roundsTableRefs})> {
  $$GameSessionTableTableTableManager(
      _$AppDatabase db, $GameSessionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameSessionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameSessionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameSessionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> gameTitle = const Value.absent(),
            Value<int> pointLimit = const Value.absent(),
            Value<int> caboPenalty = const Value.absent(),
            Value<bool> isPointsLimitEnabled = const Value.absent(),
            Value<bool> isGameFinished = const Value.absent(),
            Value<String?> winner = const Value.absent(),
            Value<int> roundNumber = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GameSessionTableCompanion(
            id: id,
            createdAt: createdAt,
            gameTitle: gameTitle,
            pointLimit: pointLimit,
            caboPenalty: caboPenalty,
            isPointsLimitEnabled: isPointsLimitEnabled,
            isGameFinished: isGameFinished,
            winner: winner,
            roundNumber: roundNumber,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime createdAt,
            required String gameTitle,
            required int pointLimit,
            required int caboPenalty,
            required bool isPointsLimitEnabled,
            required bool isGameFinished,
            Value<String?> winner = const Value.absent(),
            required int roundNumber,
            Value<int> rowid = const Value.absent(),
          }) =>
              GameSessionTableCompanion.insert(
            id: id,
            createdAt: createdAt,
            gameTitle: gameTitle,
            pointLimit: pointLimit,
            caboPenalty: caboPenalty,
            isPointsLimitEnabled: isPointsLimitEnabled,
            isGameFinished: isGameFinished,
            winner: winner,
            roundNumber: roundNumber,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GameSessionTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {playersTableRefs = false,
              playerScoresTableRefs = false,
              roundsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playersTableRefs) db.playersTable,
                if (playerScoresTableRefs) db.playerScoresTable,
                if (roundsTableRefs) db.roundsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playersTableRefs)
                    await $_getPrefetchedData<GameSessionTableData,
                            $GameSessionTableTable, PlayersTableData>(
                        currentTable: table,
                        referencedTable: $$GameSessionTableTableReferences
                            ._playersTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GameSessionTableTableReferences(db, table, p0)
                                .playersTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.id == item.id),
                        typedResults: items),
                  if (playerScoresTableRefs)
                    await $_getPrefetchedData<GameSessionTableData,
                            $GameSessionTableTable, PlayerScoresTableData>(
                        currentTable: table,
                        referencedTable: $$GameSessionTableTableReferences
                            ._playerScoresTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GameSessionTableTableReferences(db, table, p0)
                                .playerScoresTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.roundId == item.id),
                        typedResults: items),
                  if (roundsTableRefs)
                    await $_getPrefetchedData<GameSessionTableData,
                            $GameSessionTableTable, RoundsTableData>(
                        currentTable: table,
                        referencedTable: $$GameSessionTableTableReferences
                            ._roundsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GameSessionTableTableReferences(db, table, p0)
                                .roundsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.gameId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GameSessionTableTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function(
        {bool playersTableRefs,
        bool playerScoresTableRefs,
        bool roundsTableRefs})>;
typedef $$PlayersTableTableCreateCompanionBuilder = PlayersTableCompanion
    Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$PlayersTableTableUpdateCompanionBuilder = PlayersTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$PlayersTableTableReferences extends BaseReferences<_$AppDatabase,
    $PlayersTableTable, PlayersTableData> {
  $$PlayersTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GameSessionTableTable _idTable(_$AppDatabase db) =>
      db.gameSessionTable.createAlias(
          $_aliasNameGenerator(db.playersTable.id, db.gameSessionTable.id));

  $$GameSessionTableTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager =
        $$GameSessionTableTableTableManager($_db, $_db.gameSessionTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PlayerScoresTableTable,
      List<PlayerScoresTableData>> _playerScoresTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.playerScoresTable,
          aliasName: $_aliasNameGenerator(
              db.playersTable.name, db.playerScoresTable.playerName));

  $$PlayerScoresTableTableProcessedTableManager get playerScoresTableRefs {
    final manager = $$PlayerScoresTableTableTableManager(
            $_db, $_db.playerScoresTable)
        .filter(
            (f) => f.playerName.name.sqlEquals($_itemColumn<String>('name')!));

    final cache =
        $_typedResult.readTableOrNull(_playerScoresTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlayersTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTableTable> {
  $$PlayersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  $$GameSessionTableTableFilterComposer get id {
    final $$GameSessionTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gameSessionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameSessionTableTableFilterComposer(
              $db: $db,
              $table: $db.gameSessionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> playerScoresTableRefs(
      Expression<bool> Function($$PlayerScoresTableTableFilterComposer f) f) {
    final $$PlayerScoresTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.name,
        referencedTable: $db.playerScoresTable,
        getReferencedColumn: (t) => t.playerName,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayerScoresTableTableFilterComposer(
              $db: $db,
              $table: $db.playerScoresTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlayersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTableTable> {
  $$PlayersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  $$GameSessionTableTableOrderingComposer get id {
    final $$GameSessionTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gameSessionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameSessionTableTableOrderingComposer(
              $db: $db,
              $table: $db.gameSessionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlayersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTableTable> {
  $$PlayersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$GameSessionTableTableAnnotationComposer get id {
    final $$GameSessionTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gameSessionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameSessionTableTableAnnotationComposer(
              $db: $db,
              $table: $db.gameSessionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> playerScoresTableRefs<T extends Object>(
      Expression<T> Function($$PlayerScoresTableTableAnnotationComposer a) f) {
    final $$PlayerScoresTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.name,
            referencedTable: $db.playerScoresTable,
            getReferencedColumn: (t) => t.playerName,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlayerScoresTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.playerScoresTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PlayersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlayersTableTable,
    PlayersTableData,
    $$PlayersTableTableFilterComposer,
    $$PlayersTableTableOrderingComposer,
    $$PlayersTableTableAnnotationComposer,
    $$PlayersTableTableCreateCompanionBuilder,
    $$PlayersTableTableUpdateCompanionBuilder,
    (PlayersTableData, $$PlayersTableTableReferences),
    PlayersTableData,
    PrefetchHooks Function({bool id, bool playerScoresTableRefs})> {
  $$PlayersTableTableTableManager(_$AppDatabase db, $PlayersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlayersTableCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlayersTableCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlayersTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({id = false, playerScoresTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playerScoresTableRefs) db.playerScoresTable
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (id) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.id,
                    referencedTable: $$PlayersTableTableReferences._idTable(db),
                    referencedColumn:
                        $$PlayersTableTableReferences._idTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playerScoresTableRefs)
                    await $_getPrefetchedData<PlayersTableData,
                            $PlayersTableTable, PlayerScoresTableData>(
                        currentTable: table,
                        referencedTable: $$PlayersTableTableReferences
                            ._playerScoresTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlayersTableTableReferences(db, table, p0)
                                .playerScoresTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.playerName == item.name),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlayersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlayersTableTable,
    PlayersTableData,
    $$PlayersTableTableFilterComposer,
    $$PlayersTableTableOrderingComposer,
    $$PlayersTableTableAnnotationComposer,
    $$PlayersTableTableCreateCompanionBuilder,
    $$PlayersTableTableUpdateCompanionBuilder,
    (PlayersTableData, $$PlayersTableTableReferences),
    PlayersTableData,
    PrefetchHooks Function({bool id, bool playerScoresTableRefs})>;
typedef $$PlayerScoresTableTableCreateCompanionBuilder
    = PlayerScoresTableCompanion Function({
  required String roundId,
  required String playerName,
  required int totalScore,
  Value<int> rowid,
});
typedef $$PlayerScoresTableTableUpdateCompanionBuilder
    = PlayerScoresTableCompanion Function({
  Value<String> roundId,
  Value<String> playerName,
  Value<int> totalScore,
  Value<int> rowid,
});

final class $$PlayerScoresTableTableReferences extends BaseReferences<
    _$AppDatabase, $PlayerScoresTableTable, PlayerScoresTableData> {
  $$PlayerScoresTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GameSessionTableTable _roundIdTable(_$AppDatabase db) =>
      db.gameSessionTable.createAlias($_aliasNameGenerator(
          db.playerScoresTable.roundId, db.gameSessionTable.id));

  $$GameSessionTableTableProcessedTableManager get roundId {
    final $_column = $_itemColumn<String>('round_id')!;

    final manager =
        $$GameSessionTableTableTableManager($_db, $_db.gameSessionTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roundIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PlayersTableTable _playerNameTable(_$AppDatabase db) =>
      db.playersTable.createAlias($_aliasNameGenerator(
          db.playerScoresTable.playerName, db.playersTable.name));

  $$PlayersTableTableProcessedTableManager get playerName {
    final $_column = $_itemColumn<String>('player_name')!;

    final manager = $$PlayersTableTableTableManager($_db, $_db.playersTable)
        .filter((f) => f.name.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerNameTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PlayerScoresTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlayerScoresTableTable> {
  $$PlayerScoresTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get totalScore => $composableBuilder(
      column: $table.totalScore, builder: (column) => ColumnFilters(column));

  $$GameSessionTableTableFilterComposer get roundId {
    final $$GameSessionTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roundId,
        referencedTable: $db.gameSessionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameSessionTableTableFilterComposer(
              $db: $db,
              $table: $db.gameSessionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableTableFilterComposer get playerName {
    final $$PlayersTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerName,
        referencedTable: $db.playersTable,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableTableFilterComposer(
              $db: $db,
              $table: $db.playersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlayerScoresTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayerScoresTableTable> {
  $$PlayerScoresTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get totalScore => $composableBuilder(
      column: $table.totalScore, builder: (column) => ColumnOrderings(column));

  $$GameSessionTableTableOrderingComposer get roundId {
    final $$GameSessionTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roundId,
        referencedTable: $db.gameSessionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameSessionTableTableOrderingComposer(
              $db: $db,
              $table: $db.gameSessionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableTableOrderingComposer get playerName {
    final $$PlayersTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerName,
        referencedTable: $db.playersTable,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableTableOrderingComposer(
              $db: $db,
              $table: $db.playersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlayerScoresTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayerScoresTableTable> {
  $$PlayerScoresTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get totalScore => $composableBuilder(
      column: $table.totalScore, builder: (column) => column);

  $$GameSessionTableTableAnnotationComposer get roundId {
    final $$GameSessionTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roundId,
        referencedTable: $db.gameSessionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameSessionTableTableAnnotationComposer(
              $db: $db,
              $table: $db.gameSessionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableTableAnnotationComposer get playerName {
    final $$PlayersTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerName,
        referencedTable: $db.playersTable,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableTableAnnotationComposer(
              $db: $db,
              $table: $db.playersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlayerScoresTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlayerScoresTableTable,
    PlayerScoresTableData,
    $$PlayerScoresTableTableFilterComposer,
    $$PlayerScoresTableTableOrderingComposer,
    $$PlayerScoresTableTableAnnotationComposer,
    $$PlayerScoresTableTableCreateCompanionBuilder,
    $$PlayerScoresTableTableUpdateCompanionBuilder,
    (PlayerScoresTableData, $$PlayerScoresTableTableReferences),
    PlayerScoresTableData,
    PrefetchHooks Function({bool roundId, bool playerName})> {
  $$PlayerScoresTableTableTableManager(
      _$AppDatabase db, $PlayerScoresTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerScoresTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerScoresTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerScoresTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> roundId = const Value.absent(),
            Value<String> playerName = const Value.absent(),
            Value<int> totalScore = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlayerScoresTableCompanion(
            roundId: roundId,
            playerName: playerName,
            totalScore: totalScore,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String roundId,
            required String playerName,
            required int totalScore,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlayerScoresTableCompanion.insert(
            roundId: roundId,
            playerName: playerName,
            totalScore: totalScore,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlayerScoresTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({roundId = false, playerName = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (roundId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.roundId,
                    referencedTable:
                        $$PlayerScoresTableTableReferences._roundIdTable(db),
                    referencedColumn:
                        $$PlayerScoresTableTableReferences._roundIdTable(db).id,
                  ) as T;
                }
                if (playerName) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playerName,
                    referencedTable:
                        $$PlayerScoresTableTableReferences._playerNameTable(db),
                    referencedColumn: $$PlayerScoresTableTableReferences
                        ._playerNameTable(db)
                        .name,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PlayerScoresTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlayerScoresTableTable,
    PlayerScoresTableData,
    $$PlayerScoresTableTableFilterComposer,
    $$PlayerScoresTableTableOrderingComposer,
    $$PlayerScoresTableTableAnnotationComposer,
    $$PlayerScoresTableTableCreateCompanionBuilder,
    $$PlayerScoresTableTableUpdateCompanionBuilder,
    (PlayerScoresTableData, $$PlayerScoresTableTableReferences),
    PlayerScoresTableData,
    PrefetchHooks Function({bool roundId, bool playerName})>;
typedef $$RoundsTableTableCreateCompanionBuilder = RoundsTableCompanion
    Function({
  required String id,
  required String gameId,
  required int roundNumber,
  Value<String?> kamikazePlayer,
  Value<int> rowid,
});
typedef $$RoundsTableTableUpdateCompanionBuilder = RoundsTableCompanion
    Function({
  Value<String> id,
  Value<String> gameId,
  Value<int> roundNumber,
  Value<String?> kamikazePlayer,
  Value<int> rowid,
});

final class $$RoundsTableTableReferences
    extends BaseReferences<_$AppDatabase, $RoundsTableTable, RoundsTableData> {
  $$RoundsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GameSessionTableTable _gameIdTable(_$AppDatabase db) =>
      db.gameSessionTable.createAlias(
          $_aliasNameGenerator(db.roundsTable.gameId, db.gameSessionTable.id));

  $$GameSessionTableTableProcessedTableManager get gameId {
    final $_column = $_itemColumn<String>('game_id')!;

    final manager =
        $$GameSessionTableTableTableManager($_db, $_db.gameSessionTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$RoundScoresTableTable, List<RoundScoresTableData>>
      _roundScoresTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.roundScoresTable,
              aliasName: $_aliasNameGenerator(
                  db.roundsTable.id, db.roundScoresTable.roundId));

  $$RoundScoresTableTableProcessedTableManager get roundScoresTableRefs {
    final manager =
        $$RoundScoresTableTableTableManager($_db, $_db.roundScoresTable)
            .filter((f) => f.roundId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_roundScoresTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get roundNumber => $composableBuilder(
      column: $table.roundNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kamikazePlayer => $composableBuilder(
      column: $table.kamikazePlayer,
      builder: (column) => ColumnFilters(column));

  $$GameSessionTableTableFilterComposer get gameId {
    final $$GameSessionTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gameId,
        referencedTable: $db.gameSessionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameSessionTableTableFilterComposer(
              $db: $db,
              $table: $db.gameSessionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> roundScoresTableRefs(
      Expression<bool> Function($$RoundScoresTableTableFilterComposer f) f) {
    final $$RoundScoresTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.roundScoresTable,
        getReferencedColumn: (t) => t.roundId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundScoresTableTableFilterComposer(
              $db: $db,
              $table: $db.roundScoresTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get roundNumber => $composableBuilder(
      column: $table.roundNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kamikazePlayer => $composableBuilder(
      column: $table.kamikazePlayer,
      builder: (column) => ColumnOrderings(column));

  $$GameSessionTableTableOrderingComposer get gameId {
    final $$GameSessionTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gameId,
        referencedTable: $db.gameSessionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameSessionTableTableOrderingComposer(
              $db: $db,
              $table: $db.gameSessionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get roundNumber => $composableBuilder(
      column: $table.roundNumber, builder: (column) => column);

  GeneratedColumn<String> get kamikazePlayer => $composableBuilder(
      column: $table.kamikazePlayer, builder: (column) => column);

  $$GameSessionTableTableAnnotationComposer get gameId {
    final $$GameSessionTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gameId,
        referencedTable: $db.gameSessionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameSessionTableTableAnnotationComposer(
              $db: $db,
              $table: $db.gameSessionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> roundScoresTableRefs<T extends Object>(
      Expression<T> Function($$RoundScoresTableTableAnnotationComposer a) f) {
    final $$RoundScoresTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.roundScoresTable,
        getReferencedColumn: (t) => t.roundId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundScoresTableTableAnnotationComposer(
              $db: $db,
              $table: $db.roundScoresTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoundsTableTableTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool gameId, bool roundScoresTableRefs})> {
  $$RoundsTableTableTableManager(_$AppDatabase db, $RoundsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoundsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoundsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoundsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> gameId = const Value.absent(),
            Value<int> roundNumber = const Value.absent(),
            Value<String?> kamikazePlayer = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RoundsTableCompanion(
            id: id,
            gameId: gameId,
            roundNumber: roundNumber,
            kamikazePlayer: kamikazePlayer,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String gameId,
            required int roundNumber,
            Value<String?> kamikazePlayer = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RoundsTableCompanion.insert(
            id: id,
            gameId: gameId,
            roundNumber: roundNumber,
            kamikazePlayer: kamikazePlayer,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RoundsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {gameId = false, roundScoresTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (roundScoresTableRefs) db.roundScoresTable
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (gameId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.gameId,
                    referencedTable:
                        $$RoundsTableTableReferences._gameIdTable(db),
                    referencedColumn:
                        $$RoundsTableTableReferences._gameIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (roundScoresTableRefs)
                    await $_getPrefetchedData<RoundsTableData,
                            $RoundsTableTable, RoundScoresTableData>(
                        currentTable: table,
                        referencedTable: $$RoundsTableTableReferences
                            ._roundScoresTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RoundsTableTableReferences(db, table, p0)
                                .roundScoresTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.roundId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RoundsTableTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool gameId, bool roundScoresTableRefs})>;
typedef $$RoundScoresTableTableCreateCompanionBuilder
    = RoundScoresTableCompanion Function({
  required String roundId,
  required String playerName,
  required int score,
  required int scoreUpdate,
  Value<int> rowid,
});
typedef $$RoundScoresTableTableUpdateCompanionBuilder
    = RoundScoresTableCompanion Function({
  Value<String> roundId,
  Value<String> playerName,
  Value<int> score,
  Value<int> scoreUpdate,
  Value<int> rowid,
});

final class $$RoundScoresTableTableReferences extends BaseReferences<
    _$AppDatabase, $RoundScoresTableTable, RoundScoresTableData> {
  $$RoundScoresTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RoundsTableTable _roundIdTable(_$AppDatabase db) =>
      db.roundsTable.createAlias(
          $_aliasNameGenerator(db.roundScoresTable.roundId, db.roundsTable.id));

  $$RoundsTableTableProcessedTableManager get roundId {
    final $_column = $_itemColumn<String>('round_id')!;

    final manager = $$RoundsTableTableTableManager($_db, $_db.roundsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roundIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
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
  ColumnFilters<String> get playerName => $composableBuilder(
      column: $table.playerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get scoreUpdate => $composableBuilder(
      column: $table.scoreUpdate, builder: (column) => ColumnFilters(column));

  $$RoundsTableTableFilterComposer get roundId {
    final $$RoundsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roundId,
        referencedTable: $db.roundsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundsTableTableFilterComposer(
              $db: $db,
              $table: $db.roundsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
  ColumnOrderings<String> get playerName => $composableBuilder(
      column: $table.playerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scoreUpdate => $composableBuilder(
      column: $table.scoreUpdate, builder: (column) => ColumnOrderings(column));

  $$RoundsTableTableOrderingComposer get roundId {
    final $$RoundsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roundId,
        referencedTable: $db.roundsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundsTableTableOrderingComposer(
              $db: $db,
              $table: $db.roundsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
  GeneratedColumn<String> get playerName => $composableBuilder(
      column: $table.playerName, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get scoreUpdate => $composableBuilder(
      column: $table.scoreUpdate, builder: (column) => column);

  $$RoundsTableTableAnnotationComposer get roundId {
    final $$RoundsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roundId,
        referencedTable: $db.roundsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.roundsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RoundScoresTableTableTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool roundId})> {
  $$RoundScoresTableTableTableManager(
      _$AppDatabase db, $RoundScoresTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoundScoresTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoundScoresTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoundScoresTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> roundId = const Value.absent(),
            Value<String> playerName = const Value.absent(),
            Value<int> score = const Value.absent(),
            Value<int> scoreUpdate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RoundScoresTableCompanion(
            roundId: roundId,
            playerName: playerName,
            score: score,
            scoreUpdate: scoreUpdate,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String roundId,
            required String playerName,
            required int score,
            required int scoreUpdate,
            Value<int> rowid = const Value.absent(),
          }) =>
              RoundScoresTableCompanion.insert(
            roundId: roundId,
            playerName: playerName,
            score: score,
            scoreUpdate: scoreUpdate,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RoundScoresTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({roundId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (roundId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.roundId,
                    referencedTable:
                        $$RoundScoresTableTableReferences._roundIdTable(db),
                    referencedColumn:
                        $$RoundScoresTableTableReferences._roundIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RoundScoresTableTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool roundId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GameSessionTableTableTableManager get gameSessionTable =>
      $$GameSessionTableTableTableManager(_db, _db.gameSessionTable);
  $$PlayersTableTableTableManager get playersTable =>
      $$PlayersTableTableTableManager(_db, _db.playersTable);
  $$PlayerScoresTableTableTableManager get playerScoresTable =>
      $$PlayerScoresTableTableTableManager(_db, _db.playerScoresTable);
  $$RoundsTableTableTableManager get roundsTable =>
      $$RoundsTableTableTableManager(_db, _db.roundsTable);
  $$RoundScoresTableTableTableManager get roundScoresTable =>
      $$RoundScoresTableTableTableManager(_db, _db.roundScoresTable);
}
