import 'package:flutter/material.dart';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/ds_video_player.controller.dart';

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
      child: Obx(
        () {
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Column(
                  children: <Widget>[
                    //_appBar(),
                    Expanded(
                      child: Center(
                        child: !controller.isLoading.value
                            ? GestureDetector(
                                onTapDown: (TapDownDetails details) {
                                  controller.chewieController!.togglePause();
                                },
                                child: Chewie(
                                  controller: controller.chewieController!,
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                _appBar(),
              ],
            ),
          );
        },
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 25.0,
                child: IconButton(
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
              ),
              const SizedBox(width: 20.0),
              DSUserAvatar(
                text: appBarText,
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: DSHeadlineSmallText(
                  text: appBarText,
                  color: DSColors.neutralLightSnow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
