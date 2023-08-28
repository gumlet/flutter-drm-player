import 'dart:async';
import 'dart:html';

import 'package:gumlet_video_player_platform_interface/video_player_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/shims/dart_ui.dart' as ui;

/// The web implementation of [VideoPlayerPlatform].
///
/// This class implements the `package:video_player` functionality for the web.
class VideoPlayerPlugin extends VideoPlayerPlatform {
  /// Registers this class as the default instance of [VideoPlayerPlatform].
  static void registerWith(Registrar registrar) {
    VideoPlayerPlatform.instance = VideoPlayerPlugin();
  }

  int _textureCounter = 1;

  @override
  Future<int> initPlayer(String url) async {
    final int textureId = _textureCounter++;

    ui.platformViewRegistry.registerViewFactory(
        'gumlet-web-player-$textureId',
            (int viewId) => IFrameElement()
          ..src = url
          ..style.border = 'none');

    return textureId;
  }

  @override
  Widget buildView(int textureId) {
    return HtmlElementView(viewType: 'gumlet-web-player-$textureId');
  }
}
