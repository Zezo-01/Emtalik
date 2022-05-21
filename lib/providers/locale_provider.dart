import 'dart:io';
import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = Locale(Platform.localeName.split('_')[0]);

  Locale? get locale => _locale;

  void toggleLanguage() {
    if (_locale == const Locale('ar')) {
      _locale = const Locale('en');
    } else {
      _locale = const Locale('ar');
    }
    notifyListeners();
  }
}
