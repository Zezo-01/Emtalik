import 'package:emtalik/etc/appenv.dart';
import 'package:emtalik/etc/localemanager.dart';
import 'package:emtalik/sandbox.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'login.dart';
import 'settings.dart';
import 'signup.dart';
import 'settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: LocaleManager.supportedLocales,
      localizationsDelegates: LocaleManager.localeDelegates,
      onGenerateTitle: (context) => 'app-name'.i18n(),
      theme: AppEnv.defaultLightTheme,
      darkTheme: AppEnv.defaultDarkTheme,
      home: SandBox(),
    );
  }
}
