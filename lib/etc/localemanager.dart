import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:localization/src/localization_service.dart';

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

  static void selectEnglish() {
    LocalizationService localeService = LocalizationService.instance;
    localeService.changeLanguage(const Locale('en'), ['lib/i18n']);
  }

  static void selectArabic() {
    LocalizationService localeService = LocalizationService.instance;
    localeService.changeLanguage(const Locale('ar'), ['lib/i18n']);
  }
}
