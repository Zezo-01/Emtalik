import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

abstract class LocaleManager {
  static const List<Locale> supportedLocales = [
    Locale('ar'),
    Locale('en'),
  ];

  static List<LocalizationsDelegate> localeDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    LocalJsonLocalization.delegate
  ];
}
