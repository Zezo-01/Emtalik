// ignore_for_file: unnecessary_import, prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:emtalik/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  final name = '';
  final email = '';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: Icon(Icons.person),
            accountName: Text(name),
            accountEmail: Text(email),
          ),
          ListTile(),
          ElevatedButton(
            onPressed: () {
              Provider.of<LocaleProvider>(context, listen: false)
                  .toggleLanguage();
            },
            child: Text(Provider.of<LocaleProvider>(context).locale ==
                    const Locale('ar')
                ? 'English'
                : 'العربية'),
          ),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Dark Theme"),
          )
        ],
      ),
    );
  }
}
