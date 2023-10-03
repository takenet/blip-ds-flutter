import 'dart:io';

import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:get/get.dart';

import '../../enums/ds_file_type.enum.dart';
import '../../models/ds_toast_props.model.dart';
import '../../services/ds_file.service.dart';
import '../../services/ds_toast.service.dart';
import '../../utils/ds_directory_formatter.util.dart';
import '../../widgets/chat/video/ds_video_error.dialog.dart';

class DSVideoMessageBubbleController {
  final String uniqueId;
  final String url;
  final int mediaSize;
  final Map<String, String?>? httpHeaders;
  final String fileName;

  DSVideoMessageBubbleController({
    required this.uniqueId,
    required this.url,
    required this.mediaSize,
    required this.fileName,
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
    } else {
      getVideoAndSetThumbnail();
    }
  }

  Future<void> getVideoAndSetThumbnail() async {
    final mediaPath =
        await DSDirectoryFormatter.getPath(type: DSFileType.videos);
    final file = File('$mediaPath/$fileName');
    if (await file.exists()) {
      _generateThumbnail(file.path);
    }
  }

  Future<String> getFullThumbnailPath() async {
    final mediaPath =
        await DSDirectoryFormatter.getPath(type: DSFileType.videos);
    return "$mediaPath/VIDEO-Thumbnail-$uniqueId.png";
  }

  Future<void> downloadVideo() async {
    isDownloading.value = true;

    try {
      final path = Uri.parse(url).path;

      var fileName = path.substring(path.lastIndexOf('/')).substring(1);

      if (fileName.isEmpty) {
        fileName = DateTime.now().toIso8601String();
      }

      final mediaPath =
          await DSDirectoryFormatter.getPath(type: DSFileType.videos);
      final outputFile = File('$mediaPath/VIDEO-$uniqueId.mp4');

      if (!await outputFile.exists()) {
        final inputFilePath = await DSFileService.download(
          url,
          fileName,
          path: mediaPath,
          httpHeaders: httpHeaders,
        );

        final session = await FFmpegKit.execute(
            '-hide_banner -y -i "$inputFilePath" "${outputFile.path}"');

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
