import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';

abstract class DSFFmpegService {
  static Future<bool> formatVideo({
    required final String input,
    required final String output,
    final bool shouldCompress = true,
  }) =>
      _executeCommand(
        command:
            '-i "$input" ${shouldCompress ? '$_compressVideoArgs ' : ''}"$output"',
      );

  static Future<bool> getVideoThumbnail({
    required final String input,
    required final String output,
  }) =>
      _executeCommand(
        command: '-i "$input" $_thumbnailArgs "$output"',
      );

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

  static String get _compressVideoArgs {
    const resolution = '-vf scale=-2:480';
    const codec = '-c:v libx264';
    const preset = '-preset veryfast';
    const quality = '-crf 18';
    const audio = '-c:a copy';

    return '$resolution $codec $preset $quality $audio';
  }

  static String get _thumbnailArgs {
    const getOneFrame = '-vframes 1';

    return getOneFrame;
  }

  static String get _transcodeAudioArgs {
    const codec = '-c:a libmp3lame';
    const quality = '-qscale:a 2';

    return '$codec $quality';
  }

  static String get _mergeAudioArgs {
    const filter = '-filter_complex';
    const firstInput = '[0:0]';
    const secondInput = '[1:0]';
    const audioConcat = 'concat=n=2:v=0:a=1';

    return '$filter "$firstInput$secondInput$audioConcat"';
  }
}
