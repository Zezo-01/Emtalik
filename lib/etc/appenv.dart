import 'package:flutter/material.dart';

abstract class AppEnv {
  // This is not good colors and needs to be changed

  static const _defaultDarkTextColor = Color.fromARGB(255, 143, 98, 55);
  static const _defaultDarkMediumTextColor = Color.fromARGB(181, 160, 124, 91);
  static const _defaultDarkSmallTextColor = Color.fromARGB(255, 160, 134, 111);
  //*
  static const _defaultLightTextColor = Color.fromARGB(255, 143, 98, 55);
  static const _defaultLightMediumTextColor = Color.fromARGB(181, 160, 124, 91);
  static const _defaultLightSmallTextColor = Color.fromARGB(255, 160, 134, 111);
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
    secondary: Color.fromARGB(255, 108, 132, 143),
    onSecondary: Color.fromARGB(255, 1, 109, 4),
  );

  // DARK THEME COLOR SCHEME
  static const ColorScheme _defaultDarkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    // Text Fields and labels
    primary: Color.fromARGB(255, 53, 189, 26),
    onPrimary: Color.fromARGB(255, 143, 98, 55),
    background: Colors.blueGrey,
    //Apps Background
    onBackground: Colors.indigo,
    error: Color.fromARGB(255, 124, 8, 0),
    onError: Colors.redAccent,
    surface: Colors.white,
    // Borders style
    onSurface: Colors.grey,
    //CONTROLS SUCH AS FLOATING ACTION BUTTON
    secondary: Color.fromARGB(255, 23, 46, 56),
    onSecondary: Color.fromARGB(255, 1, 109, 4),
  );

  // LIGHT THEME DATA
  static get defaultLightTheme => ThemeData(
        colorScheme: _defaultLightColorScheme,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 236, 166, 61),
          foregroundColor: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 20,
            color: _defaultLightTextColor,
            fontWeight: FontWeight.w800,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            color: _defaultLightMediumTextColor,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            fontSize: 16,
            color: _defaultLightSmallTextColor,
            fontWeight: FontWeight.w300,
          ),
          displayLarge: TextStyle(
            fontSize: 100,
            color: _defaultLightTextColor,
            fontWeight: FontWeight.w800,
          ),
          displayMedium: TextStyle(
            fontSize: 75,
            color: _defaultLightMediumTextColor,
            fontWeight: FontWeight.w700,
          ),
          displaySmall: TextStyle(
            fontSize: 35,
            color: _defaultLightSmallTextColor,
            fontWeight: FontWeight.w700,
          ),
          headlineLarge: TextStyle(
            fontSize: 28,
            color: _defaultLightTextColor,
            fontWeight: FontWeight.w700,
            letterSpacing: -2.2,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            color: _defaultLightMediumTextColor,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.5,
          ),
          headlineSmall: TextStyle(
            fontSize: 20,
            color: _defaultLightSmallTextColor,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.5,
          ),
          labelLarge: TextStyle(
            fontSize: 20,
            color: _defaultLightTextColor,
            fontWeight: FontWeight.w300,
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            color: _defaultLightMediumTextColor,
            fontWeight: FontWeight.w300,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            color: _defaultLightSmallTextColor,
            fontWeight: FontWeight.w300,
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            color: _defaultLightTextColor,
            fontWeight: FontWeight.w300,
          ),
          titleMedium: TextStyle(
            fontSize: 10,
            color: _defaultLightMediumTextColor,
            fontWeight: FontWeight.w300,
          ),
          titleSmall: TextStyle(
            fontSize: 10,
            color: _defaultLightSmallTextColor,
            fontWeight: FontWeight.w300,
          ),
        ),
      );
  // DARK THEME DATA
  static get defaultDarkTheme => ThemeData(
        fontFamily: 'Changa',
        colorScheme: _defaultDarkColorScheme,
        scaffoldBackgroundColor: Colors.white10,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 236, 166, 61),
          foregroundColor: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 20,
            color: _defaultDarkTextColor,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            color: _defaultDarkMediumTextColor,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            fontSize: 16,
            color: _defaultDarkSmallTextColor,
            fontWeight: FontWeight.w300,
          ),
          displayLarge: TextStyle(
            fontSize: 100,
            color: _defaultDarkTextColor,
            fontWeight: FontWeight.w800,
          ),
          displayMedium: TextStyle(
            fontSize: 75,
            color: _defaultDarkMediumTextColor,
            fontWeight: FontWeight.w700,
          ),
          displaySmall: TextStyle(
            fontSize: 35,
            color: _defaultDarkSmallTextColor,
            fontWeight: FontWeight.w700,
          ),
          headlineLarge: TextStyle(
            fontSize: 28,
            color: _defaultDarkTextColor,
            fontWeight: FontWeight.w700,
            letterSpacing: -2.2,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            color: _defaultDarkMediumTextColor,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.5,
          ),
          headlineSmall: TextStyle(
            fontSize: 20,
            color: _defaultDarkSmallTextColor,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.5,
          ),
          labelLarge: TextStyle(
            fontSize: 20,
            color: _defaultDarkTextColor,
            fontWeight: FontWeight.w300,
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            color: _defaultDarkMediumTextColor,
            fontWeight: FontWeight.w300,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            color: _defaultDarkSmallTextColor,
            fontWeight: FontWeight.w300,
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            color: _defaultDarkTextColor,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: TextStyle(
            fontSize: 10,
            color: _defaultDarkMediumTextColor,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: TextStyle(
            fontSize: 10,
            color: _defaultDarkSmallTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
