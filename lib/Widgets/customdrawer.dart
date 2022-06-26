import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/pages/login.dart';
import 'package:emtalik/pages/unreviewed_estates.dart';
import 'package:emtalik/providers/locale_provider.dart';
import 'package:emtalik/providers/theme_provider.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Provider.of<UserSession>(context, listen: false).picture
                    ? Image.network(
                        HttpService.getProfilePictureRoute(
                          Provider.of<UserSession>(context, listen: false).id ??
                              0,
                        ),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                      )
                    : Image.asset(
                        "assets/user/default_pfp.png",
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                      ),
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.only(left: 25, right: 25),
                    ),
                  ),
                  onPressed: () {
                    ToastFactory.makeToast(
                        context,
                        TOAST_TYPE.info,
                        "Work required",
                        "Implement user view profile and settings",
                        false,
                        () {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.settings),
                      Text(
                        decodeUtf8ToString(
                            Provider.of<UserSession>(context, listen: false)
                                    .username ??
                                "Username"),
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.only(left: 25, right: 25),
                    ),
                  ),
                  onPressed: () {
                    Provider.of<LocaleProvider>(context, listen: false)
                        .toggleLanguage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.language),
                      Text(
                        Provider.of<LocaleProvider>(context).locale ==
                                const Locale('ar')
                            ? 'English'
                            : 'العربية',
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.only(left: 25, right: 25),
                    ),
                  ),
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Provider.of<ThemeProvider>(context, listen: true)
                                    .theme ==
                                ThemeMode.dark
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        color: Provider.of<ThemeProvider>(context).theme ==
                                ThemeMode.dark
                            ? Colors.indigoAccent
                            : Colors.yellow[900],
                      ),
                      Text(
                        Provider.of<ThemeProvider>(context).theme ==
                                ThemeMode.dark
                            ? 'light-theme'.i18n()
                            : 'dark-theme'.i18n(),
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),
                if (Provider.of<UserSession>(context).role == "admin")
                  //  ADMIN WORK HERE MUST SET IT TO == "admin"
                  Column(
                    children: [
                      Divider(
                        endIndent: 25,
                        thickness: 3,
                        indent: 25,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.only(left: 25, right: 25),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => UnReviewedEstates())));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.approval_rounded),
                            Text(
                              "unreviewed-states".i18n(),
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    bottom: 10,
                  ),
                ),
              ),
              onPressed: () {
                Provider.of<UserSession>(context, listen: false).logout();
                Navigator.of(context).popUntil(
                  (route) => false,
                );
                Navigator.of(context).pushNamed("/");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.login_outlined),
                  Text(
                    "logout".i18n(),
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
