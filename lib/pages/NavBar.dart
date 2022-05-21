// ignore_for_file: unnecessary_import, prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            title: Text('Change Password'),
            onTap: () {
              Navigator.of(context).pushNamed('/changepassword');
            },
          ),
          ListTile(
            leading: Icon(Icons.add_link),
            title: Text('Terms And Conditions'),
            onTap: () {
              Navigator.of(context).pushNamed('/terms');
            },
          ),
          ListTile(
            leading: Icon(Icons.support),
            title: Text('Support'),
            onTap: () {
              Navigator.of(context).pushNamed('/support');
            },
          ),
        ],
      ),
    );
  }
}
