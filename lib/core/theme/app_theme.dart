import 'package:flutter/material.dart';
import 'package:todo/core/theme/dark_theme_data.dart';
import 'package:todo/core/theme/light_theme_data.dart';

class AppTheme {
  //light theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: LightThemeData.lightColorScheme ,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: LightThemeData.appBarTheme,
    floatingActionButtonTheme: LightThemeData.floatingActionButtonTheme,
  );


  //dark theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: DarkThemeData.darkColorScheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: DarkThemeData.appBarTheme,
    floatingActionButtonTheme: DarkThemeData.floatingActionButtonTheme,
  );





}
