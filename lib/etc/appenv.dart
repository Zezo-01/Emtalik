import 'package:flutter/material.dart';

abstract class AppEnv {
  // This is not good colors and needs to be changed

  // LIGHT THEME COLOR SCHEME
  static const ColorScheme _defaultLightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.blueAccent,
    onPrimary: Colors.black26,
    background: Colors.blueGrey,
    onBackground: Colors.indigo,
    error: Color.fromARGB(255, 124, 8, 0),
    onError: Colors.redAccent,
    surface: Colors.white,
    onSurface: Colors.grey,
    secondary: Colors.green,
    onSecondary: Color.fromARGB(255, 1, 109, 4),
  );

  // DARK THEME COLOR SCHEME
  static const ColorScheme _defaultDarkColorScheme = ColorScheme(
    brightness: Brightness.light,
    // Text Fields and labels
    primary: Color.fromARGB(255, 53, 189, 26),
    onPrimary: Colors.black26,
    background: Colors.blueGrey,
    //Apps Background
    onBackground: Colors.indigo,
    error: Color.fromARGB(255, 124, 8, 0),
    onError: Colors.redAccent,
    surface: Colors.white,
    // Borders style
    onSurface: Colors.grey,
    //CONTROLS SUCH AS FLOATING ACTION BUTTON
    secondary: Colors.green,
    onSecondary: Color.fromARGB(255, 1, 109, 4),
  );

  // LIGHT THEME DATA
  static get defaultLightTheme => ThemeData(
        colorScheme: _defaultLightColorScheme,
        scaffoldBackgroundColor: const Color.fromARGB(255, 127, 93, 182),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 236, 166, 61),
          foregroundColor: Colors.black,
        ),
      );
  // DARK THEME DATA
  static get defaultDarkTheme => ThemeData(
        colorScheme: _defaultDarkColorScheme,
        scaffoldBackgroundColor: const Color.fromARGB(255, 127, 93, 182),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 236, 166, 61),
          foregroundColor: Colors.black,
        ),
      );
}
