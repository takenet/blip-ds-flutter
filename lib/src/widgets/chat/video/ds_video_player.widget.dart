import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/ds_video_player.controller.dart';
import '../../utils/ds_header.widget.dart';

class DSVideoPlayer extends StatelessWidget {
  final DSVideoPlayerController controller;

  /// Text to be displayed in the appBarr
  final String appBarText;

  /// Avatar to be displayed in the appBarr
  final Uri? appBarPhotoUri;

  final String uniqueId;

  /// Video player widget
  ///
  /// In this video player, the slash text is passed by the [appBarText] parameter so that it is contractually shown in the slash.
  /// The [url] parameter contains the reference to be executed
  DSVideoPlayer({
    Key? key,
    required this.appBarText,
    this.appBarPhotoUri,
    required String url,
    required this.uniqueId,
  })  : controller = Get.put(
          DSVideoPlayerController(
            url: url,
            uniqueId: uniqueId,
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.delete<DSVideoPlayerController>(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: DSHeader(
          showBorder: false,
          title: appBarText,
          customerUri: appBarPhotoUri,
          customerName: appBarText,
          backgroundColor: Colors.black.withOpacity(.7),
          systemUiOverlayStyle: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
          ),
          onBackButtonPressed: () {
            Get.delete<DSVideoPlayerController>();
            Get.back();
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
                    child: Chewie(
                      controller: controller.chewieController!,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
