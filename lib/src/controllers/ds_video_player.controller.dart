import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';

import 'package:blip_ds/src/services/ds_dialog.service.dart';
import 'package:blip_ds/src/services/ds_file.service.dart';
import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/widgets/buttons/ds_primary_button.widget.dart';
import 'package:blip_ds/src/widgets/buttons/ds_secondary_button.widget.dart';

class DSVideoPlayerController extends GetxController {
  /// Video controller. responsible for managing the state of the video widget, and all
  /// the management of video controls.
  DSVideoPlayerController({
    required this.url,
    required this.uniqueId,
  });

  // External URL containing the video to be played
  final String url;

  final String uniqueId;

  VideoPlayerController? _videoPlayerController;
  ChewieController? chewieController;
  int? bufferDelay;

  @override
  bool isClosed = false;

  RxBool appBarVisible = true.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    await initializePlayer();

    super.onInit();
  }

  @override
  void onClose() {
    _videoPlayerController?.dispose();
    chewieController?.dispose();
    _videoPlayerController?.removeListener(_showAppBar);
    isClosed = true;
    super.onClose();
  }

  Future<void> initializePlayer() async {
    try {
      final fileName = url.substring(url.lastIndexOf('/')).substring(1);

      final temporaryPath = (await getTemporaryDirectory()).path;
      final outputFile = File("$temporaryPath/VIDEO-$uniqueId.mp4");

      if (await outputFile.exists()) {
        _videoPlayerController =
            VideoPlayerController.file(File(outputFile.path));
      } else {
        final inputFilePath = await DSFileService.download(url, fileName);

        final session = await FFmpegKit.execute(
            '-hide_banner -y -i $inputFilePath ${outputFile.path}');

        final returnCode = await session.getReturnCode();

        if (ReturnCode.isSuccess(returnCode)) {
          _videoPlayerController =
              VideoPlayerController.file(File(outputFile.path));
        } else {
          _screenError(fileName);
        }
      }

      // //
      // var fileName2 = await VideoThumbnail.thumbnailFile(
      //   video: outputFile.path,
      //   thumbnailPath: (await getTemporaryDirectory()).path,
      //   imageFormat: ImageFormat.JPEG,
      //   maxHeight:
      //       64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      //   quality: 75,
      // );
      // fileName2 = fileName2;
      // await DSFileService.open('fileName.jpeg', fileName2!);
      // //

      await _videoPlayerController!.initialize();
      _createChewieController();

      _videoPlayerController?.addListener(_showAppBar);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  void _screenError(final fileName) {
    Get.back();
    Get.delete<DSVideoPlayerController>();
    final dialog = _dialogErrorFile(fileName);
    dialog.showError();
  }

  DSDialogService _dialogErrorFile(final String fileName) {
    return DSDialogService(
      title: 'Erro ao reproduzir o vídeo',
      text:
          'Encontramos um erro ao reproduzir o vídeo. Você deseja tentar abrir o vídeo externamente?',
      primaryButton: DSPrimaryButton(
        onPressed: () {
          Get.back();
          DSFileService.open(fileName, url);
        },
        label: 'Sim',
      ),
      secondaryButton: DSSecondaryButton(
        onPressed: (() => Navigator.of(Get.context!).pop()),
        label: 'Não',
      ),
      context: Get.context!,
    );
  }

  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: true,
      allowPlaybackSpeedChanging: true,
      allowMuting: false,
      allowFullScreen: false,
      playbackSpeeds: const [0.5, 1.0, 1.5, 2.0],
      fullScreenByDefault: false,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      materialProgressColors: ChewieProgressColors(
        playedColor: DSColors.neutralDarkCity,
        handleColor: DSColors.neutralLightSnow,
        backgroundColor: DSColors.neutralDarkCity,
        bufferedColor: DSColors.neutralMediumSilver,
      ),
      autoInitialize: true,
    );
  }

  Future<void> _showAppBar() async {
    appBarVisible.value = !(chewieController!.isPlaying);
  }
}
