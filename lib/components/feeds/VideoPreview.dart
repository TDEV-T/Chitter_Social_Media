import 'dart:io';

import 'package:chitter/components/animation/LoadingIndicator.dart';
import 'package:chitter/components/animation/VideoPlayback.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPreviewContent extends StatefulWidget {
  const VideoPreviewContent({Key? key, required this.filePath})
      : super(key: key);

  final String? filePath;

  @override
  State<VideoPreviewContent> createState() => _VideoPreviewContentState();
}

class _VideoPreviewContentState extends State<VideoPreviewContent> {
  VideoPlayerController? _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.filePath != null) {
      _controller = VideoPlayerController.networkUrl(
          Uri.parse(imageAPI + widget.filePath!.toString()));
      Utility().logger.i(videoAPI + widget.filePath!.toString());
    } else {
      _controller = VideoPlayerController.asset('assets/images/video.mp4');
    }
    _controller!.addListener(() {
      setState(() {});
    });
    _controller!.setLooping(true);
    _controller!.initialize().then((_) => setState(() {}));
    _controller!.play();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('tdev'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction == 0 && _controller != null) {
          _controller!.pause();
        }
      },
      child: Stack(
        children: <Widget>[
          _controller!.value.isInitialized
              ? GestureDetector(
            onTap: (){
              setState(() {
                if(_controller!.value.isPlaying){
                  _controller!.pause();
                }else{
                  _controller!.play();
                }
              });
            },
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      ),
                      VideoPlaybackOverlay(controller: _controller)
                    ],
                  )
                )
              : LoadingIndicator(isLoading: _isLoading)
        ],
      ),
    );
  }
}
