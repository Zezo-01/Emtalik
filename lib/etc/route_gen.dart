// ignore_for_file: unused_local_variable, prefer_const_constructors, duplicate_ignore

import 'package:emtalik/pages/mainpage.dart';
import 'package:emtalik/pages/login.dart';
import 'package:emtalik/sandbox/sanboxtext.dart';
import 'package:emtalik/sandbox/sandbox.dart';
import 'package:emtalik/sandbox/sandboxui.dart';
import 'package:flutter/material.dart';
import '../pages/signup.dart';

class RouteGeneration {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/mainpage':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => Signup());
      case '/sandboxtext':
        return MaterialPageRoute(builder: (_) => SandBoxText());
      case '/sandbox':
        return MaterialPageRoute(builder: (_) => SandBox());
      case '/sandboxui':
        return MaterialPageRoute(builder: (_) => SandBoxUi());
    }
    return errorRoute();
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        // ignore: prefer_const_constructors
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
