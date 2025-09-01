import 'package:cabo_counter/presentation/views/home/active_game/mode_selection_view.dart';
import 'package:cabo_counter/presentation/views/home/main_menu_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service class for managing and persisting app configuration settings using `SharedPreferences`.
///
/// Provides methods to initialize, retrieve, update, and reset configuration values such as point limit,
/// cabo penalty, and game mode. Ensures that user preferences are stored locally and persist across app restarts.
class ConfigService {
  // Keys for the stored values
  static const String _keyPointLimit = 'pointLimit';
  static const String _keyCaboPenalty = 'caboPenalty';
  static const String _keyGameMode = 'gameMode';
  static const String _keyMigrationDone = 'migrationDone';
  static const String _keySortingOption = 'sortingOption';
  static const String _keySortingDirection = 'sortingDirection';

  // Actual values used in the app

  static int _pointLimit = 100;
  static int _caboPenalty = 5;
  static int _gameMode = -1;
  static bool _migrationDone = false;

  /// Sorting option for player list.
  /// true = sort by date, false = sort by name
  static bool _sortingOption = true;

  /// Sorting direction for player list.
  /// true = descending, false = ascending
  static bool _sortingDirection = true;

  // Default values
  static const int _defaultPointLimit = 100;
  static const int _defaultCaboPenalty = 5;
  static const int _defaultGameMode = -1;
  static const bool _defaultMigrationDone = false;
  static const bool _defaultSortingOption = true;
  static const bool _defaultSortingDirection = true;

  static Future<void> initConfig() async {
    final prefs = await SharedPreferences.getInstance();

    // Initialize pointLimit, caboPenalty, and gameMode from SharedPreferences
    // If they are not set, use the default values
    _pointLimit = prefs.getInt(_keyPointLimit) ?? _defaultPointLimit;
    _caboPenalty = prefs.getInt(_keyCaboPenalty) ?? _defaultCaboPenalty;
    _gameMode = prefs.getInt(_keyGameMode) ?? _defaultGameMode;
    _migrationDone = prefs.getBool(_keyMigrationDone) ?? _defaultMigrationDone;
    _sortingOption = prefs.getBool(_keySortingOption) ?? _defaultSortingOption;
    _sortingDirection =
        prefs.getBool(_keySortingDirection) ?? _defaultSortingDirection;

    // Save the initial values to SharedPreferences
    prefs.setInt(_keyPointLimit, _pointLimit);
    prefs.setInt(_keyCaboPenalty, _caboPenalty);
    prefs.setInt(_keyGameMode, _gameMode);
    prefs.setBool(_keyMigrationDone, _migrationDone);
    prefs.setBool(_keySortingOption, _sortingOption);
    prefs.setBool(_keySortingDirection, _sortingDirection);
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

  /// Resets the configuration to default values.
  static Future<void> resetConfig() async {
    ConfigService._pointLimit = _defaultPointLimit;
    ConfigService._caboPenalty = _defaultCaboPenalty;
    ConfigService._gameMode = _defaultGameMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyPointLimit, _defaultPointLimit);
    await prefs.setInt(_keyCaboPenalty, _defaultCaboPenalty);
  }
}
