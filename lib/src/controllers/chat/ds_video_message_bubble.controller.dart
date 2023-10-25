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
import '../../widgets/chat/video/ds_video_error.dialog.dart';

class DSVideoMessageBubbleController {
  final String url;
  final int mediaSize;
  final Map<String, String?>? httpHeaders;
  final String type;

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
      final fullPath = await DSDirectoryFormatter.getPath(
        type: type,
        fileName: fileName,
      );
      final fullThumbnailPath = await DSDirectoryFormatter.getPath(
        type: 'image/png',
        fileName: '$fileName-thumbnail',
      );
      final file = File(fullPath);
      final thumbnailfile = File(fullThumbnailPath);
      if (await thumbnailfile.exists()) {
        thumbnail.value = thumbnailfile.path;
      } else if (await file.exists() && thumbnail.value.isEmpty) {
        await _generateThumbnail(file.path);
      }
    } finally {
      isLoadingThumbnail.value = false;
    }
  }

  Future<String> getFullThumbnailPath() async {
    final fileName = md5.convert(utf8.encode(Uri.parse(url).path)).toString();
    final mediaPath = await DSDirectoryFormatter.getPath(
      type: 'image/png',
      fileName: '$fileName-thumbnail',
    );
    return mediaPath;
  }

  Future<void> downloadVideo() async {
    final fileName = md5.convert(utf8.encode(Uri.parse(url).path)).toString();
    isDownloading.value = true;

    try {
      final fullPath = await DSDirectoryFormatter.getPath(
        type: 'video/mp4',
        fileName: fileName,
      );
      final outputFile = File(fullPath);

      if (!await outputFile.exists()) {
        final inputFilePath = await DSFileService.download(
          url,
          fileName,
          httpHeaders: httpHeaders,
        );

        final isSuccess = await DSFFmpegService.formatVideo(
          input: inputFilePath!,
          output: outputFile.path,
        );

        File(inputFilePath).delete();

        if (!isSuccess) {
          hasError.value = true;
          await DSVideoErrorDialog.show(
            filename: fileName,
            url: url,
            httpHeaders: httpHeaders,
          );
        }
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
}
