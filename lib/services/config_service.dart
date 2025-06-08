import 'package:cabo_counter/utility/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class handles the configuration settings for the app.
/// It uses SharedPreferences to store and retrieve the personal configuration of the app.
/// Currently it provides methods to initialize, get, and set the point limit and cabo penalty.
class ConfigService {
  static const String _keyPointLimit = 'pointLimit';
  static const String _keyCaboPenalty = 'caboPenalty';
  static const int _defaultPointLimit = 100; // Default Value
  static const int _defaultCaboPenalty = 5; // Default Value

  static Future<void> initConfig() async {
    final prefs = await SharedPreferences.getInstance();

    // Default values only set if they are not already set
    prefs.setInt(
        _keyPointLimit, prefs.getInt(_keyPointLimit) ?? _defaultPointLimit);
    prefs.setInt(
        _keyCaboPenalty, prefs.getInt(_keyCaboPenalty) ?? _defaultCaboPenalty);
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
  }

  /// Resets the configuration to default values.
  static Future<void> resetConfig() async {
    globals.pointLimit = _defaultPointLimit;
    globals.caboPenalty = _defaultCaboPenalty;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyPointLimit, _defaultPointLimit);
    await prefs.setInt(_keyCaboPenalty, _defaultCaboPenalty);
  }
}
