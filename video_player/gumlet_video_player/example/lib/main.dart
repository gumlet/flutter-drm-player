import 'package:gumlet_video_player/video_player.dart';
import 'package:flutter/material.dart';

void main() => runApp(const VideoApp());

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController(
        url: "YOUR_EMBED_URL")
        ..initialize().then((_) {
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        appBar: AppBar(title: Text("Gumlet Example"),),
        body: Center(
          child:
            VideoPlayer(controller: videoPlayerController),
        ),
      ),
    );
  }
}
