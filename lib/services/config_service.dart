import 'package:cabo_counter/presentation/views/home/active_game/mode_selection_view.dart';
import 'package:cabo_counter/presentation/views/home/main_menu_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service class for managing and persisting app configuration settings using `SharedPreferences`.
///
/// Provides methods to initialize, retrieve, update, and reset configuration values such as point limit,
/// cabo penalty, and game mode. Ensures that user preferences are stored locally and persist across app restarts.
class ConfigService {
  /// Current point limit for every game.
  static int _pointLimit = 100;

  /// Default value of [_pointLimit]
  static const int _defaultPointLimit = 100;

  /// Key for the stored point limit value.
  static const String _keyPointLimit = 'pointLimit';

  /// Current cabo penalty for every game.
  static int _caboPenalty = 5;

  /// Key for the stored cabo penalty value.
  static const String _keyCaboPenalty = 'caboPenalty';

  /// Default value of [_caboPenalty]
  static const int _defaultCaboPenalty = 5;

  /// Current game mode for every game.<br>
  /// [-1] = no mode <br>
  /// [0] = point limit <br>
  /// [1] = unlimited
  static int _gameMode = -1;

  /// Default value of [_gameMode]
  static const _defaultGameMode = -1;

  /// Key for the stored game mode value.
  static const String _keyGameMode = 'gameMode';

  /// Migration done flag.
  /// false = migration not done, true = migration done
  static bool _migrationDone = false;

  /// Default value of [_migrationDone]
  static const bool _defaultMigrationDone = false;

  /// Key for the stored migration done flag.
  static const String _keyMigrationDone = 'migrationDone';

  /// Sorting option for the game list in the main menu.
  /// true = sort by date, false = sort by title
  static bool _sortingOption = true;

  /// Default value of [_sortingOption]
  static const bool _defaultSortingOption = true;

  /// Key for the stored sorting option.
  static const String _keySortingOption = 'sortingOption';

  /// Sorting direction for the game list in the main menu.
  /// true = descending, false = ascending
  static bool _sortingDirection = true;

  /// Default value of [_sortingDirection]
  static const bool _defaultSortingDirection = true;

  /// Key for the stored sorting direction.
  static const String _keySortingDirection = 'sortingDirection';

  /// Show active games only flag.
  /// false = show all games, true = show only active games
  static bool _showActiveGamesOnly = false;

  /// Default value of [_showActiveGamesOnly]
  static const bool _defaultShowActiveGamesOnly = false;

  /// Key for the stored show active games only flag.
  static const String _keyShowActiveGamesOnly = 'showActiveGamesOnly';

  static Future<void> initConfig() async {
    final prefs = await SharedPreferences.getInstance();

    // Initialize all config values from SharedPreferences
    // If they are already set, use the stored values
    // If not, use the default values
    _pointLimit = prefs.getInt(_keyPointLimit) ?? _defaultPointLimit;
    _caboPenalty = prefs.getInt(_keyCaboPenalty) ?? _defaultCaboPenalty;
    _gameMode = prefs.getInt(_keyGameMode) ?? _defaultGameMode;
    _migrationDone = prefs.getBool(_keyMigrationDone) ?? _defaultMigrationDone;
    _sortingOption = prefs.getBool(_keySortingOption) ?? _defaultSortingOption;
    _sortingDirection =
        prefs.getBool(_keySortingDirection) ?? _defaultSortingDirection;
    _showActiveGamesOnly =
        prefs.getBool(_keyShowActiveGamesOnly) ?? _defaultShowActiveGamesOnly;

    // Save the initial values to SharedPreferences
    prefs.setInt(_keyPointLimit, _pointLimit);
    prefs.setInt(_keyCaboPenalty, _caboPenalty);
    prefs.setInt(_keyGameMode, _gameMode);
    prefs.setBool(_keyMigrationDone, _migrationDone);
    prefs.setBool(_keySortingOption, _sortingOption);
    prefs.setBool(_keySortingDirection, _sortingDirection);
    prefs.setBool(_keyShowActiveGamesOnly, _showActiveGamesOnly);
  }

