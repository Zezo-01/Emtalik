// ignore_for_file: unnecessary_import, prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Name From DataBase'),
            accountEmail: Text('Email From Database'),
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text("change-password".i18n()),
            onTap: () {
              Navigator.of(context).pushNamed('/changepassword');
            },
          ),
          
        ],
      ),
    );
  }
}
