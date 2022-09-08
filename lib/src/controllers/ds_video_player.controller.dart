import 'dart:async';
import 'dart:io';
import 'package:blip_ds/src/services/ds_dialog.service.dart';
import 'package:blip_ds/src/services/ds_file.service.dart';
import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/widgets/buttons/ds_primary_button.widget.dart';
import 'package:blip_ds/src/widgets/buttons/ds_secondary_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class DSVideoPlayerController extends GetxController {
  DSVideoPlayerController({
    required this.url,
  });

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
    isClosed = true;
    super.onClose();
  }

  Future<void> initializePlayer() async {
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
      allowFullScreen: false,
      playbackSpeeds: const [2.0, 0.5, 1.0, 1.5, 2.0],
      fullScreenByDefault: false,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      materialProgressColors: ChewieProgressColors(
        playedColor: DSColors.neutralLightSnow,
        handleColor: DSColors.neutralLightSnow,
        backgroundColor: DSColors.neutralDarkCity,
        bufferedColor: DSColors.neutralMediumSilver,
      ),
      placeholder: Container(
        color: Colors.black,
      ),
      autoInitialize: true,
    );
  }

  void showAppBar() {
    appBarVisible.value = !(chewieController?.isPlaying ?? false);
  }

  void pauseVideo() {
    if (chewieController != null) {
      chewieController!.isPlaying
          ? chewieController?.pause()
          : chewieController?.play();
    }
  }
}
