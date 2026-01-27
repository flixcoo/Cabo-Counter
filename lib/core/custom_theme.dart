import 'package:flutter/cupertino.dart';

class CustomTheme {
  /// Main Theme of the App
  /// Primary white color mainly used for text
  static const Color white = Color(0xFFFFFFFF);

  /// Red color, typically used for destructive actions or error states
  static const Color red = Color(0xFFDD0000);

  /// Primary color of the app, used for buttons, highlights, and interactive elements
  static const Color primaryColor = Color(0xFF34C759);

  /// Background color for the main app scaffold and views
  static const Color backgroundColor = Color(0xFF101010);

  /// Background color for the navigation bar at the bottom of the app.
  static const Color navBarBackgroundColor = Color(0xFF161616);

  /// Background color for main UI elements like cards or containers.
  static const Color mainElementBackgroundColor = Color(0xFF171717);

  /// Background color for settings tiles and list items.
  static const Color settingsTilecolor = Color(0xFF1C1C1E);

  /// Background color for player tiles in lists.
  static const Color playerTileColor = Color(0xFF2A2A2A);

  /// Background color for buttons and interactive controls.
  static const Color buttonBackgroundColor = Color(0xFF202020);

  /// Color used to highlight the kamikaze button and players
  static Color kamikazeColor = CupertinoColors.systemYellow;

  // Line Colors for GraphView
  static const Color graphColor1 = Color(0xFFF44336);
  static const Color graphColor2 = Color(0xFF2196F3);
  static const Color graphColor3 = Color(0xFFFFA726);
  static const Color graphColor4 = Color(0xFF9C27B0);
  static const Color graphColor5 = primaryColor;

  // Colors for PointsView
  /// Color used to indicate a loss of points in the UI.
  static Color pointLossColor = primaryColor;

  /// Color used to indicate a gain of points in the UI.
  static const Color pointGainColor = Color(0xFFF44336);

  // Text Styles
  /// Text style for mode titles, typically used in headers or section titles.
  static const TextStyle modeTitle = TextStyle(
    color: primaryColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  /// Default text style for mode descriptions.
  static const TextStyle modeDescription = TextStyle(fontSize: 16);

  /// Text style for titles of sections of [CupertinoListTile].
  static const TextStyle rowTitle = TextStyle(
    fontSize: 20,
    color: primaryColor,
    fontWeight: FontWeight.bold,
  );

  /// Text style for round titles, used for prominent display of the round title
  static const TextStyle roundTitle = TextStyle(
    fontSize: 60,
    color: white,
    fontWeight: FontWeight.bold,
  );
}
