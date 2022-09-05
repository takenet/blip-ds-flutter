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
    super.onClose();
  }

  Future<void> initializePlayer() async {
    final type = url.substring(url.lastIndexOf('.'));
    final fileName = '${DateTime.now().millisecondsSinceEpoch}$type';

    try {
      final result = await DsFileService.download(url, fileName);

      if (result?.isNotEmpty ?? false) {
        _videoPlayerController = VideoPlayerController.file(File(result!));

        await Future.any(
          [
            Future<void>(() async {
              final c = Completer<void>();

              _videoPlayerController!.initialize().then((_) => c.complete());

              return c.future;
            }),
            Future(() {
              final c = Completer<void>();

              Future.delayed(const Duration(milliseconds: 6000), () {
                return c.completeError('Timeout reached');
              });

              return c.future;
            }),
          ],
        );

        _createChewieController();

        isLoading.value = false;
      }
    } catch (e) {
      Navigator.of(Get.context!).pop();

      final dialog = DSDialogService(
        title: 'Erro ao reproduzir o vídeo',
        text: 'Encontramos um erro ao reproduzir o vídeo. Você deseja tentar abrir o vídeo externamente?',
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

      dialog.error();
    }
  }

  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: true,
      allowFullScreen: false,
      playbackSpeeds: const [0.5, 1.0, 1.5, 2.0],
      fullScreenByDefault: false,
      progressIndicatorDelay: bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
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

  void setError() {
    //error.value = true;
  }

  void showAppBar() {
    appBarVisible.value = !(chewieController?.isPlaying ?? false);
  }

  void pauseVideo() {
    if (chewieController != null) {
      chewieController!.isPlaying ? chewieController?.pause() : chewieController?.play();
    }
  }
}