  /// Retrieves the current game mode.
  ///
  /// The game mode is determined based on the stored integer value:
  /// - `0`: [GameMode.pointLimit]
  /// - `1`: [GameMode.unlimited]
  /// - Any other value: [GameMode.none] (-1 is used as a default for no mode)
  ///
  /// Returns the corresponding [GameMode] enum value.
  static GameMode getGameMode() {
    switch (_gameMode) {
      case 0:
        return GameMode.pointLimit;
      case 1:
        return GameMode.unlimited;
      default:
        return GameMode.none;
    }
  }

  /// Sets the game mode for the application.
  ///
  /// [newGameMode] is the new game mode to be set. It can be one of the following:
  /// - `GameMode.pointLimit`: The game ends when a pleayer reaches the point limit.
  /// - `GameMode.unlimited`: Every game goes for infinity until you end it.
  /// - `GameMode.none`: No default mode set.
  ///
  /// This method updates the `_gameMode` field and persists the value in `SharedPreferences`.
  static Future<void> setGameMode(GameMode newGameMode) async {
    int gameMode;
    switch (newGameMode) {
      case GameMode.pointLimit:
        gameMode = 0;
        break;
      case GameMode.unlimited:
        gameMode = 1;
        break;
      default:
        gameMode = -1;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyGameMode, gameMode);
    _gameMode = gameMode;
  }

  static int getPointLimit() => _pointLimit;

  /// Setter for the point limit.
  /// [newPointLimit] is the new point limit to be set.
  static Future<void> setPointLimit(int newPointLimit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyPointLimit, newPointLimit);
    _pointLimit = newPointLimit;
  }

  static int getCaboPenalty() => _caboPenalty;

  /// Setter for the cabo penalty.
  /// [newCaboPenalty] is the new cabo penalty to be set.
  static Future<void> setCaboPenalty(int newCaboPenalty) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCaboPenalty, newCaboPenalty);
    _caboPenalty = newCaboPenalty;
  }

  static bool isMigrationDone() => _migrationDone;

  /// Setter for the migration done flag.
  /// [done] is the new value to be set.
  static Future<void> setMigrationDone(bool done) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyMigrationDone, done);
    _migrationDone = done;
  }

  /// Getter for the sorting option.
  static SortOption getSortingOption() {
    return _sortingOption == true ? SortOption.date : SortOption.title;
  }

  /// Setter for the sorting option.
  /// [option] is the new value to be set.
  static Future<void> setSortingOption(SortOption sortOption) async {
    final prefs = await SharedPreferences.getInstance();
    final option = sortOption == SortOption.date;
    await prefs.setBool(_keySortingOption, option);
    _sortingOption = option;
  }

  /// Getter for the sorting direction.
  static SortDirection getSortingDirection() {
    return _sortingDirection == true
        ? SortDirection.descending
        : SortDirection.ascending;
  }

  /// Setter for the sorting direction.
  /// [direction] is the new value to be set.
  static Future<void> setSortingDirection(SortDirection sortDirection) async {
    final prefs = await SharedPreferences.getInstance();
    final direction = sortDirection == SortDirection.descending;
    await prefs.setBool(_keySortingDirection, direction);
    _sortingDirection = direction;
  }

  static bool getShowActiveGamesOnly() => _showActiveGamesOnly;

  /// Setter for the show active games only flag.
  /// [showActiveGamesOnly] is the new value to be set.
  static Future<void> setShowActiveGamesOnly(bool showActiveGamesOnly) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyShowActiveGamesOnly, showActiveGamesOnly);
    _showActiveGamesOnly = showActiveGamesOnly;
  }

  /// Resets the user configuration to default values.
  static Future<void> resetUserConfig() async {
    ConfigService._pointLimit = _defaultPointLimit;
    ConfigService._caboPenalty = _defaultCaboPenalty;
    ConfigService._gameMode = _defaultGameMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyPointLimit, _defaultPointLimit);
    await prefs.setInt(_keyCaboPenalty, _defaultCaboPenalty);
  }
}
