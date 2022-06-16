// ignore_for_file: no_logic_in_create_state, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers

import 'package:emtalik/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DisplayEstate extends StatefulWidget {
  DisplayEstate({
    Key? key,
    required this.id,
    required this.type,
  }) : super(key: key);
  int id;
  String type;

  @override
  State<StatefulWidget> createState() => _DisplayEstate(id: id, type: type);
}

class _DisplayEstate extends State<DisplayEstate> {
  _DisplayEstate({
    required this.id,
    required this.type,
  });

  int id;
  String type;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        appBar: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(1000),
                  bottomRight: Radius.circular(1000),
                ),
                side: BorderSide(width: 3, color: Colors.black)),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(40), child: SizedBox()),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            centerTitle: true,
            shadowColor: Colors.black,
            title: Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  "Estate Name",
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: ((context) => MyHomePage())));
                },
                icon: Icon(Icons.arrow_back))),
        body: SafeArea(
            child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10),
                child: Image.network(
                    "https://media.wired.com/photos/5af36b4a65806b269bfe8e44/master/pass/marijuana-522464999.jpg")),
            Container(
                margin: EdgeInsets.only(left: 1, bottom: 10, top: 10),
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 5),
                          child: ClipOval(
                            child: Image.network(
                              "https://media.wired.com/photos/5af36b4a65806b269bfe8e44/master/pass/marijuana-522464999.jpg",
                              width: 50,
                            ),
                          )),
                      Text(
                        "Owner Name :-",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                )),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: FaIcon(FontAwesomeIcons.expand)),
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Size :-",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: FaIcon(FontAwesomeIcons.question)),
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Type :-",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: FaIcon(FontAwesomeIcons.city)),
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Province :-",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: FaIcon(FontAwesomeIcons.houseFlag)),
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Address :-",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        )),
      ));
}
