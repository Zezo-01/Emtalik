import 'package:emtalik/Widgets/UserInfoWidgets/passwordfield.dart';
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
      theme: AppEnv.defaultLightTheme,
      darkTheme: AppEnv.defaultDarkTheme,
      home: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.fromLTRB(50, 50, 50, 0),
            child: PasswordField(
              info: 'password-constraints',
            ),
          ),
        ),
      ),
    );
  }
}
