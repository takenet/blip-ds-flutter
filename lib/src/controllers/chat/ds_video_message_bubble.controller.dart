import 'dart:io';

import 'package:file_sizes/file_sizes.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/ds_toast_props.model.dart';
import '../../services/ds_ffmpeg.service.dart';
import '../../services/ds_file.service.dart';
import '../../services/ds_toast.service.dart';
import '../../widgets/chat/video/ds_video_error.dialog.dart';

class DSVideoMessageBubbleController {
  final String uniqueId;
  final String url;
  final int mediaSize;
  final Map<String, String?>? httpHeaders;

  DSVideoMessageBubbleController({
    required this.uniqueId,
    required this.url,
    required this.mediaSize,
    this.httpHeaders,
  }) {
    setThumbnail();
  }

  final isDownloading = RxBool(false);
  final thumbnail = RxString('');
  final hasError = RxBool(false);

  String size() {
    return mediaSize > 0
        ? FileSize.getSize(
            mediaSize,
            precision: PrecisionValue.One,
          )
        // TODO: translate
        : 'Download';
  }

  Future<void> setThumbnail() async {
    final thumbnailFile = File(await getFullThumbnailPath());
    if (await thumbnailFile.exists()) {
      thumbnail.value = thumbnailFile.path;
    }
  }

  Future<String> getFullThumbnailPath() async {
    final temporaryPath = (await getTemporaryDirectory()).path;
    return "$temporaryPath/VIDEO-Thumbnail-$uniqueId.png";
  }

  Future<void> downloadVideo() async {
    isDownloading.value = true;

    try {
      final path = Uri.parse(url).path;

      var fileName = path.substring(path.lastIndexOf('/')).substring(1);

      if (fileName.isEmpty) {
        fileName = DateTime.now().toIso8601String();
      }

      final temporaryPath = (await getTemporaryDirectory()).path;
      final outputFile = File('$temporaryPath/VIDEO-$uniqueId.mp4');

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

        if (!isSuccess) {
          hasError.value = true;
          await DSVideoErrorDialog.show(
            filename: fileName,
            url: url,
            httpHeaders: httpHeaders,
          );
        }
      }

      final thumbnailPath = await getFullThumbnailPath();

      await DSFFmpegService.getVideoThumbnail(
        input: outputFile.path,
        output: thumbnailPath,
      );

      thumbnail.value = thumbnailPath;
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
}
