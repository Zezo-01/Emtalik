import 'dart:convert';

import 'package:emtalik/Widgets/displaycard.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/estate_response.dart';
import 'package:emtalik/models/offer.dart';
import 'package:emtalik/models/user_details.dart';
import 'package:emtalik/pages/apartment_display.dart';
import 'package:emtalik/pages/edit_estate.dart';
import 'package:emtalik/pages/house_display.dart';
import 'package:emtalik/pages/land_display.dart';
import 'package:emtalik/pages/offer_display.dart';
import 'package:emtalik/pages/parking_display.dart';
import 'package:emtalik/pages/store_display.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  UserPage({Key? key, required this.userId}) : super(key: key);

  int userId;
  @override
  State<UserPage> createState() => _UserPageDisplay(userId: userId);
}

class _UserPageDisplay extends State<UserPage> {
  _UserPageDisplay({required this.userId});
  int userId;

  late Future<UserDetails> user;

  late Future<List<Offer>> offers;

  late Future<List<EstateResponse>> estates;

  Future<UserDetails> getUser() async {
    var response = await HttpService.getUserById(userId);
    var user = UserDetails.fromRawJson(response.body);
    return user;
  }

  Future<List<Offer>> getOffers() async {
    List<Offer> offers = List.empty(growable: true);
    var response = await HttpService.getUserApprovedOffers(userId);
    var offersJson;
    if (response.body.isEmpty) {
      return offers;
    } else {
      offersJson = jsonDecode(response.body);
    }

    for (var offer in offersJson) {
      offers.add(Offer.fromJson(offer));
    }

    return offers;
  }

  Future<List<EstateResponse>> getEstates() async {
    List<EstateResponse> estates = List.empty(growable: true);
    http.Response estateResponse =
        await HttpService.getUserApprovedEstates(userId);
    var estatesList;
    if (estateResponse.body.isEmpty) {
      return estates;
    } else {
      estatesList = jsonDecode(estateResponse.body);
    }

    for (var estate in estatesList) {
      estates.add(EstateResponse.fromJson(estate));
    }

    return estates;
  }

