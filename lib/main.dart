import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/etc/appenv.dart';
import 'package:emtalik/etc/localemanager.dart';
import 'package:emtalik/pages/login.dart';
import 'package:emtalik/sandbox/sanboxtext.dart';
import 'package:emtalik/sandbox/sandbox.dart';
import 'package:emtalik/sandbox/sandboxui.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'settings.dart';
import 'signup.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<StatefulWidget> {
  final ted = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: LocaleManager.supportedLocales,
      localizationsDelegates: LocaleManager.localeDelegates,
      onGenerateTitle: (context) => 'app-name'.i18n(),
      theme: AppEnv.defaultLightTheme(context),
      darkTheme: AppEnv.defaultDarkTheme(context),
      home: const LoginPage(),
    );
  }
}
