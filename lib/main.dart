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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "app-name".i18n(),
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}
