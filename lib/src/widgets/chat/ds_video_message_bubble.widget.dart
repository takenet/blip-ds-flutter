import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/chat/ds_image_message_bubble.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
//import 'package:pinch_zoom/pinch_zoom.dart';

class DSVideoMessageBubble extends StatelessWidget {
  final DSAlign align;
  final String urlVideo;
  final String urlThumbnail;
  final List<DSBorderRadius> borderRadius;
  final String videoTitle;
  final String? imageText;
  final String appBarText;

  final DSImageMessageBubbleController _controller;

  DSVideoMessageBubble({
    super.key,
    required this.align,
    required this.urlVideo,
    required this.urlThumbnail,
    required this.videoTitle,
    required this.appBarText,
    this.borderRadius = const [DSBorderRadius.all],
    this.imageText,
  }) : _controller = DSImageMessageBubbleController();

  Widget _buildTransition(Animation<double> animation, Widget? child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

/*
  Widget _buildPage(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Obx(
          () {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80.0),
                child: AnimatedOpacity(
                  opacity: _controller.appBarVisible.value ? 1.0 : 0.0,
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
              body: GestureDetector(
                onTap: () => _controller.showAppBar(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black,
                  child: Container(),
                  /*
                  PinchZoom(
                    resetDuration: const Duration(milliseconds: 100),
                    child: DSCachedNetworkImageView(
                      url: urlThumbnail,
                      fit: BoxFit.contain,
                    ),
                  ),
                  */
                ),
              ),
            );
          },
        ),
      ),
    );
  }
*/

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      borderRadius: borderRadius,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (!_controller.error.value) {
                _controller.appBarVisible.value = false;
                showGeneralDialog(
                  context: context,
                  barrierDismissible: false,
                  transitionDuration: DSUtils.defaultAnimationDuration,
                  transitionBuilder: (_, animation, __, child) =>
                      _buildTransition(animation, child),
                  pageBuilder: (context, _, __) => DSVideoPlayer(
                    urlVideo: urlVideo,
                  ),
                );
              }
            },
            child: DSCachedNetworkImageView(
              width: 240.0,
              height: 240.0,
              url: urlThumbnail,
              placeholder: (_, __) => const Padding(
                padding: EdgeInsets.all(80.0),
                child: CircularProgressIndicator(),
              ),
              errorWidget: (_, __, ___) {
                _controller.setError();
                return Image.asset(
                  'assets/images/file_image_broken.png',
                  package: DSUtils.packageName,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DSCaptionSmallText(
                  text: videoTitle,
                  color: align == DSAlign.right
                      ? DSColors.neutralLightSnow
                      : DSColors.neutralDarkCity,
                ),
                if (imageText != null) ...[
                  const SizedBox(
                    height: 6.0,
                  ),
                  DSCaptionText(
                    text: imageText!,
                    color: align == DSAlign.right
                        ? DSColors.neutralLightSnow
                        : DSColors.neutralDarkCity,
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
