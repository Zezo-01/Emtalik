// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_const_constructors, unused_local_variable, prefer_const_declarations, unused_import, unnecessary_new, sized_box_for_whitespace, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class DisplayCard extends StatefulWidget {
  DisplayCard({
    Key? key,
    this.header1,
    this.header2,
    this.header3,
    this.onPress,
    this.image,
  }) : super(key: key);

  String? header1;
  String? header2;
  int? header3;
  Widget? image;
  void Function(String value)? onPress;
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _DisplayCard(
        header1: header1,
        header2: header2,
        header3: header3,
        onPress: onPress,
      );
}

class _DisplayCard extends State<DisplayCard> {
  final items = List.generate(10, (index) => '$index');
  String? header1;
  String? header2;
  int? header3;
  Widget? image;
  void Function(String value)? onPress;

  _DisplayCard({
    this.header1,
    this.header2,
    this.header3,
    this.image,
    this.onPress,
  });
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
            child: Container(
          margin: new EdgeInsets.all(1.0),
          child: Card(
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text('$header1')),
                InkWell(
                  onTap: () => onPress,
                  splashColor: Colors.blue,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Image.asset(
                      "assets/user/default_pfp.png",
                      fit: BoxFit.cover,
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text('$header2')),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text('$header3')),
              ],
            ),
          ),
        )),
      );
}