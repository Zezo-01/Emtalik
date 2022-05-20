// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_final_fields, must_be_immutable

import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  final TextEditingController _firstPassId = TextEditingController();
  final TextEditingController _secondPassId = TextEditingController();
  FocusNode _firstPassNode = FocusNode();
  FocusNode _secondPassNode = FocusNode();
  FocusNode _buttonNode = FocusNode();
  void dispose() {
    _firstPassNode.dispose();
    _secondPassNode.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text('Enter New Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PasswordFormField(
            onComplete: () {
              FocusScope.of(context).requestFocus(_secondPassNode);
            },
            focusNode: _firstPassNode,
            controller: _firstPassId,
          ),
          SizedBox(
                height: height * 0.05,
              ),
          PasswordFormField(
            onComplete: () {
              FocusScope.of(context).requestFocus(_buttonNode);
            },
            focusNode: _secondPassNode,
            controller: _secondPassId,
          )
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/mainpage');
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}
