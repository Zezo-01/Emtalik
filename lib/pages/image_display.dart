import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  ImageDisplay({Key? key, required this.link}) : super(key: key);
  String link;

  @override
  Widget build(BuildContext context) {
    return Image.network(link);
  }
}
