import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path_utils;

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

    final fullPath = await DSDirectoryFormatter.getPath(
      type: mediaType!,
      fileName: md5.convert(utf8.encode(uri.path)).toString(),
    );

    if (await File(fullPath).exists()) {
      localPath.value = fullPath;
      return;
    }

    try {
      final savedFilePath = await DSFileService.download(
        url,
        path_utils.basename(fullPath),
        path: path_utils.dirname(fullPath),
        onReceiveProgress: _onReceiveProgress,
        httpHeaders: shouldAuthenticate ? DSAuthService.httpHeaders : null,
      );

      localPath.value = savedFilePath;
    } catch (_) {
      localPath.value = url;
    }
  }
}
