import 'package:flutter/cupertino.dart';

abstract class Styles {
  static Color primaryColor = CupertinoColors.systemGreen;

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
}
