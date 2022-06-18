// ignore_for_file: no_logic_in_create_state, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/parking.dart';
import 'package:emtalik/pages/mainpage.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class ParkingDisplay extends StatefulWidget {
  ParkingDisplay({
    Key? key,
    required this.id,
  }) : super(key: key);
  int id;

  @override
  State<StatefulWidget> createState() => _ParkingDisplay(id: id);
}

class _ParkingDisplay extends State<ParkingDisplay> {
  _ParkingDisplay({
    required this.id,
  });

  int id;
  late Future<Parking> parking;

  Future<Parking> getParking() async {
    var response = await HttpService.getEstateByTypeAndId("parking", id);

    return Parking.fromRawJson(response.body);
  }

  @override
  void initState() {
    super.initState();
    parking = getParking();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: FutureBuilder(
          future: parking,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              var parking = snapshot.data as Parking;
              return Scaffold(
                appBar: AppBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(1000),
                        bottomRight: Radius.circular(1000),
                      ),
                      side: BorderSide(width: 3, color: Colors.black)),
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(20), child: SizedBox()),
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  centerTitle: true,
                  shadowColor: Colors.black,
                  title: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        decodeUtf8ToString(parking.name),
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
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        child: Image.network(
                          HttpService.getEstateMainPicture(parking.id),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: ClipOval(
                                    child: Provider.of<UserSession>(context)
                                            .picture
                                        ? Image.network(
                                            HttpService.getProfilePictureRoute(
                                                parking.ownerId),
                                            width: 35,
                                          )
                                        : Image.asset(
                                            "assets/user/default_pfp.png",
                                            width: 35,
                                          ),
                                  ),
                                ),
                                Text(
                                  decodeUtf8ToString(parking.ownerUserName),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                const SizedBox(width: 20),
                                Text("owner".i18n()),
                              ],
                            ),
                          )),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: FaIcon(FontAwesomeIcons.city)),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, bottom: 5, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              parking.province.i18n() +
                                  ", " +
                                  decodeUtf8ToString(parking.address),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: FaIcon(FontAwesomeIcons.ruler)),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, bottom: 5, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              parking.size.toString().i18n(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("size-in-square-meters".i18n()),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: FaIcon(FontAwesomeIcons.squareParking)),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, bottom: 5, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              parking.vehicleCapacity.toString().i18n(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("vehicle-capacity".i18n()),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: parking.carsAllowd!.split(",").length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 20, bottom: 5, top: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Icon(FontAwesomeIcons.circleDot)),
                              const SizedBox(width: 5),
                              Container(
                                 margin:
                                EdgeInsets.only(left: 20, bottom: 5, top: 10),
                            alignment: Alignment.centerLeft,
                                child: Text(parking.carsAllowd!
                                    .split(",")[index]
                                    .i18n()),
                              ),
                              SizedBox(width: 5),
                              Container(
                                 margin:
                                EdgeInsets.only(left: 5, bottom: 5, top: 10),
                            alignment: Alignment.centerLeft,
                                child: Icon(parking.carsAllowd!
                                            .split(",")[index] ==
                                        "automobile"
                                    ? FontAwesomeIcons.car
                                    : parking.carsAllowd!.split(",")[index] ==
                                            "bus"
                                        ? FontAwesomeIcons.bus
                                        : parking.carsAllowd!
                                                    .split(",")[index] ==
                                                "bike"
                                            ? FontAwesomeIcons.bicycle
                                            : parking.carsAllowd!
                                                        .split(",")[index] ==
                                                    "truck"
                                                ? FontAwesomeIcons.truck
                                                : null),
                              ),
                            ],
                          );
                        },
                      ),
                      Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ClipOval(
                              child: Provider.of<UserSession>(context).picture
                                  ? Image.network(
                                      HttpService.getProfilePictureRoute(
                                          parking.ownerId),
                                      width: 150,
                                    )
                                  : Image.asset(
                                      "assets/user/default_pfp.png",
                                      width: 150,
                                    ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            ClipOval(
                              child: Provider.of<UserSession>(context).picture
                                  ? Image.network(
                                      HttpService.getProfilePictureRoute(
                                          parking.ownerId),
                                      width: 150,
                                    )
                                  : Image.asset(
                                      "assets/user/default_pfp.png",
                                      width: 150,
                                    ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            ClipOval(
                              child: Provider.of<UserSession>(context).picture
                                  ? Image.network(
                                      HttpService.getProfilePictureRoute(
                                          parking.ownerId),
                                      width: 150,
                                    )
                                  : Image.asset(
                                      "assets/user/default_pfp.png",
                                      width: 150,
                                    ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            ClipOval(
                              child: Provider.of<UserSession>(context).picture
                                  ? Image.network(
                                      HttpService.getProfilePictureRoute(
                                          parking.ownerId),
                                      width: 150,
                                    )
                                  : Image.asset(
                                      "assets/user/default_pfp.png",
                                      width: 150,
                                    ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            ClipOval(
                              child: Provider.of<UserSession>(context).picture
                                  ? Image.network(
                                      HttpService.getProfilePictureRoute(
                                          parking.ownerId),
                                      width: 150,
                                    )
                                  : Image.asset(
                                      "assets/user/default_pfp.png",
                                      width: 150,
                                    ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            ClipOval(
                              child: Provider.of<UserSession>(context).picture
                                  ? Image.network(
                                      HttpService.getProfilePictureRoute(
                                          parking.ownerId),
                                      width: 150,
                                    )
                                  : Image.asset(
                                      "assets/user/default_pfp.png",
                                      width: 150,
                                    ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            ClipOval(
                              child: Provider.of<UserSession>(context).picture
                                  ? Image.network(
                                      HttpService.getProfilePictureRoute(
                                          parking.ownerId),
                                      width: 150,
                                    )
                                  : Image.asset(
                                      "assets/user/default_pfp.png",
                                      width: 150,
                                    ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      );
}
