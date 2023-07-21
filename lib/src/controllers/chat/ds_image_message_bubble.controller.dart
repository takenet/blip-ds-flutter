import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/ds_auth.service.dart';

class DSImageMessageBubbleController extends GetxController {
  Future<ImageInfo> getImageInfo({
    required final String url,
    final bool shouldAuthenticate = false,
  }) async {
    final Image img = Image.network(
      url,
      headers: shouldAuthenticate ? DSAuthService.httpHeaders : null,
    );

    final completer = Completer<ImageInfo>();

    final ImageStream imageStream =
        img.image.resolve(const ImageConfiguration());

    imageStream.addListener(
      ImageStreamListener(
        (ImageInfo i, bool _) {
          completer.complete(i);
        },
        onError: (exception, stackTrace) => completer.completeError(exception),
      ),
    );

    return completer.future;
  }
}
