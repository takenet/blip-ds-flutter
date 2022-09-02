import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSVideoMessageBubble extends StatelessWidget {
  final DSAlign align;
  final String urlVideo;
  final List<DSBorderRadius> borderRadius;
  final String videoTitle;
  final String? imageText;
  final String appBarText;

  const DSVideoMessageBubble({
    super.key,
    required this.align,
    required this.urlVideo,
    required this.videoTitle,
    required this.appBarText,
    this.borderRadius = const [DSBorderRadius.all],
    this.imageText,
  });

  Widget _buildTransition(Animation<double> animation, Widget? child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      borderRadius: borderRadius,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: DSColors.neutralDarkRooftop,
            child: GestureDetector(
              onTap: () {
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
              },
              child: Image.asset(
                width: 240,
                height: 240,
                align == DSAlign.right
                    ? 'assets/images/play_right.png'
                    : 'assets/images/play_left.png',
                package: DSUtils.packageName,
              ),
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
