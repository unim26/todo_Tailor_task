import 'package:flutter/material.dart';

class DarkThemeData {
  //app bar
  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: darkColorScheme.primary,
    foregroundColor: darkColorScheme.onPrimary,
  );

  //floating action button
  static FloatingActionButtonThemeData floatingActionButtonTheme =
      FloatingActionButtonThemeData(
        backgroundColor: darkColorScheme.secondary,
        foregroundColor: darkColorScheme.onSecondary,
      );

      //dark color schema
static final ColorScheme darkColorScheme = ColorScheme.dark(
  primary: Color(0xFF43A047),      // Rich green
  secondary: Color(0xFFD4E157),    // Lime
  surface: Color(0xFF2E7D32),      // Stronger dark green
  error: Color(0xFFB00020),        // Red
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.white,
  onError: Colors.white,
);
}
