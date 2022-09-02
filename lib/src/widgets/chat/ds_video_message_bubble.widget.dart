import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSVideoMessageBubble extends StatelessWidget {
  /// Aligns the card to the right or left according to the value assigned to [align] which can be [DSAlign.right] or [DSAlign.left].
  final DSAlign align;

  /// URL of the video that will be played when clicking on the card
  final String urlVideo;

  final List<DSBorderRadius> borderRadius;

  /// Video title to be shown below the thumbnail
  final String videoTitle;

  /// Text associated with the video context to be shown below the title.
  final String? imageText;

  /// AppBar title above the video screen that also serves to close, returning to the previous screen.
  final String appBarText;

  /// Card for the purpose of triggering a video to play.
  ///
  /// This widget is intended to display a video card from a url passed in the [urlVideo] parameter.
  /// The card can be positioned to the right or to the left by the [align] parameter.
  /// The card may also contain a title and text referring to the context of the video to be played.
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
