import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlaybackOverlay extends StatelessWidget {
  const VideoPlaybackOverlay({Key? key, required this.controller})
      : super(key: key);

  final VideoPlayerController? controller;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
          alignment: Alignment.center,
          child: Icon(
              controller!.value.isPlaying ? null : Icons.pause,
              size: 50,
              color: Colors.white)),
    );
  }
}
