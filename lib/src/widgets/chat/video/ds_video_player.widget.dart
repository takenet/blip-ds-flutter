import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/ds_video_.controller.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';

class DSVideoPlayer extends StatelessWidget {
  final String appBarText;
  final String urlVideo;

  const DSVideoPlayer({
    Key? key,
    this.appBarText = 'Chewie Demo',
    required this.urlVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DSVideoController videoController =
        Get.put(DSVideoController(urlVideo: urlVideo));

    return MaterialApp(
      home: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Obx(
              () => AnimatedOpacity(
                opacity: videoController.appBarVisible.value ? 1.0 : 0.0,
                duration: DSUtils.defaultAnimationDuration,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.of(context).pop(),
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
          body: GetBuilder<DSVideoController>(
            builder: (_) => GestureDetector(
              onTapDown: (TapDownDetails details) {
                videoController.showAppBar();
                videoController.pauseVideo();
              },
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: videoController.chewieController != null &&
                              videoController.chewieController!
                                  .videoPlayerController.value.isInitialized
                          ? Chewie(
                              controller: videoController.chewieController!,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(),
                                SizedBox(height: 20),
                                Text('Loading'),
                              ],
                            ),
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
