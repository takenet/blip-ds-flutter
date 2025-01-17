import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../services/ds_auth.service.dart';
import '../services/ds_navigation.service.dart';
import '../themes/colors/ds_colors.theme.dart';
import '../widgets/chat/video/ds_video_error.dialog.dart';

class DSVideoPlayerController extends GetxController {
  /// Video controller. responsible for managing the state of the video widget, and all
  /// the management of video controls.
  DSVideoPlayerController({
    required this.url,
    this.shouldAuthenticate = false,
  });

  // External URL containing the video to be played
  final String url;

  /// Indicates if the HTTP Requests should be authenticated or not.
  final bool shouldAuthenticate;

  VideoPlayerController? _videoPlayerController;
  ChewieController? chewieController;
  int? bufferDelay;

  @override
  bool isClosed = false;

  RxBool appBarVisible = true.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    await _initializePlayer();
    super.onInit();
  }

  @override
  void onClose() {
    _videoPlayerController?.dispose();
    chewieController?.dispose();

    isClosed = true;
    super.onClose();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(url),
        httpHeaders: shouldAuthenticate
            ? DSAuthService.httpHeaders
            : const <String, String>{},
      );

      await _videoPlayerController!.initialize();
      _createChewieController();
    } catch (e) {
      _showErrorDialog();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _showErrorDialog() async {
    NavigationService.pop();
    Get.delete<DSVideoPlayerController>();

    await DSVideoErrorDialog.show(
      url: url,
      httpHeaders: shouldAuthenticate ? DSAuthService.httpHeaders : null,
    );
  }

  void _createChewieController() {
    chewieController = ChewieController(
      showOptions: false,
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: true,
      allowPlaybackSpeedChanging: false,
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
}
