import 'dart:convert';

import 'package:emtalik/Widgets/displaycard.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/offer.dart';
import 'package:emtalik/pages/offer_display.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:localization/localization.dart';

class MyOffers extends StatefulWidget {
  MyOffers({Key? key, required this.userId}) : super(key: key);

  int userId;
  @override
  State<MyOffers> createState() => _MyOffersState(userId: userId);
}

class _MyOffersState extends State<MyOffers> {
  _MyOffersState({required this.userId});

  late Future<List<Offer>> offers;

  Future<List<Offer>> getOffers() async {
    List<Offer> offers = List.empty(growable: true);
    http.Response offerResponse = await HttpService.getUserOffers(userId);
    var offersList = jsonDecode(offerResponse.body);
    if (offersList.isNotEmpty) {
      for (var offer in offersList) {
        offers.add(Offer.fromJson(offer));
      }
    }
    return offers;
  }

  @override
  void initState() {
    super.initState();
    offers = getOffers();
  }

  int userId;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("my-offers".i18n()),
          centerTitle: true,
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                offers = getOffers();
              });
            },
            child: FutureBuilder(
              future: offers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData) {
                    final offers = snapshot.data as List<Offer>;

                    if (offers.isEmpty) {
                      return Center(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              "no-offers".i18n(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  this.offers = getOffers();
                                });
                              },
                              icon: const Icon(
                                Icons.refresh,
                                size: 35,
                              ),
                              color: Theme.of(context).colorScheme.primary,
                            )
                          ],
                        ),
                      );
                    } else {
                      return GridView.builder(
                        itemCount: offers.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2 / 4,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
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
                            borderColor: Theme.of(context).colorScheme.primary,
                            header: decodeUtf8ToString(
                                offers.elementAt(index).name),
                            imageNetworkPath: HttpService.getEstateMainPicture(
                                offers.elementAt(index).estateId ?? 0),
                            footer1: offers.elementAt(index).type.i18n(),
                            footer2: offers.elementAt(index).sellPrice != 0.0
                                ? offers.elementAt(index).sellPrice.toString()
                                : offers.elementAt(index).rentPricePerMonth !=
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
                                            ? "rent-per-seasson".i18n() +
                                                " " +
                                                offers
                                                    .elementAt(index)
                                                    .rentPricePerSeasson
                                                    .toString()
                                            : "",
                          );
                        },
                      );
                    }
                  } else {
                    return Center(
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
                                this.offers = getOffers();
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
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
