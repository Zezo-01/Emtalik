import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ProfileWidget extends StatelessWidget {
  final String pfpimg;
  final VoidCallback onClicked;

  const ProfileWidget({Key? key, required this.pfpimg, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(children: [
        buildImage(),
        Positioned(
          child: buildEditIcon(color),
          bottom: 0,
          right: 4,
        )
      ]),
    );
  }

  Widget buildImage() {
    final pfp = NetworkImage(pfpimg);
    return ClipOval(
        child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: pfp,
              fit: BoxFit.cover,
              width: 140,
              height: 140,
              child: InkWell(
                onTap: onClicked,
              ),
            )));
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
            color: color,
            all: 8,
            child: Icon(
              Icons.edit,
              size: 20,
              color: Colors.white,
            )),
      );

  Widget buildCircle(
          {required Color color, required double all, required Widget child}) =>
      ClipOval(
          child: Container(
        color: color,
        child: child,
        padding: EdgeInsets.all(all),
      ));
}
