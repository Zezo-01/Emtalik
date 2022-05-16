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
          Text("054-4883698"),
          Text("23123123"),
          Text("Fax"),
          Text("2342342"),
          Text("Email "),
          Text("ssadasdasd "),
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