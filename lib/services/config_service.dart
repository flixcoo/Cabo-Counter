import 'package:shared_preferences/shared_preferences.dart';

/// This class handles the configuration settings for the app.
/// It uses SharedPreferences to store and retrieve the personal configuration of the app.
/// Currently it provides methods to initialize, get, and set the point limit and cabo penalty.
class ConfigService {
  static const String _keyPointLimit = 'pointLimit';
  static const String _keyCaboPenalty = 'caboPenalty';
  static const String _keyGameMode = 'gameMode';
  // Actual values used in the app
  static int pointLimit = 100;
  static int caboPenalty = 5;
  static int gameMode = -1;
  // Default values
  static const int _defaultPointLimit = 100;
  static const int _defaultCaboPenalty = 5;
  static const int _defaultGameMode = -1;

  static Future<void> initConfig() async {
    final prefs = await SharedPreferences.getInstance();

    // Initialize pointLimit, caboPenalty, and gameMode from SharedPreferences
    // If they are not set, use the default values
    pointLimit = prefs.getInt(_keyPointLimit) ?? _defaultPointLimit;
    caboPenalty = prefs.getInt(_keyCaboPenalty) ?? _defaultCaboPenalty;
    gameMode = prefs.getInt(_keyGameMode) ?? _defaultGameMode;

    // Save the initial values to SharedPreferences
    prefs.setInt(_keyPointLimit, pointLimit);
    prefs.setInt(_keyCaboPenalty, caboPenalty);
    prefs.setInt(_keyGameMode, gameMode);
  }

  static Future<void> setGameMode(int newGameMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyGameMode, newGameMode);
    gameMode = newGameMode;
  }

  /// Getter for the point limit.
  static Future<int> getPointLimit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyPointLimit) ?? _defaultPointLimit;
  }

  /// Setter for the point limit.
  /// [newPointLimit] is the new point limit to be set.
  static Future<void> setPointLimit(int newPointLimit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyPointLimit, newPointLimit);
    pointLimit = newPointLimit;
  }

  /// Getter for the cabo penalty.
  static Future<int> getCaboPenalty() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyCaboPenalty) ?? _defaultCaboPenalty;
  }

  /// Setter for the cabo penalty.
  /// [newCaboPenalty] is the new cabo penalty to be set.
  static Future<void> setCaboPenalty(int newCaboPenalty) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCaboPenalty, newCaboPenalty);
    caboPenalty = newCaboPenalty;
  }

  /// Resets the configuration to default values.
  static Future<void> resetConfig() async {
    ConfigService.pointLimit = _defaultPointLimit;
    ConfigService.caboPenalty = _defaultCaboPenalty;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyPointLimit, _defaultPointLimit);
    await prefs.setInt(_keyCaboPenalty, _defaultCaboPenalty);
  }
}
