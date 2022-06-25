import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/offer.dart';
import 'package:emtalik/pages/apartment_display.dart';
import 'package:emtalik/pages/house_display.dart';
import 'package:emtalik/pages/land_display.dart';
import 'package:emtalik/pages/offer_edit.dart';
import 'package:emtalik/pages/parking_display.dart';
import 'package:emtalik/pages/store_display.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HouseDisplay(
                                id: offer.estateId ?? 0,
                              ),
                            ),
                          );
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
                            offer.estateName == null
                                ? ""
                                : decodeUtf8ToString(offer.estateName!).length >
                                        15
                                    ? decodeUtf8ToString(offer.estateName!)
                                            .substring(0, 15) +
                                        "..."
                                    : decodeUtf8ToString(offer.estateName!),
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
                                                  .copyWith(
                                                      color: Colors.green,
                                                      fontSize: 17),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          offer.rentPricePerMonth.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.green,
                                              ),
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
                                                  .copyWith(
                                                      color: Colors.green,
                                                      fontSize: 17),
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
                                                  .copyWith(
                                                      color: Colors.green),
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
                    // Provider.of<UserSession>(context, listen: false).id ==
                    //         offer.ownerId
                    //     ?
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.edit),
                            label: Text("edit-offer".i18n()),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.secondary),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          OfferEdit(id: id))));
                            },
                          ),
                          ElevatedButton.icon(
                            icon: Icon(Icons.delete_forever),
                            label: Text("delete-offer".i18n()),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.error),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "delete-offer".i18n(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          child: Text(
                                            "offer-delete-confirmation".i18n(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                var response = await HttpService
                                                    .deleteOfferById(id);
                                                if (response.statusCode ==
                                                    200) {
                                                  Navigator.pop(context);
                                                  Navigator.popAndPushNamed(
                                                      context, "/mainpage");
                                                } else {
                                                  Navigator.pop(context);
                                                  ToastFactory.makeToast(
                                                      context,
                                                      TOAST_TYPE.warning,
                                                      null,
                                                      "error".i18n(),
                                                      false,
                                                      () {});
                                                }
                                              },
                                              child: Text("yes".i18n(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .error)),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "no".i18n(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    )
                    // : Wrap(),
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
