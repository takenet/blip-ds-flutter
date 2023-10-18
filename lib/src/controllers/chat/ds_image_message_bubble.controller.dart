import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/utils/ds_directory_formatter.util.dart';
import 'package:crypto/crypto.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:get/get.dart';

class DSImageMessageBubbleController extends GetxController {
  final maximumProgress = RxInt(0);
  final downloadProgress = RxInt(0);
  final localPath = RxnString();
  final isDownloading = RxBool(true);

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
      final path = await DSFileService.download(
        url,
        fullPath.substring(
          fullPath.lastIndexOf('/') + 1,
        ),
        onReceiveProgress: _onReceiveProgress,
        httpHeaders: shouldAuthenticate ? DSAuthService.httpHeaders : null,
      );

      isDownloading.value = false;

      final success = await _compressImage(
        input: path!,
        output: fullPath,
      );

      if (success) {
        if (await File(path).exists()) {
          await File(path).delete();
        }
        localPath.value = fullPath;
      } else {
        localPath.value = url;
      }
    } catch (_) {
      localPath.value = url;
      isDownloading.value = false;
    }
  }

  Future<bool> _compressImage({
    required String input,
    required String output,
  }) async {
    final session = await FFmpegKit.execute(
        '-hide_banner -y -i "$input" -vf scale=-2:720 "$output"');

    final returnCode = await session.getReturnCode();

    return ReturnCode.isSuccess(returnCode);
  }
}
