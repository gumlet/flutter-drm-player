// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Autogenerated from Pigeon (v0.1.21), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, cast_nullable_to_non_nullable
// @dart = 2.12
import 'dart:async';

import 'package:flutter/services.dart';

class InitPlayerMessage {
  String? url;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['url'] = url;
    return pigeonMap;
  }

  static InitPlayerMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return InitPlayerMessage()..url = pigeonMap['url'] as String?;
  }
}

class TextureMessage {
  int? textureId;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    return pigeonMap;
  }

  static TextureMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return TextureMessage()..textureId = pigeonMap['textureId'] as int?;
  }
}

class VideoPlayerApi {

  Future<TextureMessage> initPlayer(InitPlayerMessage arg) async {
    final Object encoded = arg.encode();
    const BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.VideoPlayerApi.initPlayer', StandardMessageCodec());
    final Map<Object?, Object?>? replyMap =
        await channel.send(encoded) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          replyMap['error'] as Map<Object?, Object?>;
      throw PlatformException(
        code: error['code'] as String,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return TextureMessage.decode(replyMap['result']!);
    }
  }
}
