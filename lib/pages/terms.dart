// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("terms-and-conditions".i18n()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("1-agreement-to-terms.".i18n()),
          Text("2-user-representation.".i18n()),
          Text("3-submissions.".i18n()),
          Text("4-goverinig-law.".i18n()),
          Text("5-user-data.".i18n()),
          Text("6-site-management".i18n()),
          Text("7-copy-right.".i18n()),
          Text("8-prohbited-activites.".i18n()),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/mainpage');
            },
            child: Text("close".i18n()))
      ],
    );
  }
}
