import 'dart:developer';
import 'dart:js';

import 'package:flutter/material.dart';
import 'login.dart';
import 'settings.dart';
import 'signup.dart';
import 'settings.dart';
class MyHomePage extends StatefulWidget {
   MyHomePage({ Key? key }) : super(key: key);

   _MyHomePage createState()=> _MyHomePage();

  
}






class _MyHomePage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(),
    );  }
}