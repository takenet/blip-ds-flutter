import 'dart:async';
import 'dart:io';

import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
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
    } catch (e) {
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

  static Future<bool> transcodeAudio({
    required final String input,
    required final String output,
  }) =>
      _executeCommand(
        command: '-i "$input" $_transcodeAudioArgs "$output"',
      );

  static Future<bool> mergeAudio({
    required final String firstInput,
    required final String secondInput,
    required final String output,
  }) =>
      _executeCommand(
        command:
            '-i "$firstInput" -i "$secondInput" $_mergeAudioArgs "$output"',
      );

  static Future<bool> _executeCommand({
    required final String command,
  }) async {
    final session = await FFmpegKit.execute(
      '$_defaultArgs $command',
    );

    return ReturnCode.isSuccess(
      await session.getReturnCode(),
    );
  }

  static String get _defaultArgs {
    const hideInfoBanner = '-hide_banner';
    const answerYes = '-y';

    return '$hideInfoBanner $answerYes';
  }

  static String get _transcodeAudioArgs {
    const codec = '-c:a aac';

    return codec;
  }

  static String get _mergeAudioArgs {
    const filter = '-filter_complex';
    const firstInput = '[0:0]';
    const secondInput = '[1:0]';
    const audioConcat = 'concat=n=2:v=0:a=1';

    return '$filter "$firstInput$secondInput$audioConcat"';
  }
}
