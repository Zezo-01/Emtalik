import 'package:emtalik/pages/changepassword.dart';
import 'package:emtalik/pages/mainpage.dart';
import 'package:emtalik/pages/login.dart';
import 'package:emtalik/pages/terms.dart';
import 'package:flutter/material.dart';

import '../pages/settingsadmin.dart';
import '../pages/signup1.dart';
import '../pages/signup2.dart';
class RouteGeneration{
static Route<dynamic> generateRoute(RouteSettings settings){
  final args =settings.arguments;
  switch(settings.name){
    case '/' :
    return MaterialPageRoute(builder:(_)=> LoginPage());
    case '/mainpage' :
    return MaterialPageRoute(builder:(_)=> MyHomePage());
    case '/signup1' :
    return MaterialPageRoute(builder:(_)=> Signup());
    case '/signup2' :
    return MaterialPageRoute(builder:(_)=> Signup2());
    case '/settingsuser' :
    return MaterialPageRoute(builder:(_)=> SettigsAdmin());
     case '/terms' :
    return MaterialPageRoute(builder:(_)=> Terms());
    case '/changepassword' :
    return MaterialPageRoute(builder:(_)=> ChangePassword());
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

