import 'package:emtalik/providers/locale_provider.dart';
import 'package:emtalik/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: Icon(Icons.person),
            accountName: Text("name"),
            accountEmail: Text("Email"),
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
          const SizedBox(height: 8),
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Icon(
              Provider.of<ThemeProvider>(context, listen: false).theme ==
                      ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: Provider.of<ThemeProvider>(context).theme == ThemeMode.dark
                  ? Colors.indigoAccent
                  : Colors.yellow[900],
            ),
          )
        ],
      ),
    );
  }
}
