import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path_utils;

import '../../models/ds_toast_props.model.dart';
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
          path_utils.basename(fullPath),
          path: path_utils.dirname(fullPath),
          onReceiveProgress: (current, max) {
            downloadProgress.value = current;
            maximumProgress.value = max;
          },
          httpHeaders: httpHeaders,
        );

        _generateThumbnail(inputFilePath!);
      }
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

    await FFmpegKit.execute(
      '-hide_banner -y -i "$path" -vframes 1 "$thumbnailPath"',
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
