import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DSImageMessageBubbleController extends GetxController {
  final error = RxBool(false);
  final appBarVisible = RxBool(false);

  void setError() {
    error.value = true;
  }

  void showAppBar() {
    appBarVisible.value
        ? appBarVisible.value = false
        : appBarVisible.value = true;
  }

  Future<ImageInfo> getImageInfo(final String url) async {
    final Image img = Image.network(url);

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
