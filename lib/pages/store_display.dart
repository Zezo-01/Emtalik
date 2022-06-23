// ignore_for_file: no_logic_in_create_state, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:convert';
import 'dart:typed_data';

import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/media_response.dart';
import 'package:emtalik/models/store.dart';
import 'package:emtalik/pages/image_display.dart';
import 'package:emtalik/pages/video_display.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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

  Uint8List? thumb;
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

  void getThumbNail(int estateId, int mediaId) async {
    var result = await VideoThumbnail.thumbnailData(
        video: HttpService.getEstateMedia(estateId, mediaId));

    thumb = result;
  }

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
                                    getThumbNail(id, media[index].id);
                                  }
                                  return Wrap(
                                    children: [
                                      ClipOval(
                                        child: media[index]
                                                    .contentType
                                                    .split("/")[0] ==
                                                "image"
                                            ? TextButton(
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
                                                                  .getEstateMedia(
                                                                      id,
                                                                      media[index]
                                                                          .id)),
                                                    ),
                                                  );
                                                },
                                              )
                                            : FutureBuilder(
                                                future: VideoThumbnail
                                                    .thumbnailData(
                                                        video: HttpService
                                                            .getEstateMedia(
                                                                id,
                                                                media[index]
                                                                    .id)),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return CircularProgressIndicator();
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Wrap();
                                                  } else {
                                                    return TextButton(
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Image.memory(
                                                            thumb!,
                                                            fit: BoxFit.cover,
                                                            width: 250,
                                                            height: 500,
                                                          ),
                                                          CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                Colors.black54,
                                                            child: Icon(Icons
                                                                .play_arrow),
                                                          )
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    ((context) =>
                                                                        DisplayVideo(
                                                                          link: HttpService.getEstateMedia(
                                                                              id,
                                                                              media[index].id),
                                                                        ))));
                                                      },
                                                    );
                                                  }
                                                },
                                              ),
                                              
                                      ),
                                   const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, bottom: 5, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    openFeedback();
                                  },
                                  child: Text("give-feedback".i18n()),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/editpage');
                                },
                                child: Text("edit-estate".i18n()),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 5, top: 10),
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  child: Text("delete-estate".i18n()),
                                  onPressed: () {
                                    openDialop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      );
      Future openDialop() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("delete-estate?".i18n()),
            actions: [
              ElevatedButton(onPressed: () {}, child: Text("yes".i18n())),
              ElevatedButton(onPressed: () {Navigator.pop(context);
              }, child: Text("no".i18n())),
            ],
          ));

          Future openFeedback() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("feedback".i18n()),
            content: TextField(
              decoration: InputDecoration(hintText: 'FeedBack'),
            ),
            actions: [
              ElevatedButton(onPressed: () {}, child: Text("submit".i18n())),
             
            ],
          ));
}
