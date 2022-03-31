import 'package:emtalik/login.dart';
import 'package:flutter/material.dart';
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
      title: 'Emtalik',
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}
