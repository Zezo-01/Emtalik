import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Terms extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Terms And Conditions'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("1-"),
          Text("1-"),
          Text("1-"),
          Text("1-"),
          Text("1-"),
          Text("We Wish "),
        ],

      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pushNamed('/settingsuser');
        }, 
        
        child: Text("Close")
        )
      ],
    );

  }
  
}