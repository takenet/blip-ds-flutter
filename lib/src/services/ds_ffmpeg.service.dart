import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';

import '../models/ds_media_info.model.dart';

abstract class DSFFmpegService {
  static const _maxSize = 10485760; // 10 MB
  static const _targetResolution = 480; // 480p

  static Future<bool> formatVideo({
    required final String input,
    required final String output,
    final bool shouldCompress = true,
  }) async {
    final args = shouldCompress
        ? await _getCompressVideoArgs(
            path: input,
          )
        : null;

    final command =
        '-hwaccel auto -i "$input" ${args != null ? '$args ' : ''}"$output"';

    return _executeCommand(
      command: command,
    );
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

  static Future<DSMediaInfo> getMediaInfo({
    required final String path,
  }) async {
    int? width;
    int? height;
    int? size;
    int? rotation;

    final session = await FFprobeKit.getMediaInformation(path);
    final info = session.getMediaInformation();

    if (info != null) {
      size = int.tryParse(info.getSize() ?? '') ?? 0;

      final streams = info.getStreams();

      if (streams.isNotEmpty) {
        final properties = streams.first.getAllProperties();
        final List? sideData = properties?['side_data_list'];

        width = properties?['width'];
        height = properties?['height'];
        rotation = sideData?.first['rotation'];
      }
    }

    final isFlipped = rotation != null && rotation != 0;

    return DSMediaInfo(
      width: isFlipped ? height : width,
      height: isFlipped ? width : height,
      size: size,
    );
  }

  static Future<String?> _getCompressVideoArgs({
    required final String path,
  }) async {
    final info = await getMediaInfo(
      path: path,
    );

    if (info.hasDimensions) {
      final isOversized =
          info.size == null || (info.size != null && info.size! > _maxSize);

      final isOverdimensioned =
          info.width! > _targetResolution && info.height! > _targetResolution;

      if (isOversized && isOverdimensioned) {
        final compressedResolution =
            (info.aspectRatio! * _targetResolution).ceil();

        final compressedWidth =
            info.isWidescreen ? compressedResolution : _targetResolution;

        final compressedHeight =
            info.isWidescreen ? _targetResolution : compressedResolution;

        return _compressVideoArgs(
          width: compressedWidth,
          height: compressedHeight,
        );
      }
    }

    return null;
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
    final resolution = '-s ${width}x$height';
    const pixelFormat = '-pix_fmt yuv420p';
    const codec = '-c:v libx264';
    const preset = '-preset veryfast';
    const quality = '-crf 23';
    const audio = '-c:a aac';

    return '$resolution $pixelFormat $codec $preset $quality $audio';
  }
}
