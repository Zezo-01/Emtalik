import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/offer.dart';
import 'package:emtalik/pages/apartment_display.dart';
import 'package:emtalik/pages/land_display.dart';
import 'package:emtalik/pages/parking_display.dart';
import 'package:emtalik/pages/store_display.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';

class DisplayOffer extends StatefulWidget {
  DisplayOffer({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  State<DisplayOffer> createState() => _DisplayOfferState(id: id);
}

class _DisplayOfferState extends State<DisplayOffer> {
  _DisplayOfferState({required this.id});

  int id;
  late Future<Offer> offerFuture;
  Future<Offer> getOffer() async {
    var response = await HttpService.getOfferById(id);
    return Offer.fromRawJson(response.body);
  }

  @override
  void initState() {
    super.initState();
    offerFuture = getOffer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: offerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            var offer = snapshot.data as Offer;
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
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      decodeUtf8ToString(offer.name),
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              body: SingleChildScrollView(
                  child: Column(
                children: [
                  Image.network(
                    HttpService.getEstateMainPicture(offer.estateId ?? 0),
                    fit: BoxFit.cover,
                  ),
                  TextButton(
                    onPressed: () {
                      if (offer.estateType == "parking") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ParkingDisplay(id: offer.estateId ?? 0)));
                      } else if (offer.estateType == "apartment") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ApartmentDisplay(
                              id: offer.estateId ?? 0,
                            ),
                          ),
                        );
                      } else if (offer.estateType == "house") {
                      } else if (offer.estateType == "store") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoreDisplay(
                              id: offer.estateId ?? 0,
                            ),
                          ),
                        );
                      } else if (offer.estateType == "land") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LandDisplay(
                              id: offer.estateId ?? 0,
                            ),
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "estate-name".i18n(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          decodeUtf8ToString(offer.estateName ?? ""),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "offer-type".i18n(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                      Text(
                        offer.type.i18n(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  offer.type == "sell"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "price".i18n(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w300),
                            ),
                            Text(
                              offer.sellPrice.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w300),
                            ),
                          ],
                        )
                      : ListView(
                          shrinkWrap: true,
                          children: [
                            offer.rentPricePerMonth != 0 &&
                                    offer.rentPricePerMonth != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Wrap(
                                        children: [
                                          const Icon(
                                              Icons.calendar_month_rounded),
                                          Text(
                                            "rent-per-month".i18n(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.green),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        offer.rentPricePerMonth.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.green),
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            offer.rentPricePerYear != 0 &&
                                    offer.rentPricePerYear != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Wrap(
                                        children: [
                                          const Icon(
                                              Icons.calendar_month_rounded),
                                          Text(
                                            "rent-per-year".i18n(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.green),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        offer.rentPricePerYear.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.green),
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            offer.rentPricePerSeasson != 0 &&
                                    offer.rentPricePerSeasson != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Wrap(
                                        children: [
                                          const Icon(
                                              Icons.calendar_month_rounded),
                                          Text(
                                            "rent-per-seasson".i18n(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.green),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        offer.rentPricePerSeasson.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.green),
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                          ],
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "negotiable".i18n(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                      Text(
                        offer.negotiable ? "yes".i18n() : "no".i18n(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),

                ],
              )),
            );
          }
        },
      ),
    );
  }
}
