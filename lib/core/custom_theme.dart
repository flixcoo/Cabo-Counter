import 'package:flutter/cupertino.dart';

class CustomTheme {
  /// Main Theme of the App
  /// Primary white color mainly used for text
  static Color white = CupertinoColors.white;

  /// Red color, typically used for destructive actions or error states
  static Color red = CupertinoColors.destructiveRed;

  /// Primary color of the app, used for buttons, highlights, and interactive elements
  static Color primaryColor = CupertinoColors.systemGreen;

  /// Background color for the main app scaffold and views
  static Color backgroundColor = const Color(0xFF101010);

  /// Background color for main UI elements like cards or containers.
  static Color mainElementBackgroundColor = CupertinoColors.darkBackgroundGray;

  /// Background color for player tiles in lists.
  static Color playerTileColor = CupertinoColors.secondaryLabel;

  /// Background color for buttons and interactive controls.
  static Color buttonBackgroundColor = const Color(0xFF202020);

  /// Color used to highlight the kamikaze button and players
  static Color kamikazeColor = CupertinoColors.systemYellow;

  // Line Colors for GraphView
  static const Color graphColor1 = Color(0xFFF44336);
  static const Color graphColor2 = Color(0xFF2196F3);
  static const Color graphColor3 = Color(0xFFFFA726);
  static const Color graphColor4 = Color(0xFF9C27B0);
  static final Color graphColor5 = primaryColor;

  // Colors for PointsView
  /// Color used to indicate a loss of points in the UI.
  static Color pointLossColor = primaryColor;

  /// Color used to indicate a gain of points in the UI.
  static const Color pointGainColor = Color(0xFFF44336);

  // Text Styles
  /// Text style for mode titles, typically used in headers or section titles.
  static TextStyle modeTitle = TextStyle(
    color: primaryColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  /// Default text style for mode descriptions.
  static const TextStyle modeDescription = TextStyle(
    fontSize: 16,
  );

  /// Text style for titles of sections of [CupertinoListTile].
  static TextStyle rowTitle = TextStyle(
    fontSize: 20,
    color: primaryColor,
    fontWeight: FontWeight.bold,
  );

  /// Text style for round titles, used for prominent display of the round title
  static TextStyle roundTitle = TextStyle(
    fontSize: 60,
    color: white,
    fontWeight: FontWeight.bold,
  );
}
