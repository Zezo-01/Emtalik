// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_const_constructors, unused_local_variable, prefer_const_declarations, unused_import, unnecessary_new, sized_box_for_whitespace, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class DisplayCard extends StatefulWidget {
  DisplayCard({
    Key? key,
    this.header1,
    this.header2,
    this.footer,
    this.onPress,
    this.imageNetworkPath,
  }) : super(key: key);

  String? header1;
  String? header2;
  String? footer;
  String? imageNetworkPath;
  void Function()? onPress;
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _DisplayCard(
        header1: header1,
        header2: header2,
        footer: footer,
        imageNetworkPath: imageNetworkPath,
        onPress: onPress,
      );
}

class _DisplayCard extends State<DisplayCard> {
  final items = List.generate(10, (index) => '$index');
  String? header1;
  String? header2;
  String? footer;
  String? imageNetworkPath;
  void Function()? onPress;

  _DisplayCard({
    this.header1,
    this.header2,
    this.footer,
    this.imageNetworkPath,
    this.onPress,
  });
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPress,
        child: Container(
            child: Container(
          margin: new EdgeInsets.all(1.0),
          child: Card(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text('$header1'),
                ),
                InkWell(
                  onTap: () => onPress,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: imageNetworkPath == null
                        ? null
                        : Image.network(
                            imageNetworkPath ?? "",
                            fit: BoxFit.cover,
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                          ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: header2 == null ? null : Text(header2 ?? "")),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: footer == null ? null : Text(footer ?? "")),
              ],
            ),
          ),
        )),
      );
}
