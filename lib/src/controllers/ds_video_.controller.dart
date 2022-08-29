import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class DSVideoController extends GetxController {
  DSVideoController({
    this.urlVideo,
  });

  final String? urlVideo;

  late VideoPlayerController _videoPlayerController;
  ChewieController? chewieController;
  int? bufferDelay;

  RxBool appBarVisible = true.obs;

  @override
  void onInit() async {
    initializePlayer();
    super.onInit();
  }

  @override
  void onClose() {
    _videoPlayerController.dispose();
    chewieController?.dispose();
    super.onClose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(urlVideo!);
    await Future.wait([
      _videoPlayerController.initialize(),
    ]);
    _createChewieController();
    update();
  }

  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      allowFullScreen: false,
      fullScreenByDefault: false,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      hideControlsTimer: const Duration(seconds: 10),
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
    appBarVisible.value
        ? appBarVisible.value = false
        : appBarVisible.value = true;
  }

  void pauseVideo() {
    if (chewieController != null) {
      chewieController!.isPlaying
          ? chewieController?.pause()
          : chewieController?.play();
    }
  }
}
