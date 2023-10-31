import 'dart:async';
import 'dart:io';

import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:video_compress/video_compress.dart';

abstract class DSFFmpegService {
  static Future<bool> formatVideo({
    required final String input,
    required final String output,
  }) async {
    var outputVideo = File(output);

    if (input != output) {
      final inputExtension = input.substring(
        input.lastIndexOf('.') + 1,
      );

      final outputExtension = output.substring(
        output.lastIndexOf('.') + 1,
      );

      var inputVideo = File(input);

      if (inputExtension != outputExtension) {
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
