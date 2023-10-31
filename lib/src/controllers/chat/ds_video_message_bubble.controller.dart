import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:get/get.dart';

import '../../models/ds_toast_props.model.dart';
import '../../services/ds_ffmpeg.service.dart';
import '../../services/ds_file.service.dart';
import '../../services/ds_toast.service.dart';
import '../../utils/ds_directory_formatter.util.dart';

class DSVideoMessageBubbleController {
  final String url;
  final int mediaSize;
  final Map<String, String?>? httpHeaders;
  final String type;
  final maximumProgress = RxInt(0);
  final downloadProgress = RxInt(0);

  DSVideoMessageBubbleController({
    required this.url,
    required this.mediaSize,
    required this.type,
    this.httpHeaders,
  }) {
    getStoredVideo();
  }

  final isDownloading = RxBool(false);
  final thumbnail = RxString('');
  final hasError = RxBool(false);
  final isLoadingThumbnail = RxBool(false);

  String size() {
    return mediaSize > 0
        ? FileSize.getSize(
            mediaSize,
            precision: PrecisionValue.One,
          )
        // TODO: translate
        : 'Download';
  }

  Future<void> getStoredVideo() async {
    try {
      isLoadingThumbnail.value = true;
      final fileName = md5.convert(utf8.encode(Uri.parse(url).path)).toString();

      final fullPath = await DSDirectoryFormatter.getCachePath(
        type: type,
        filename: fileName,
      );

      final fullThumbnailPath = await DSDirectoryFormatter.getCachePath(
        type: 'image/png',
        filename: '$fileName-thumbnail',
      );

      final file = File(fullPath);
      final thumbnailfile = File(fullThumbnailPath);

      if (thumbnailfile.existsSync()) {
        thumbnail.value = thumbnailfile.path;
      } else if (file.existsSync() && thumbnail.value.isEmpty) {
        await _generateThumbnail(file.path);
      }
    } finally {
      isLoadingThumbnail.value = false;
    }
  }

  Future<String> getFullThumbnailPath() async {
    final fileName = md5.convert(utf8.encode(Uri.parse(url).path)).toString();

    return DSDirectoryFormatter.getCachePath(
      type: 'image/png',
      filename: '$fileName-thumbnail',
    );
  }

  Future<void> downloadVideo() async {
    isDownloading.value = true;

    try {
      final cachePath = await DSDirectoryFormatter.getCachePath(
        type: 'video/mp4',
        filename: md5.convert(utf8.encode(Uri.parse(url).path)).toString(),
      );

      final outputFile = File(cachePath);

      if (!outputFile.existsSync()) {
        final inputFilePath = await DSFileService.download(
          url: url,
          onReceiveProgress: (current, max) {
            downloadProgress.value = current;
            maximumProgress.value = max;
          },
          httpHeaders: httpHeaders,
        );

        final isSuccess = await DSFFmpegService.formatVideo(
          input: inputFilePath!,
          output: cachePath,
        );

        hasError.value = !isSuccess;
      }

      _generateThumbnail(outputFile.path);
    } catch (_) {
      hasError.value = true;

      // TODO: translate
      DSToastService.error(
        DSToastProps(
          title: 'Erro ao baixar vídeo',
          message: 'Ops! Houve um erro ao baixar o vídeo para reprodução.',
        ),
      );
    } finally {
      isDownloading.value = false;
    }
  }

  Future<void> _generateThumbnail(String path) async {
    final thumbnailPath = await getFullThumbnailPath();

    await DSFFmpegService.getVideoThumbnail(
      input: path,
      output: thumbnailPath,
    );

    thumbnail.value = thumbnailPath;
  }

  String getDownloadProgress() {
    String getSize(int value) => FileSize.getSize(
          value,
          precision: PrecisionValue.One,
        );

    return '${getSize(downloadProgress.value)} / ${getSize(maximumProgress.value)}';
  }
}
