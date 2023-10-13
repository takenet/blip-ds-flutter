import 'dart:io';

import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:get/get.dart';

import '../../models/ds_toast_props.model.dart';
import '../../services/ds_file.service.dart';
import '../../services/ds_toast.service.dart';
import '../../utils/ds_directory_formatter.util.dart';
import '../../widgets/chat/video/ds_video_error.dialog.dart';

class DSVideoMessageBubbleController {
  final String fileName;
  final String url;
  final int mediaSize;
  final Map<String, String?>? httpHeaders;
  final String type;

  DSVideoMessageBubbleController({
    required this.fileName,
    required this.url,
    required this.mediaSize,
    required this.type,
    this.httpHeaders,
  }) {
    getVideoAndSetThumbnail();
  }

  final isDownloading = RxBool(false);
  final thumbnail = RxString('');
  final hasError = RxBool(false);
  final loadingThumbnail = RxBool(true);

  String size() {
    return mediaSize > 0
        ? FileSize.getSize(
            mediaSize,
            precision: PrecisionValue.One,
          )
        // TODO: translate
        : 'Download';
  }

  Future<void> getVideoAndSetThumbnail() async {
    loadingThumbnail.value = true;
    final fullPath = await DSDirectoryFormatter.getPath(
      type: type,
      fileName: fileName,
    );
    final file = File(fullPath);
    if (await file.exists()) {
      await _generateThumbnail(file.path);
    }
    loadingThumbnail.value = false;
  }

  Future<String> getFullThumbnailPath() async {
    final mediaPath = await DSDirectoryFormatter.getPath(
      type: 'image/png',
      fileName: '$fileName-thumbnail',
    );
    return mediaPath;
  }

  Future<void> downloadVideo() async {
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

        final session = await FFmpegKit.execute(
            '-hide_banner -y -i "$inputFilePath" "${outputFile.path}"');

        File(inputFilePath!).delete();

        final returnCode = await session.getReturnCode();

        if (!ReturnCode.isSuccess(returnCode)) {
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

    await FFmpegKit.execute(
      '-hide_banner -y -i "$path" -vframes 1 "$thumbnailPath"',
    );

    thumbnail.value = thumbnailPath;
  }
}
