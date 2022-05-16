import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChangePassword extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter New Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PasswordFormField(),
          Text("Enter Password Again"),
          PasswordFormField(),
   
        ],

      ),
      actions: [
        ElevatedButton(
          
          onPressed: (){Navigator.of(context).pushNamed('/mainpage');},
          child: Text("Save"),


        ),
        
        
      ],
    );

  }
  
}