import 'package:emtalik/pages/mainpage.dart';
import 'package:emtalik/pages/login.dart';
import 'package:emtalik/pages/signup.dart';
import 'package:flutter/material.dart';
class RouteGeneration{
static Route<dynamic> generateRoute(RouteSettings settings){
  final args =settings.arguments;
  switch(settings.name){
    case '/' :
    return MaterialPageRoute(builder:(_)=> LoginPage());
    case '/mainpage' :
    return MaterialPageRoute(builder:(_)=> MyHomePage());
    case '/signup' :
    return MaterialPageRoute(builder:(_)=> Signup());
  }
  return errorRoute();
}

static Route<dynamic> errorRoute()
{
  return MaterialPageRoute(builder: (_){
    return Scaffold(
      appBar:AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text('ERROR'),
      ),
    );
  }
  );
}
}

