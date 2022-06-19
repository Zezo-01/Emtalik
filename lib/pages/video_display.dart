import 'package:emtalik/Widgets/network_video_player.dart';
import 'package:emtalik/Widgets/video_player_widget.dart';
import 'package:flutter/material.dart';

class DisplayVideo extends StatelessWidget {
  DisplayVideo({Key? key, required this.link}) : super(key: key);
  String link;
  @override
  Widget build(BuildContext context) {
    return CustomVideoPlayer(link: link);
  }
}
