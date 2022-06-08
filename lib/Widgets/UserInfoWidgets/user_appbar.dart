import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final icon = CupertinoIcons.moon_stars;
  return AppBar(
    leading: BackButton(),
    elevation: 0,
    backgroundColor: Colors.transparent,
    actions: [
      IconButton(
        icon: Icon(icon),
        onPressed: () {},
      )
    ],
  );
}
