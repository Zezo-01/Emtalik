import 'package:emtalik/etc/appenv.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

void main() {
  runApp(const MyApp());
}
aaa
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: AppEnv.supportedLocales,
      localizationsDelegates: AppEnv.localeDelegates,
      title: 'app-name'.i18n(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
        title: Text('app-bar-title-main'.i18n()),
      )),
    );
  }
}
