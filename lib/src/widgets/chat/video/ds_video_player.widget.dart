import 'package:flutter/material.dart';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/ds_video_player.controller.dart';

class DSVideoPlayer extends StatelessWidget {
  final DSVideoPlayerController controller;

  /// Text to be displayed in the appBarr
  final String appBarText;

  /// Video player widget
  ///
  /// In this video player, the slash text is passed by the [appBarText] parameter so that it is contractually shown in the slash.
  /// The [url] parameter contains the reference to be executed
  DSVideoPlayer({
    Key? key,
    required this.appBarText,
    required String url,
  })  : controller = Get.put(DSVideoPlayerController(url: url)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(bottom: 20.0),
      child: WillPopScope(
        onWillPop: () => Get.delete<DSVideoPlayerController>(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Obx(
            () {
              return Stack(
                children: [
                  Center(
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : Chewie(
                            controller: controller.chewieController!,
                          ),
                  ),
                  _appBar(context),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width - 35.0,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 45.0,
              child: IconButton(
                padding: const EdgeInsets.all(8.0),
                splashRadius: 30.0,
                onPressed: () {
                  Get.delete<DSVideoPlayerController>();
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: DSColors.neutralLightSnow,
                ),
              ),
            ),
            DSUserAvatar(
              text: appBarText,
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: DSHeadlineSmallText(
                appBarText,
                color: DSColors.neutralLightSnow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