  @override
  void initState() {
    super.initState();
    user = getUser();
    estates = getEstates();
    offers = getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasData) {
            UserDetails user = snapshot.data as UserDetails;
            return Scaffold(
              appBar: AppBar(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(1000),
                    ),
                    side: BorderSide(width: 3, color: Colors.black)),
                bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(20), child: SizedBox()),
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                centerTitle: true,
                shadowColor: Colors.black,
                title: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Text(
                      decodeUtf8ToString(user.username),
                      style: Theme.of(context).textTheme.headline4,
                    )),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: ClipOval(
                          child: Image.network(
                            HttpService.getProfilePictureRoute(userId),
                            fit: BoxFit.cover,
                            width: 250,
                          ),
                        ),
                      ),
                    ),
                    if (user.firstName != null &&
                        user.fathersName != null &&
                        user.grandfathersName != null &&
                        user.surName != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("full-name".i18n()),
                          Text(
                            decodeUtf8ToString(user.firstName!) +
                                " " +
                                decodeUtf8ToString(user.fathersName!) +
                                " " +
                                decodeUtf8ToString(user.grandfathersName!) +
                                " " +
                                decodeUtf8ToString(user.surName!) +
                                " ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    if (user.role == "admin")
                      Center(
                        child: Text(
                          "admin".i18n(),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    if (user.contactNumber != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("phone".i18n()),
                          Text(
                            user.contactNumber!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    Container(
                      margin:
                          const EdgeInsets.only(right: 10, left: 10, top: 10),
                      child: Text("chose-interests".i18n()),
                    ),
                    if (user.interests != null && user.interests!.isNotEmpty)
                      ListView.builder(
                        itemCount: user.interests!.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: Icon(
                                  user.interests![index] == "land"
                                      ? Icons.landscape
                                      : user.interests![index] == "store"
                                          ? Icons.store
                                          : user.interests![index] == "house"
                                              ? Icons.house
                                              : user.interests![index] ==
                                                      "apartment"
                                                  ? Icons.apartment
                                                  : Icons.local_parking,
                                ),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, left: 5),
                                  child: Text(user.interests![index].i18n())),
                            ],
                          );
                        }),
                      ),
                    if (user.role == "seller" || user.role == "admin")
                      FutureBuilder(
                          future: estates,
                          builder: (context, snapshot) {
                            List<EstateResponse> estates =
                                snapshot.data as List<EstateResponse>;
                            if (estates.isNotEmpty) {
                              return Container(
                                height: 400,
                                child: ListView.builder(
                                  itemCount: estates.length,
                                  shrinkWrap: false,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: ((context, index) {
                                    return DisplayCard(
                                      onPress: () {
                                        if (estates.elementAt(index).type ==
                                            "parking") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ParkingDisplay(
                                                id: estates.elementAt(index).id,
                                              ),
                                            ),
                                          );
                                        } else if (estates
                                                .elementAt(index)
                                                .type ==
                                            "apartment") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ApartmentDisplay(
                                                id: estates.elementAt(index).id,
                                              ),
                                            ),
                                          );
                                        } else if (estates
                                                .elementAt(index)
                                                .type ==
                                            "house") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HouseDisplay(
                                                id: estates.elementAt(index).id,
                                              ),
                                            ),
                                          );
                                        } else if (estates
                                                .elementAt(index)
                                                .type ==
                                            "store") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  StoreDisplay(
                                                id: estates.elementAt(index).id,
                                              ),
                                            ),
                                          );
                                        } else if (estates
                                                .elementAt(index)
                                                .type ==
                                            "land") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LandDisplay(
                                                id: estates.elementAt(index).id,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      borderColor:
                                          Theme.of(context).colorScheme.primary,
                                      header: decodeUtf8ToString(
                                          estates.elementAt(index).name),
                                      imageNetworkPath:
                                          HttpService.getEstateMainPicture(
                                              estates.elementAt(index).id),
                                      footer1: estates
                                          .elementAt(index)
                                          .province
                                          .i18n(),
                                      footer2: decodeUtf8ToString(
                                              estates.elementAt(index).type)
                                          .i18n(),
                                    );
                                    ;
                                  }),
                                ),
                              );
                            } else {
                              return Center(child: Text("no-estates".i18n()));
                            }
                          }),
                    Divider(
                      endIndent: 25,
                      thickness: 3,
                      indent: 25,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    if (user.role == "seller" || user.role == "admin")
                      FutureBuilder(
                          future: offers,
                          builder: (context, snapshot) {
                            List<Offer> offers = snapshot.data as List<Offer>;

                            if (offers.isNotEmpty) {
                              return Container(
                                height: 400,
                                child: ListView.builder(
                                  itemCount: offers.length,
                                  shrinkWrap: false,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: ((context, index) {
                                    return DisplayCard(
                                      onPress: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DisplayOffer(
                                                id: offers.elementAt(index).id),
                                          ),
                                        );
                                      },
                                      borderColor:
                                          Theme.of(context).colorScheme.primary,
                                      header: decodeUtf8ToString(
                                          offers.elementAt(index).name),
                                      imageNetworkPath:
                                          HttpService.getEstateMainPicture(
                                              offers
                                                      .elementAt(index)
                                                      .estateId ??
                                                  0),
                                      footer1:
                                          offers.elementAt(index).type.i18n(),
                                      footer2: offers
                                                  .elementAt(index)
                                                  .sellPrice !=
                                              0.0
                                          ? offers
                                              .elementAt(index)
                                              .sellPrice
                                              .toString()
                                          : offers
                                                      .elementAt(index)
                                                      .rentPricePerMonth !=
                                                  0.0
                                              ? "rent-per-month".i18n() +
                                                  " " +
                                                  offers
                                                      .elementAt(index)
                                                      .rentPricePerMonth
                                                      .toString()
                                              : offers
                                                          .elementAt(index)
                                                          .rentPricePerYear !=
                                                      0.0
                                                  ? "rent-per-year".i18n() +
                                                      " " +
                                                      offers
                                                          .elementAt(index)
                                                          .rentPricePerYear
                                                          .toString()
                                                  : offers
                                                              .elementAt(index)
                                                              .rentPricePerSeasson !=
                                                          0.0
                                                      ? "rent-per-seasson"
                                                              .i18n() +
                                                          " " +
                                                          offers
                                                              .elementAt(index)
                                                              .rentPricePerSeasson
                                                              .toString()
                                                      : "",
                                    );
                                  }),
                                ),
                              );
                            } else {
                              return Center(child: Text("no-offers".i18n()));
                            }
                          }),
                    if (userId ==
                        Provider.of<UserSession>(context, listen: false).id)
                      ElevatedButton.icon(
                        icon: const Icon(Icons.edit),
                        label: Text("edit-profile".i18n()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.secondary),
                        ),
                        onPressed: () {
                          // TODO MAKE EDIT PAGES
                        },
                      ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "no-connection".i18n(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          user = getUser();
                        });
                      },
                      icon: const Icon(
                        Icons.refresh,
                        size: 35,
                      ),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
