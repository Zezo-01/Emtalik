// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_const_constructors, unused_local_variable, prefer_const_declarations, unused_import, unnecessary_new, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_if_null_operators
import 'package:emtalik/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class DisplayCard extends StatefulWidget {
  DisplayCard({
    Key? key,
    this.header,
    this.footer1,
    this.footer2,
    this.borderColor,
    this.onPress,
    this.imageNetworkPath,
  }) : super(key: key);

  String? header;
  Color? borderColor;
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
        borderColor: borderColor,
        imageNetworkPath: imageNetworkPath,
        onPress: onPress,
      );
}

class _DisplayCard extends State<DisplayCard> {
  String? header;
  String? footer1;
  String? footer2;
  Color? borderColor;
  String? imageNetworkPath;
  void Function()? onPress;

  _DisplayCard({
    this.header,
    this.footer1,
    this.footer2,
    this.borderColor,
    this.imageNetworkPath,
    this.onPress,
  });
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPress == null ? null : onPress,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 3,
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: header == null
                    ? null
                    : Text(
                        header ?? "",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: imageNetworkPath == null
                    ? null
                    : Image.network(
                        imageNetworkPath ?? "",
                        fit: BoxFit.cover,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                      ),
              ),
              Container(
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  child: footer1 == null
                      ? null
                      : Text(footer1 ?? "",
                          style: Theme.of(context).textTheme.bodySmall)),
              Container(
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  child: footer2 == null
                      ? null
                      : Text(footer2 ?? "",
                          style: Theme.of(context).textTheme.bodySmall)),
            ],
          ),
        ),
      );
}
