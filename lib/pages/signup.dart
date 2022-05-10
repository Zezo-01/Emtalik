import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Signup extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: <Widget>[  
      Text("Sign Up"),

      TextFormField(

decoration: InputDecoration(labelText: 'First Name'),
      ),





        ],
      ),
      ),
    );

  }
}

class Body extends StatelessWidget{
  final Widget child;

  const Body({
    Key ? key,
    required this.child,
     }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(

height: size.height,
width: double.infinity,
child: Stack(
  alignment: Alignment.center,
  children: <Widget>[


child,

  ],
  
),

    );

  }


  
}