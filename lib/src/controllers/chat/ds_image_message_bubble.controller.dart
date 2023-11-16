import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';

import '../../services/ds_auth.service.dart';
import '../../services/ds_file.service.dart';
import '../../utils/ds_directory_formatter.util.dart';

class DSImageMessageBubbleController extends GetxController {
  final maximumProgress = RxInt(0);
  final downloadProgress = RxInt(0);
  final localPath = RxnString();

  final String url;
  final String? mediaType;
  final bool shouldAuthenticate;

  DSImageMessageBubbleController(
    this.url, {
    this.mediaType,
    this.shouldAuthenticate = false,
  }) {
    _downloadImage();
  }

  void _onReceiveProgress(final int currentProgress, final int maxProgres) {
    downloadProgress.value = currentProgress;
    maximumProgress.value = maxProgres;
  }

  Future<void> _downloadImage() async {
    if (mediaType == null || !url.startsWith('http')) {
      localPath.value = url;
      return;
    }

    final uri = Uri.parse(url);

    final cachePath = await DSDirectoryFormatter.getCachePath(
      type: mediaType!,
      filename: md5.convert(utf8.encode(uri.path)).toString(),
    );

    if (File(cachePath).existsSync()) {
      localPath.value = cachePath;
      return;
    }

    try {
      final savedFilePath = await DSFileService.download(
        url: url,
        path: cachePath,
        onReceiveProgress: _onReceiveProgress,
        httpHeaders: shouldAuthenticate ? DSAuthService.httpHeaders : null,
      );

      localPath.value = savedFilePath;
    } catch (_) {
      localPath.value = url;
    }
  }
}
