// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Terms And Conditions'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("1-Agreement to terms."),
          Text("2-User Representation."),
          Text("3-Submissions."),
          Text("4-Goverinig Law."),
          Text("5-User Data."),
          Text("6-Site Management. "),
          Text("7-Copy Right . "),
          Text("8-Prohbited Activites. "),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/mainpage');
            },
            child: Text("Close"))
      ],
    );
  }
}
