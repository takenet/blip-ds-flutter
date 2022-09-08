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
    return Container(
      color: Colors.black,
      padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Obx(
          () => Stack(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: !controller.isLoading.value
                          ? GestureDetector(
                              onTapDown: (_) {
                                controller.pauseVideo();
                                controller.showAppBar();
                              },
                              child: Chewie(
                                controller: controller.chewieController!,
                              ),
                            )
                          : const CircularProgressIndicator(),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
              _appBar(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150.0),
      child: AnimatedOpacity(
        opacity: controller.appBarVisible.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                padding: const EdgeInsets.all(12.0),
                onPressed: () {
                  Get.delete<DSVideoPlayerController>();
                  Navigator.of(Get.context!).pop();
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
    );
  }
}
