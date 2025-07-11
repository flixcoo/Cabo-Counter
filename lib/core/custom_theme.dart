import 'package:flutter/cupertino.dart';

class CustomTheme {
  static Color white = CupertinoColors.white;
  static Color primaryColor = CupertinoColors.systemGreen;
  static Color backgroundColor = const Color(0xFF101010);
  static Color backgroundTintColor = CupertinoColors.darkBackgroundGray;

  // graph colors
  static const Color graphColor1 = Color(0xFFF44336);
  static const Color graphColor2 = Color(0xFF2196F3); //FF2196F3
  static const Color graphColor3 = Color(0xFFFFA726); //FFFFA726
  static const Color graphColor4 = Color(0xFF9C27B0); //9C27B0
  static final Color graphColor5 = primaryColor;

  static TextStyle modeTitle = TextStyle(
    color: primaryColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle modeDescription = TextStyle(
    fontSize: 16,
  );

  static TextStyle rowTitle = TextStyle(
    fontSize: 20,
    color: primaryColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle roundTitle = TextStyle(
    fontSize: 60,
    color: white,
    fontWeight: FontWeight.bold,
  );
}
