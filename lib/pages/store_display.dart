// ignore_for_file: no_logic_in_create_state, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/store.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class StoreDisplay extends StatefulWidget {
  StoreDisplay({
    Key? key,
    required this.id,
  }) : super(key: key);
  int id;

  @override
  State<StatefulWidget> createState() => _StoreDisplay(id: id);
}

class _StoreDisplay extends State<StoreDisplay> {
  _StoreDisplay({
    required this.id,
  });

  int id;
  late Future<Store> store;

  Future<Store> getStore() async {
    var response = await HttpService.getEstateByTypeAndId("store", id);

    return Store.fromRawJson(response.body);
  }

  @override
  void initState() {
    super.initState();
    store = getStore();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: FutureBuilder(
          future: store,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              var store = snapshot.data as Store;
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
                        decodeUtf8ToString(store.name),
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
                          HttpService.getEstateMainPicture(store.id),
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
                                                store.ownerId),
                                            width: 35,
                                          )
                                        : Image.asset(
                                            "assets/user/default_pfp.png",
                                            width: 35,
                                          ),
                                  ),
                                ),
                                Text(
                                  decodeUtf8ToString(store.ownerUserName),
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
                              store.province.i18n() +
                                  ", " +
                                  decodeUtf8ToString(store.province),
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
                              store.address.i18n() +
                                  ", " +
                                  decodeUtf8ToString(store.address),
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
                              store.size.toString().i18n(),
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
                              child: FaIcon(FontAwesomeIcons.accessibleIcon)),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, bottom: 5, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              store.fridges.toString().i18n(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("fridges-number".i18n()),
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
                                          store.ownerId),
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
                                          store.ownerId),
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
                                          store.ownerId),
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
                                          store.ownerId),
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
                                          store.ownerId),
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
                                          store.ownerId),
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
                                          store.ownerId),
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
