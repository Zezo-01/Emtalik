import 'package:flutter/material.dart';

abstract class AppEnv {
  // This is not good colors and needs to be changed

  static const _defaultDarkTextColor = Color.fromARGB(255, 212, 175, 55);
  static const _defaultDarkMediumTextColor = Color.fromARGB(181, 221, 208, 195);
  static const _defaultDarkSmallTextColor = Colors.white;
  static const _defaultDarklabelMediumTextColor = Colors.white;
  //*
  static const _defaultLightTextColor = Colors.black;
  static const _defaultLightMediumTextColor = Colors.black;
  static const _defaultLightSmallTextColor = Colors.black;
  static const _defaultLightlabelMediumTextColor = Colors.black;
  // LIGHT THEME COLOR SCHEME
  static const ColorScheme _defaultLightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.blueAccent,
    onPrimary: Color.fromARGB(183, 248, 208, 140),
    background: Color.fromARGB(255, 150, 111, 51),
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
    primary: Color.fromARGB(255, 212, 175, 55),
    onPrimary: Color.fromARGB(255, 212, 175, 55),
    background: Colors.black12,
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
  static ThemeData defaultLightTheme(BuildContext context) => ThemeData(
        colorScheme: _defaultLightColorScheme,
        fontFamily: 'Changa',
        scaffoldBackgroundColor: Color.fromARGB(239, 253, 233, 199),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            alignment: Alignment.center,
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                  fontFamily: 'Changa'),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Changa'),
            ),
            side: MaterialStateProperty.all(
              const BorderSide(
                color: Color.fromARGB(225, 108, 132, 143),
                width: 2.5,
              ),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsetsDirectional.all(8),
            ),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Changa'),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey[700],
          selectedItemColor: _defaultLightColorScheme.primary,
          selectedIconTheme: const IconThemeData(size: 35),
          backgroundColor: Colors.transparent,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
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
            color: _defaultLightlabelMediumTextColor,
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
  static ThemeData defaultDarkTheme(BuildContext context) => ThemeData(
        fontFamily: 'Changa',
        colorScheme: _defaultDarkColorScheme,
        scaffoldBackgroundColor: Colors.white10,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white60,
          elevation: 0,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white70),
              splashFactory: NoSplash.splashFactory,
              alignment: Alignment.center,
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                  fontFamily: 'Changa',
                ),
              )),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white70),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Changa'),
            ),
            side: MaterialStateProperty.all(
              const BorderSide(
                color: Colors.grey,
                width: 2.5,
              ),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsetsDirectional.all(8),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.white70),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                  fontFamily: 'Changa'),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey[700],
          selectedItemColor: _defaultDarkColorScheme.primary,
          selectedIconTheme: const IconThemeData(size: 35),
          backgroundColor: Colors.transparent,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
          foregroundColor: Colors.grey,
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
            color: _defaultDarklabelMediumTextColor,
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
