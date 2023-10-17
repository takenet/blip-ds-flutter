import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';

import '../models/ds_media_info.model.dart';

abstract class DSFFmpegService {
  static const _maxSize = 10485760; // 10 MB
  static const _targetResolution = 720; // 720p

  static Future<bool> formatVideo({
    required final String input,
    required final String output,
    final bool shouldCompress = true,
  }) async {
    final info = await _getMediaInfo(
      path: input,
    );

    if (info.hasDimensions) {
      final isOversized =
          info.size == null || (info.size != null && info.size! > _maxSize);

      final isOverdimensioned =
          info.width! > _targetResolution && info.height! > _targetResolution;

      final shouldCompress = isOversized && isOverdimensioned;

      if (shouldCompress) {
        final compressedResolution =
            (info.aspectRatio! * _targetResolution).ceil();

        final compressedWidth =
            info.isWidescreen ? compressedResolution : _targetResolution;

        final compressedHeight =
            info.isWidescreen ? _targetResolution : compressedResolution;

        final args = _compressVideoArgs(
          width: compressedWidth,
          height: compressedHeight,
        );

        return _executeCommand(
          command: '-i "$input" ${shouldCompress ? '$args ' : ''}"$output"',
        );
      }
    }

    return true;
  }

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

  static Future<DSMediaInfo> _getMediaInfo({
    required final String path,
  }) async {
    int? width;
    int? height;
    int? size;

    final session = await FFprobeKit.getMediaInformation(path);
    final info = session.getMediaInformation();

    if (info != null) {
      size = int.tryParse(info.getSize() ?? '') ?? 0;

      final streams = info.getStreams();

      if (streams.isNotEmpty) {
        width = streams.first.getWidth();
        height = streams.first.getHeight();
      }
    }

    return DSMediaInfo(
      width: width,
      height: height,
      size: size,
    );
  }

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

  static String _compressVideoArgs({
    required final int width,
    required final int height,
  }) {
    final resolution = '-vf scale=${width}x$height';
    const codec = '-c:v libx264';
    const preset = '-preset faster';
    const quality = '-crf 23';
    const audio = '-c:a copy';

    return '$resolution $codec $preset $quality $audio';
  }
}
