import 'dart:io';

import 'package:chitter/components/animation/VideoPlayback.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key, required this.filePath,required this.onPressed}) : super(key: key);


  final String? filePath;
  final VoidCallback onPressed;




  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();

}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.filePath != null) {
      _controller = VideoPlayerController.file(File(widget.filePath!));
    } else {
      // Fallback to a default asset if no file path is provided
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
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          child:Stack(
          children: <Widget>[
              AspectRatio(
               aspectRatio: _controller!.value.aspectRatio,
               child: VideoPlayer(_controller!),
             ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(top:5),
                decoration: BoxDecoration(color:Colors.white,shape: BoxShape.circle),
                child: IconButton(
                  iconSize: 20,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    widget.onPressed();
                  }
                ),
              ),
            ),
            VideoPlaybackOverlay(controller: _controller),
          ],
        ),)
            : const CircularProgressIndicator(),
      ],
    );
  }


}
