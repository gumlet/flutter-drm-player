// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';

import 'messages.dart';
import 'video_player_platform_interface.dart';

/// An implementation of [VideoPlayerPlatform] that uses method channels.
///
/// This is the default implementation, for compatibility with existing
/// third-party implementations. It is not used by other implementations in
/// this repository.
class MethodChannelVideoPlayer extends VideoPlayerPlatform {
  final VideoPlayerApi _api = VideoPlayerApi();

  @override
  Future<int?> initPlayer(String url) async {
    final TextureMessage response = await _api.initPlayer(InitPlayerMessage()..url = url);
    return response.textureId;
  }

  @override
  Widget buildView(int textureId) {
    return Texture(textureId: textureId);
  }
}
