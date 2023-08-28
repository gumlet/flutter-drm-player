import 'package:gumlet_video_player_platform_interface/video_player_platform_interface.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

VideoPlayerPlatform? _lastVideoPlayerPlatform;

VideoPlayerPlatform get _videoPlayerPlatform {
  final VideoPlayerPlatform currentInstance = VideoPlayerPlatform.instance;
  if (_lastVideoPlayerPlatform != currentInstance) {
    _lastVideoPlayerPlatform = currentInstance;
  }
  return currentInstance;
}

class VideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  const VideoPlayer({Key? key, required this.controller}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? widget.controller.textureId == VideoPlayerController.kUninitializedTextureId
          ? Container()
          : _videoPlayerPlatform.buildView(widget.controller.textureId)
        : InAppWebView(
            initialUrlRequest: URLRequest(
                url: Uri.dataFromString('<script type="application/ld+json">'
                    '{"@context":"https://schema.org","@type":"VideoObject",'
                    '"embedUrl":${widget.controller.url}</script>'
                    '<iframe loading="lazy" title="Gumlet video player" src=${widget.controller.url} '
                    'style="border:none; position: absolute; top:0; left:0; height: 100%; width: 100%;" allow="accelerometer; gyroscope; autoplay; '
                    'encrypted-media; picture-in-picture; fullscreen;" frameborder="0" allowfullscreen></iframe>',
                    mimeType: 'text/html'
                )
            ),
    );
  }
}


class VideoPlayerController {
  final String url;

  static const int kUninitializedTextureId = -1;
  int _textureId = kUninitializedTextureId;

  VideoPlayerController({required this.url});

  int get textureId => _textureId;

  Future<void> initialize() async {
    bool _validURL = Uri.parse(url).isAbsolute;
    if(!_validURL) {
      throw ArgumentError.value(
        url,
        'Invalid url.',
      );
    }
    if(kIsWeb) {
      _textureId = (await _videoPlayerPlatform.initPlayer(url)) ??
          kUninitializedTextureId;
    }
  }
}
