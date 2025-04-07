import 'dart:async';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path_utils;
import 'package:video_compress/video_compress.dart';

abstract class DSMediaFormatService {
  static Future<bool> formatImage({
    required final String input,
    required final String output,
  }) async {
    try {
      final result = await FlutterImageCompress.compressAndGetFile(
        input,
        output,
        quality: 80,
      );

      return File(result!.path).exists();
    } catch (_) {
      return false;
    }
  }

  static Future<bool> formatVideo({
    required final String input,
    required final String output,
  }) async {
    var outputVideo = File(output);

    if (input != output) {
      final inputHasExtension = path_utils.extension(input).isNotEmpty;
      final outputHasExtension = path_utils.extension(output).isNotEmpty;

      final lastInputDotIndex = inputHasExtension ? input.lastIndexOf('.') : -1;

      final lastOutputDotIndex =
          outputHasExtension ? output.lastIndexOf('.') : -1;

      final inputExtension = input.substring(
        lastInputDotIndex + 1,
      );

      final outputExtension = output.substring(
        lastOutputDotIndex + 1,
      );

      var inputVideo = File(input);

      if (lastInputDotIndex >= 0 &&
          lastOutputDotIndex >= 0 &&
          inputExtension.isNotEmpty &&
          inputExtension != outputExtension) {
        final temp = await VideoCompress.compressVideo(
          input,
          quality: VideoQuality.HighestQuality,
          frameRate: 60,
        );

        if (temp?.file != null) {
          temp!.file!.copySync(output);
          temp.file!.deleteSync();
        }
      } else {
        inputVideo.copySync(output);
      }

      inputVideo.deleteSync();
    }

    return outputVideo.exists();
  }

  static Future<bool> getVideoThumbnail({
    required final String input,
    required final String output,
  }) async {
    final temp = await VideoCompress.getFileThumbnail(input);

    final thumbnail = temp.copySync(output);
    temp.deleteSync();

    return thumbnail.exists();
  }
}
