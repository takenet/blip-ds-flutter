import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/ds_video_player.controller.dart';
import '../../../services/ds_navigation.service.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../../themes/icons/ds_icons.dart';
import '../../../themes/system_overlay/ds_system_overlay.style.dart';
import '../../utils/ds_header.widget.dart';

class DSVideoPlayer extends StatelessWidget {
  final DSVideoPlayerController controller;

  /// Text to be displayed in the appBarr
  final String appBarText;

  /// Avatar to be displayed in the appBarr
  final Uri? appBarPhotoUri;

  /// Indicates if the HTTP Requests should be authenticated or not.
  final bool shouldAuthenticate;

  /// Video player widget
  ///
  /// In this video player, the slash text is passed by the [appBarText] parameter so that it is contractually shown in the slash.
  /// The [url] parameter contains the reference to be executed
  DSVideoPlayer({
    super.key,
    required this.appBarText,
    required String url,
    this.appBarPhotoUri,
    this.shouldAuthenticate = false,
  }) : controller = Get.put(
          DSVideoPlayerController(
            url: url,
          ),
        );

  @override
  Widget build(BuildContext context) {
    const overlayStyle = DSSystemOverlayStyle.light;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }

          if (await Get.delete<DSVideoPlayerController>()) {
            NavigationService.pop(result);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: DSHeader(
            showBorder: false,
            title: appBarText,
            customerUri: appBarPhotoUri,
            customerName: appBarText,
            backgroundColor: Colors.black.withValues(
              alpha: .7,
            ),
            systemUiOverlayStyle: overlayStyle,
            onBackButtonPressed: () {
              Get.delete<DSVideoPlayerController>();
              NavigationService.pop();
            },
          ),
          body: Obx(
            () => Center(
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: EdgeInsets.fromLTRB(
                        8.0,
                        8.0,
                        8.0,
                        8.0 + MediaQuery.of(context).padding.bottom,
                      ),
                      child: controller.chewieController == null
                          ? const Icon(
                              DSIcons.video_broken_outline,
                              size: 80.0,
                              color: DSColors.neutralDarkRooftop,
                            )
                          : Chewie(
                              controller: controller.chewieController!,
                            ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
