import 'package:flutter/material.dart';

class LightThemeData {
  //app bar
  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
  );

  //floating action button
  static FloatingActionButtonThemeData floatingActionButtonTheme =
      FloatingActionButtonThemeData(
        backgroundColor: lightColorScheme.secondary,
        foregroundColor: lightColorScheme.onSecondary,
      );

  //light color schema
  static final ColorScheme lightColorScheme = ColorScheme.light(
    primary: Color(0xFF43A047), // Rich green
    secondary: Color(0xFFD4E157), // Lime
    surface: Color(0xFFF1F8E9), // Soft green/gray
    error: Color(0xFFB00020), // Red
    onPrimary: Colors.white,
    tertiary: Colors.grey.shade200,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onError: Colors.white,
  );
}
