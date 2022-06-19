import 'package:emtalik/Widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  CustomVideoPlayer({Key? key, required this.link}) : super(key: key);
  String link;
  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState(link: link);
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  _CustomVideoPlayerState({required this.link});
  late VideoPlayerController controller;
  String link;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(link)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;
    return Stack(
      alignment: Alignment.center,
      children: [
        VideoPlayerWidget(controller: controller),
      ],
    );
  }
}
