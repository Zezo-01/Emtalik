// ignore_for_file: no_logic_in_create_state, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:convert';
import 'dart:typed_data';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/estate_response.dart';
import 'package:emtalik/models/media_response.dart';
import 'package:emtalik/models/parking.dart';
import 'package:emtalik/pages/edit_parking.dart';
import 'package:emtalik/pages/image_display.dart';
import 'package:emtalik/pages/user_page.dart';
import 'package:emtalik/pages/video_display.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
  late Future<List<MediaResponse>> media;

  Future<List<MediaResponse>> getMediaInfo() async {
    var response = await HttpService.getEstateMediaInfo(id);

    var mediaInfoString = jsonDecode(response.body);

    List<MediaResponse> result = List.empty(growable: true);
    for (var media in mediaInfoString) {
      result.add(MediaResponse.fromJson(media));
    }
    return result;
  }

  Future<Uint8List?> getThumbNail(int estateId, int mediaId) async {
    var result = await VideoThumbnail.thumbnailData(
        video: HttpService.getEstateMedia(estateId, mediaId));

    return result;
  }

  Future<Parking> getParking() async {
    var response = await HttpService.getEstateByTypeAndId("parking", id);
    return Parking.fromRawJson(response.body);
  }

  @override
  void initState() {
    super.initState();
    parking = getParking();
    media = getMediaInfo();
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        UserPage(userId: parking.ownerId))));
                          },
                          child: Row(
                            children: [
                              Text("owner".i18n()),
                              const SizedBox(width: 20),
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
                            ],
                          ),
                        ),
                      ),
                      Provider.of<UserSession>(context).role == "admin" ||
                              Provider.of<UserSession>(context).id ==
                                  parking.ownerId
                          ? Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: FaIcon(parking.approved
                                        ? FontAwesomeIcons.check
                                        : FontAwesomeIcons.x)),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20, bottom: 5, top: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "approval".i18n(),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20, bottom: 5, top: 10),
                                  alignment: Alignment.centerLeft,
                                  child: parking.approved
                                      ? Text(
                                          "yes".i18n(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        )
                                      : Text(
                                          "no".i18n(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                ),
                                Provider.of<UserSession>(context).role ==
                                        "admin"
                                    ? ElevatedButton(
                                        onPressed: () async {
                                          var response = await HttpService
                                              .toggleEstateApproval(id);
                                          if (response.statusCode == 200) {
                                            setState(() {
                                              this.parking = getParking();
                                            });
                                          } else {
                                            ToastFactory.makeToast(
                                                context,
                                                TOAST_TYPE.warning,
                                                null,
                                                "error".i18n(),
                                                false,
                                                () {});
                                          }
                                        },
                                        child: parking.approved
                                            ? Text("not-approve?".i18n())
                                            : Text("approve?".i18n()))
                                    : Wrap(),
                              ],
                            )
                          : Wrap(),
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
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 5, top: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(parking.carsAllowd!
                                    .split(",")[index]
                                    .i18n()),
                              ),
                              SizedBox(width: 5),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 5, bottom: 5, top: 10),
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
                      FutureBuilder(
                        future: media,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            List<MediaResponse> media =
                                snapshot.data as List<MediaResponse>;
                            return Container(
                              height: 500,
                              child: ListView.builder(
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: media.length,
                                itemBuilder: (context, index) {
                                  if (media[index].contentType.split("/")[0] !=
                                      "image") {
                                    var future;
                                    future = getThumbNail(id, media[index].id);
                                    return FutureBuilder(
                                      future: future,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                              width: 250,
                                              height: 500,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()));
                                        } else if (snapshot.hasError) {
                                          setState(() {
                                            future = getThumbNail(
                                                id, media[index].id);
                                          });
                                          return Wrap();
                                        } else {
                                          Uint8List? data =
                                              snapshot.data as Uint8List?;
                                          return ClipOval(
                                            child: TextButton(
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Image.memory(
                                                    data!,
                                                    fit: BoxFit.cover,
                                                    width: 250,
                                                    height: 500,
                                                  ),
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        Colors.black54,
                                                    child:
                                                        Icon(Icons.play_arrow),
                                                  )
                                                ],
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            DisplayVideo(
                                                              link: HttpService
                                                                  .getEstateMedia(
                                                                      id,
                                                                      media[index]
                                                                          .id),
                                                            ))));
                                              },
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  } else {
                                    return ClipOval(
                                      child: TextButton(
                                        child: Image.network(
                                          HttpService.getEstateMedia(
                                              id, media[index].id),
                                          fit: BoxFit.cover,
                                          width: 250,
                                          height: 500,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ImageDisplay(
                                                      link: HttpService
                                                          .getEstateMedia(id,
                                                              media[index].id)),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      Provider.of<UserSession>(context, listen: false).id ==
                              parking.ownerId
                          ? Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.edit),
                                    label: Text("edit-estate".i18n()),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  EditParking(id: id))));
                                    },
                                  ),
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.delete_forever),
                                    label: Text("delete-estate".i18n()),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .error),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              "delete-estate".i18n(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "estate-delete-confirmation"
                                                        .i18n(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        var response =
                                                            await HttpService
                                                                .deleteEstateById(
                                                                    id);
                                                        if (response
                                                                .statusCode ==
                                                            200) {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator
                                                              .popAndPushNamed(
                                                                  context,
                                                                  "/mainpage");
                                                        } else {
                                                          Navigator.pop(
                                                              context);
                                                          ToastFactory
                                                              .makeToast(
                                                                  context,
                                                                  TOAST_TYPE
                                                                      .warning,
                                                                  null,
                                                                  "error"
                                                                      .i18n(),
                                                                  false,
                                                                  () {});
                                                        }
                                                      },
                                                      child: Text("yes".i18n(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Theme.of(
                                                                          context)
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
                                                              MaterialStateProperty
                                                                  .all(Theme.of(
                                                                          context)
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
                          : Wrap(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      );
}
