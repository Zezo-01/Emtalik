// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, annotate_overrides, prefer_const_constructors_in_immutables

import 'package:emtalik/Widgets/CustomDrawer.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/pages/search.dart';
import 'package:emtalik/providers/locale_provider.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  DateTime pressed = DateTime.now();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          // TODO: UNCOMMENT FOR FULL PRIVILEGES
          drawer:
              // Provider.of<UserSession>(context,listen: false).role != null
              // ?
              CustomDrawer()
          // : null
          ,
          appBar: AppBar(
            title: Text(
              "search".i18n(),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // TODO: UNCOMMENT FOR FULL PRIVILEGES
                  // if (Provider.of<UserSession>(context, listen: false).role !=
                  //     null) {
                  showSearch(
                    context: context,
                    delegate: MySearch(),
                  );
                  // } else {
                  //   ToastFactory.makeToast(context, TOAST_TYPE.info, null,
                  //       "no-privileges-for-guest".i18n(), false, () {});
                  // }
                },
              ),
            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.house),
                label: "estates".i18n(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_offer),
                label: "offers".i18n(),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: SpeedDial(
            direction:
                Provider.of<LocaleProvider>(context, listen: false).locale ==
                        const Locale('en')
                    ? SpeedDialDirection.right
                    : SpeedDialDirection.left,
            switchLabelPosition: true,
            animatedIcon: AnimatedIcons.menu_close,
            buttonSize: const Size(60, 60),
            children: [
              SpeedDialChild(
                label: "add-estate".i18n(),
                labelStyle: Theme.of(context).textTheme.labelSmall,
                child: Icon(
                  Icons.real_estate_agent_sharp,
                ),
                onTap: () {
                  // TODO: UNCOMMENT FOR FULL FUNCTIONALITY
                  // if (Provider.of<UserSession>(context, listen: false).role ==
                  //     "Seller") {
                  // TODO: WORK HERE

                  // } else if (Provider.of<UserSession>(context, listen: false)
                  //         .role ==
                  //     "Buyer") {
                  //   ToastFactory.makeToast(context, TOAST_TYPE.info, null,
                  //       "no-privileges-for-selling".i18n(), false, () {});
                  // } else {
                  //   ToastFactory.makeToast(context, TOAST_TYPE.info, null,
                  //       "no-privileges-for-guest".i18n(), false, () {});
                  // }
                },
              ),
              SpeedDialChild(
                label: "add-offer".i18n(),
                labelStyle: Theme.of(context).textTheme.labelSmall,
                child: Icon(
                  Icons.local_offer_sharp,
                ),
                onTap: () {
                  // TODO: UNCOMMENT FOR FULL FUNCTIONALITY
                  // if (Provider.of<UserSession>(context, listen: false).role ==
                  //     "Seller") {
                  // TODO: WORK HERE

                  // } else if (Provider.of<UserSession>(context, listen: false)
                  //         .role ==
                  //     "Buyer") {
                  //   ToastFactory.makeToast(context, TOAST_TYPE.info, null,
                  //       "no-privileges-for-selling".i18n(), false, () {});
                  // } else {
                  //   ToastFactory.makeToast(context, TOAST_TYPE.info, null,
                  //       "no-privileges-for-guest".i18n(), false, () {});
                  // }
                },
              ),
            ],
          ),
          body: Column(children: <Widget>[]),
        ),
      );

  Widget bulidCard() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              Stack(
                children: [
                  Ink.image(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
                    ),
                    child: InkWell(
                      onTap: () {},
                    ),
                    height: 200,
                    width: 500,
                    fit: BoxFit.cover,
                  ),
                  // ignore: prefer_const_constructors
                  Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    // ignore: prefer_const_constructors
                    child: Text(
                      "land".i18n(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(16).copyWith(bottom: 0),
                  child: Column(
                    children: [
                      Text(
                        "location".i18n(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        "estate".i18n(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        "name-estate".i18n(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  )),
              ButtonBar()
            ],
          ),
        ),
      );
}
