import 'dart:io';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/ds_video_.controller.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class DSVideoPlayer extends StatefulWidget {
  const DSVideoPlayer({
    Key? key,
    this.appBarText = 'Chewie Demo',
    required this.urlVideo,
  }) : super(key: key);

  final String appBarText;
  final String urlVideo;

  @override
  State<StatefulWidget> createState() {
    return _DSVideoPlayerState();
  }
}

class _DSVideoPlayerState extends State<DSVideoPlayer> {
  //final DSVideoController videoController = DSVideoController();
  final DSVideoController videoController = Get.put(DSVideoController());

  late VideoPlayerController _videoPlayerController;
  //ChewieController? _chewieController;
  int? bufferDelay;

  //@override
  //void initState() {
  //  super.initState();
  //  initializePlayer();
  //}

  //@override
  //void dispose() {
  //  _videoPlayerController.dispose();
  //  _chewieController?.dispose();
  //  super.dispose();
  //}

  //Future<void> initializePlayer() async {
  //  _videoPlayerController = VideoPlayerController.network(widget.urlVideo);
  //  await Future.wait([
  //    _videoPlayerController.initialize(),
  //  ]);
  //  _createChewieController();
  //  setState(() {});
  //}

  /*
  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      allowFullScreen: false,
      fullScreenByDefault: false,

      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,

      hideControlsTimer: const Duration(seconds: 10),

      //showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.white,
        handleColor: Colors.white,
        backgroundColor: Colors.black,
        bufferedColor: Colors.grey,
      ),
      placeholder: Container(
        color: Colors.black,
      ),
      autoInitialize: true,
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: AnimatedOpacity(
              opacity: 1.0, //_controller.appBarVisible.value ? 1.0 : 0.0,
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
                          text: widget.appBarText,
                        ),
                        title: DSHeadlineSmallText(
                          text: widget.appBarText,
                          color: DSColors.neutralLightSnow,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
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
            ],
          ),
        ),
      ),
    );
  }
}
