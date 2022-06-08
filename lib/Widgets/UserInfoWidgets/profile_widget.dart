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
      child: buildImage(),
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
}
