// ignore_for_file: no_logic_in_create_state, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/land.dart';
import 'package:emtalik/models/store.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class LandDisplay extends StatefulWidget {
  LandDisplay({
    Key? key,
    required this.id,
  }) : super(key: key);
  int id;

  @override
  State<StatefulWidget> createState() => _LandDisplay(id: id);
}

class _LandDisplay extends State<LandDisplay> {
  _LandDisplay({
    required this.id,
  });

  int id;
  late Future<Land> land;

  Future<Land> getLand() async {
    var response = await HttpService.getEstateByTypeAndId("land", id);

    return Land.fromRawJson(response.body);
  }

  @override
  void initState() {
    super.initState();
    land = getLand();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: FutureBuilder(
          future: land,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              var land = snapshot.data as Land;
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
                        decodeUtf8ToString(land.name),
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
                          HttpService.getEstateMainPicture(land.id),
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
                                                land.ownerId),
                                            width: 35,
                                          )
                                        : Image.asset(
                                            "assets/user/default_pfp.png",
                                            width: 35,
                                          ),
                                  ),
                                ),
                                Text(
                                  decodeUtf8ToString(land.ownerUserName),
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
                              land.province.i18n() +
                                  ", " +
                                  decodeUtf8ToString(land.province),
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
                              child: FaIcon(FontAwesomeIcons.addressCard)),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, bottom: 5, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              land.address.i18n() +
                                  ", " +
                                  decodeUtf8ToString(land.address),
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
                              land.size.toString().i18n(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("size-in-square-meters".i18n()),
                        ],
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
                                          land.ownerId),
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
                                          land.ownerId),
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
                                          land.ownerId),
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
                                          land.ownerId),
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
                                          land.ownerId),
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
                                          land.ownerId),
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
                                          land.ownerId),
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