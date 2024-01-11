import 'package:chitter/themes/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final customTextTheme = TextTheme(
    bodyMedium: TextStyle(
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      fontSize: 24,
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Prompt',
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: accent,
    colorScheme: const ColorScheme.light(primary: primary),
    iconTheme: const IconThemeData(color: primaryText),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: icons,
        fontFamily: 'Prompt',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      backgroundColor: Colors.white,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Prompt',
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: accent,
    colorScheme: const ColorScheme.dark(primary: icons),
    iconTheme: const IconThemeData(color: icons),
    scaffoldBackgroundColor: primaryText,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: icons,
        fontFamily: 'Prompt',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      backgroundColor: primaryText,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    ),
  );
}
