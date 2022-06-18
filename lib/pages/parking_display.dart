// ignore_for_file: no_logic_in_create_state, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers

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
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: FaIcon(FontAwesomeIcons.city)),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, bottom: 10, top: 10),
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
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            // TODO: ADD OPEN USER PROFILE FUNCTIONALITY
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: 20, left: 20),
                                    child: ClipOval(
                                      child: Provider.of<UserSession>(context)
                                              .picture
                                          ? Image.network(
                                              HttpService
                                                  .getProfilePictureRoute(
                                                      parking.ownerId),
                                              width: 35,
                                            )
                                          : Image.asset(
                                              "assets/user/default_pfp.png",
                                              width: 35,
                                            ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    decodeUtf8ToString(parking.ownerUserName),
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  )
                                ],
                              ),
                              Text("owner".i18n()),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: FaIcon(FontAwesomeIcons.ruler)),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  parking.size.toString() +
                                      " " +
                                      "square-meters".i18n(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          Text("size-in-square-meters".i18n()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child:
                                      FaIcon(FontAwesomeIcons.squareParking)),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  parking.vehicleCapacity.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          Text("vehicle-capacity".i18n()),
                        ],
                      ),
                      Text("vehicles-allowed".i18n()),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: parking.carsAllowd!.split(",").length,
                        itemBuilder: (context, index) {
                          return Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.circleDot),
                              const SizedBox(width: 5),
                              Text(
                                  parking.carsAllowd!.split(",")[index].i18n()),
                              SizedBox(width: 5),
                              Icon(parking.carsAllowd!.split(",")[index] ==
                                      "automobile"
                                  ? FontAwesomeIcons.car
                                  : parking.carsAllowd!.split(",")[index] ==
                                          "bus"
                                      ? FontAwesomeIcons.bus
                                      : parking.carsAllowd!.split(",")[index] ==
                                              "bike"
                                          ? FontAwesomeIcons.bicycle
                                          : parking.carsAllowd!
                                                      .split(",")[index] ==
                                                  "truck"
                                              ? FontAwesomeIcons.truck
                                              : null),
                            ],
                          );
                        },
                      ),
                      // TODO: FADI ADD MEDIA HORIZANTALE SCROLL HERE
                    ],
                  ),
                ),
              );
            }
          },
        ),
      );
}
