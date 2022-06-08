// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_const_constructors, unused_local_variable, prefer_const_declarations, unused_import, unnecessary_new, sized_box_for_whitespace, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class DisplayCard extends StatefulWidget {
  DisplayCard({
    Key? key,
    this.header,
    this.footer1,
    this.footer2,
    this.onPress,
    this.imageNetworkPath,
  }) : super(key: key);

  String? header;
  String? footer1;
  String? footer2;
  String? imageNetworkPath;
  void Function()? onPress;
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _DisplayCard(
        header: header,
        footer1: footer1,
        footer2: footer2,
        imageNetworkPath: imageNetworkPath,
        onPress: onPress,
      );
}

class _DisplayCard extends State<DisplayCard> {
  String? header;
  String? footer1;
  String? footer2;
  String? imageNetworkPath;
  void Function()? onPress;

  _DisplayCard({
    this.header,
    this.footer1,
    this.footer2,
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
                  child: header == null ? null : Text(header ?? ""),
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
                    child: footer1 == null ? null : Text(footer1 ?? "")),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: footer2 == null ? null : Text(footer2 ?? "")),
              ],
            ),
          ),
        )),
      );
}
