// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, annotate_overrides, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:emtalik/Widgets/customdrawer.dart';
import 'package:emtalik/Widgets/displaycard.dart';
import 'package:emtalik/etc/utils.dart';
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
  late int currentIndex;
  late Future<List<EstateResponse>> estates;

  Future<List<EstateResponse>> getEstates() async {
    List<EstateResponse> estates = List.empty(growable: true);
    http.Response estateResponse = await HttpService.getEstates();
    var estatesList = jsonDecode(estateResponse.body);
    if (estatesList.isNotEmpty) {
      for (var estate in estatesList) {
        estates.add(EstateResponse.fromJson(estate));
      }
    }
    return estates;
  }

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
    estates = getEstates();
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
                onTap: () async {
                  // TODO: UNCOMMENT FOR FULL FUNCTIONALITY
                  // if (Provider.of<UserSession>(context, listen: false).role ==
                  //         "seller" ||
                  //     Provider.of<UserSession>(context, listen: false).role ==
                  //         "admin") {
                  //   // TODO: WORK HERE
                  //   try {
                  //     var response = await HttpService.userHasEstates(
                  //         Provider.of<UserSession>(context, listen: false).id ??
                  //             0);
                  //     if (response.statusCode == 200) {
                  //       if (response.body == "true") {
                  //         //  HERE HE GOES TO THE offer route
                  Navigator.of(context).pushNamed('/offer_create');
                  //         } else {
                  //           ToastFactory.makeToast(
                  //               context,
                  //               TOAST_TYPE.error,
                  //               "you-dont-have-estates".i18n(),
                  //               "add-esates-to-add-offers".i18n(),
                  //               false,
                  //               () {});
                  //         }
                  //       } else {
                  //         ToastFactory.makeToast(context, TOAST_TYPE.error, null,
                  //             "error".i18n(), false, () {});
                  //       }
                  //     } catch (e) {
                  //       ToastFactory.makeToast(context, TOAST_TYPE.error, null,
                  //           "no-connection".i18n(), false, () {});
                  //     }
                  //   } else if (Provider.of<UserSession>(context, listen: false)
                  //           .role ==
                  //       "buyer") {
                  //     ToastFactory.makeToast(context, TOAST_TYPE.info, null,
                  //         "no-privileges-for-selling".i18n(), false, () {});
                  //   } else {
                  //     ToastFactory.makeToast(context, TOAST_TYPE.info, null,
                  //         "no-privileges-for-guest".i18n(), false, () {});
                  //   }
                },
              ),
            ],
          ),
          body: currentIndex == 0
              ? RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      estates = getEstates();
                    });
                  },
                  child: FutureBuilder(
                    future: estates,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        if (snapshot.hasData) {
                          final estates = snapshot.data as List<EstateResponse>;

                          if (estates.isEmpty) {
                            return Center(
                              child: Text(
                                "no-estates".i18n(),
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            );
                          } else {
                            return GridView.builder(
                              itemCount: estates.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2 / 4,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                return DisplayCard(
                                  onPress: () {
                                    if (Provider.of<UserSession>(context,
                                                listen: false)
                                            .role ==
                                        null) {
                                      ToastFactory.makeToast(
                                          context,
                                          TOAST_TYPE.info,
                                          null,
                                          "no-privileges-for-guest".i18n(),
                                          false,
                                          () {});
                                    } else {
                                      // TODO: OPEN ESTATE PAGE
                                      ToastFactory.makeToast(
                                          context,
                                          TOAST_TYPE.info,
                                          null,
                                          "implement estate view functionality",
                                          false,
                                          () {});
                                    }
                                  },
                                  borderColor:
                                      Theme.of(context).colorScheme.primary,
                                  header: decodeUtf8ToString(
                                      estates.elementAt(index).name),
                                  imageNetworkPath:
                                      HttpService.getEstateMainPicture(
                                          estates.elementAt(index).id),
                                  footer1:
                                      estates.elementAt(index).province.i18n(),
                                  footer2: decodeUtf8ToString(
                                          estates.elementAt(index).type)
                                      .i18n(),
                                );
                              },
                            );
                          }
                        } else {
                          debugPrint("Error : " + snapshot.error.toString());
                          return Center(
                            child: Text(
                              "no-connection".i18n(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          );
                        }
                      }
                    },
                  ),
                )
              : Column(
                  children: [
                    Text("Offer"),
                  ],
                ),
        ),
      );
}
