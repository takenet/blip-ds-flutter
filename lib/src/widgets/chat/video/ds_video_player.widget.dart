import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/ds_video_player.controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DSVideoPlayer extends StatelessWidget {
  final String appBarText;
  final DSVideoPlayerController controller;

  DSVideoPlayer({
    Key? key,
    required this.appBarText,
    required String url,
  })  : controller = Get.put(DSVideoPlayerController(url: url)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        controller.pauseVideo();
        controller.showAppBar();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Container(
            margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
            child: Obx(
              () => AnimatedOpacity(
                opacity: controller.appBarVisible.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.delete<DSVideoPlayerController>();
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: DSColors.neutralLightSnow,
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: DSUserAvatar(
                            text: appBarText,
                          ),
                          title: DSHeadlineSmallText(
                            text: appBarText,
                            color: DSColors.neutralLightSnow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Obx(
            () => GestureDetector(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: !controller.isLoading.value
                          ? Chewie(
                              controller: controller.chewieController!,
                            )
                          : const CircularProgressIndicator(),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
