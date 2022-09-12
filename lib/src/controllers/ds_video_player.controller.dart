import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:blip_ds/src/services/ds_dialog.service.dart';
import 'package:blip_ds/src/services/ds_file.service.dart';
import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/widgets/buttons/ds_primary_button.widget.dart';
import 'package:blip_ds/src/widgets/buttons/ds_secondary_button.widget.dart';

class DSVideoPlayerController extends GetxController {
  ///Video controller. responsible for managing the state of the video widget, and all
  ///the management of video controls.
  DSVideoPlayerController({
    required this.url,
  });

  // External URL containing the video to be played
  final String url;

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
    /// Download the video to be played
    final type = url.substring(url.lastIndexOf('.'));
    final fileName = '${DateTime.now().millisecondsSinceEpoch}$type';
    final result = await DsFileService.download(url, fileName);

    if (result?.isNotEmpty ?? false) {
      _videoPlayerController = VideoPlayerController.file(File(result!));

      final c = Completer<void>();

      await Future<void>(() async {
        _videoPlayerController!
            .initialize()
            .then((_) => c.complete())
            .catchError((e) {
          _screenError(fileName);
        });

        return c.future;
      });

      if (!c.isCompleted) {
        _screenError(fileName);
      } else {
        if (!isClosed) _createChewieController();
      }

      _videoPlayerController?.addListener(_showAppBar);

      isLoading.value = false;
    }
  }

  _screenError(fileName) {
    Navigator.of(Get.context!).pop();
    Get.delete<DSVideoPlayerController>();
    final dialog = _dialogErrorFile(fileName);
    dialog.error();
  }

  DSDialogService _dialogErrorFile(String fileName) {
    return DSDialogService(
      title: 'Erro ao reproduzir o vídeo',
      text:
          'Encontramos um erro ao reproduzir o vídeo. Você deseja tentar abrir o vídeo externamente?',
      firstButton: DSPrimaryButton(
        onPressed: () {
          Navigator.of(Get.context!).pop();
          DsFileService.open(fileName, url);
        },
        label: 'Sim',
      ),
      secondButton: DSSecondaryButton(
        onPressed: (() => Navigator.of(Get.context!).pop()),
        label: 'Não, obrigado',
      ),
      context: Get.context!,
    );
  }

  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: true,
      zoomAndPan: true,
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
      placeholder: Container(
        color: Colors.black,
      ),
      autoInitialize: true,
      maxScale: 2.5,
    );
  }

  Future<void> _showAppBar() async {
    appBarVisible.value = !(chewieController!.isPlaying);
  }
}
