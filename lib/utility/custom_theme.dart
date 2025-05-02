import 'package:flutter/cupertino.dart';

class CustomTheme {
  static Color white = CupertinoColors.white;
  static Color primaryColor = CupertinoColors.systemGreen;
  static Color backgroundColor = const Color(0xFF101010);
  static Color backgroundTintColor = CupertinoColors.darkBackgroundGray;

  static TextStyle modeTitle = TextStyle(
    color: primaryColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle modeDescription = TextStyle(
    fontSize: 16,
  );

  static TextStyle createGameTitle = TextStyle(
    fontSize: 20,
    color: primaryColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle roundTitle = TextStyle(
    fontSize: 60,
    color: white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle roundPlayers = TextStyle(
    fontSize: 20,
    color: white,
    fontWeight: FontWeight.bold,
  );
}
