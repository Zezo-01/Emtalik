// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:emtalik/Widgets/route_gen.dart';
import 'package:emtalik/etc/appenv.dart';
import 'package:emtalik/etc/localemanager.dart';
import 'package:emtalik/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LocaleProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Provider.of<LocaleProvider>(context).locale,
      supportedLocales: LocaleManager.supportedLocales,
      localizationsDelegates: LocaleManager.localeDelegates,
      onGenerateTitle: (context) => 'app-name'.i18n(),
      theme: AppEnv.defaultLightTheme(context),
      darkTheme: AppEnv.defaultDarkTheme(context),
      initialRoute: '/',
      onGenerateRoute: RouteGeneration.generateRoute,
    );
  }
}
