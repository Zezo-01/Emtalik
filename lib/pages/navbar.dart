import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/providers/locale_provider.dart';
import 'package:emtalik/providers/theme_provider.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
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
            currentAccountPicture: Image.network(
              HttpService.getProfilePictureRoute(
                  Provider.of<UserSession>(context, listen: false).id ?? 0),
            ),
            accountName: Text(
                Provider.of<UserSession>(context, listen: false).username ??
                    ""),
            accountEmail: const Text("Email"),
          ),
          const ListTile(),
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
