// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, annotate_overrides, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:emtalik/Widgets/customdrawer.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/models/estate_response.dart';
import 'package:emtalik/pages/search.dart';
import 'package:emtalik/providers/locale_provider.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  List<EstateResponse>? estates = List.empty(growable: true);

  late int currentIndex;

  void getEstates() async {
    try {
      http.Response estateResponse = await HttpService.getEstates();
      if (estateResponse.statusCode == 200) {
        var estatesList = jsonDecode(estateResponse.body);
        for (var estate in estatesList) {
          estates!.add(EstateResponse.fromJson(estate));
        }
        if (estates!.length != 0) {
          debugPrint(estates!.first.address);
        } else {
          debugPrint("THE LIST IS NULL");
        }
      } else {
        ToastFactory.makeToast(
            context, TOAST_TYPE.error, null, "error".i18n(), false, () {});
      }
    } catch (e, s) {
      debugPrint(s.toString());
      ToastFactory.makeToast(context, TOAST_TYPE.error, null,
          "no-connection".i18n(), false, () {});
    }
  }

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
    getEstates();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          // TODO: UNCOMMENT FOR FULL PRIVILEGES
          drawer: Provider.of<UserSession>(context, listen: false).role != null
              ? CustomDrawer()
              : null,
          appBar: AppBar(
            title: Text(
              "search".i18n(),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // TODO: UNCOMMENT FOR FULL PRIVILEGES
                  if (Provider.of<UserSession>(context, listen: false).role !=
                      null) {
                    showSearch(
                      context: context,
                      delegate: MySearch(),
                    );
                  } else {
                    ToastFactory.makeToast(context, TOAST_TYPE.info, null,
                        "no-privileges-for-guest".i18n(), false, () {});
                  }
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
                  // // TODO: UNCOMMENT FOR FULL FUNCTIONALITY
                  if (Provider.of<UserSession>(context, listen: false).role ==
                          "seller" ||
                      Provider.of<UserSession>(context, listen: false).role ==
                          "admin") {
                    Navigator.of(context).pushNamed('/estate_create');
                    // // TODO: WORK HERE

                  } else if (Provider.of<UserSession>(context, listen: false)
                          .role ==
                      "buyer") {
                    ToastFactory.makeToast(context, TOAST_TYPE.info, null,
                        "no-privileges-for-selling".i18n(), false, () {});
                  } else {
                    ToastFactory.makeToast(context, TOAST_TYPE.info, null,
                        "no-privileges-for-guest".i18n(), false, () {});
                  }
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
                  //     "seller" || Provider.of<UserSession>(context, listen: false).role == "admin") {
                  // TODO: WORK HERE

                  // } else if (Provider.of<UserSession>(context, listen: false)
                  //         .role ==
                  //     "buyer") {
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
          body: currentIndex == 0
              ? Column(
                  children: [
                    Text("Estate"),
                  ],
                )
              : Column(
                  children: [
                    Text("Offer"),
                  ],
                ),
        ),
      );
}
