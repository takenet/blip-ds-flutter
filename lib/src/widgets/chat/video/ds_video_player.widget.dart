import 'dart:io';

//import 'package:chewie_example/app/theme.dart';
import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class DSVideoPlayer extends StatefulWidget {
  const DSVideoPlayer({
    Key? key,
    this.appBarText = 'Chewie Demo',
  }) : super(key: key);

  final String appBarText;

  @override
  State<StatefulWidget> createState() {
    return _DSVideoPlayerState();
  }
}

class _DSVideoPlayerState extends State<DSVideoPlayer> {
  //final TargetPlatform _platform = TargetPlatform.android;
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  List<String> srcs = [
    "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4"
  ];

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(srcs[2]);
    await Future.wait([
      _videoPlayerController.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: widget.title,
      //theme: ThemeData(platform: _platform),
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
                  child: _chewieController != null &&
                          _chewieController!
                              .videoPlayerController.value.isInitialized
                      ? Chewie(
                          controller: _chewieController!,
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
