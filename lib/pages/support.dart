import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Support extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Support'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Call Us"),
          Text("+972 54-4883698"),
          Text("+972 59-706-0876"),
          Text("+972 56-911-9769"),
          Text("Email"),
          Text("j.demogharbe@gmail.com"),
          Text("anasmanasrah@gmail.com "),
          Text("fadishalash@gmail.com "),
        ],

      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pushNamed('/mainpage');
        }, 
        
        child: Text("Close")
        )
      ],
    );

  }
  
}