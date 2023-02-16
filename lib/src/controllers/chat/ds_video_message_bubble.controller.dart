import 'dart:io';

import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../services/ds_file.service.dart';
import '../../widgets/chat/video/ds_video_error.dialog.dart';

class DSVideoMessageBubbleController {
  final String uniqueId;
  final String url;
  final int mediaSize;

  DSVideoMessageBubbleController({
    required this.uniqueId,
    required this.url,
    required this.mediaSize,
  }) {
    setThumbnail();
  }

  final isDownloading = RxBool(false);
  final thumbnail = RxString('');
  final hasError = RxBool(false);

  String size() {
    return FileSize.getSize(
      mediaSize,
      precision: PrecisionValue.One,
    );
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

    final fileName = url.substring(url.lastIndexOf('/')).substring(1);

    final temporaryPath = (await getTemporaryDirectory()).path;
    final outputFile = File('$temporaryPath/VIDEO-$uniqueId.mp4');

    if (!await outputFile.exists()) {
      final inputFilePath = await DSFileService.download(url, fileName);

      final session = await FFmpegKit.execute(
          '-hide_banner -y -i $inputFilePath ${outputFile.path}');

      final returnCode = await session.getReturnCode();

      if (!ReturnCode.isSuccess(returnCode)) {
        hasError.value = true;
        await DSVideoErrorDialog.show(fileName, url);
      }
    }

    final thumbnailPath = await getFullThumbnailPath();
    final command =
        '-ss 00:00:3 -i ${outputFile.path} -frames:v 1 $thumbnailPath';

    await FFmpegKit.execute(command);

    thumbnail.value = thumbnailPath;
    isDownloading.value = false;
  }
}
