import 'package:flutter/cupertino.dart';

abstract class Styles {
  static Color primaryColor = CupertinoColors.systemGreen;
  static Color backgroundColor = Color(0xFF080808);

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
    color: CupertinoColors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle roundPlayers = TextStyle(
    fontSize: 20,
    color: CupertinoColors.white,
    fontWeight: FontWeight.bold,
  );
}
