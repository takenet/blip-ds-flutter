import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../utils/ds_utils.util.dart';
import '../buttons/ds_play_button_rounded.widget.dart';
import '../texts/ds_body_text.widget.dart';
import 'ds_message_bubble.widget.dart';
import 'video/ds_video_player.widget.dart';

class DSVideoMessageBubble extends StatelessWidget {
  /// Aligns the card to the right or left according to the value assigned to [align] which can be [DSAlign.right] or [DSAlign.left].
  ///
  final DSAlign align;

  /// URL of the video that will be played when clicking on the card
  final String url;

  /// Border to adjust when widget is used in grouping
  final List<DSBorderRadius> borderRadius;

  /// Text associated with the video context to be shown below thumbnail.
  final String? text;

  /// AppBar title above the video screen that also serves to close, returning to the previous screen.
  final String appBarText;

  /// AppBar avatar uri.
  final Uri? appBarPhotoUri;

  final DSMessageBubbleStyle style;

  /// Card for the purpose of triggering a video to play.
  ///
  /// This widget is intended to display a video card from a url passed in the [url] parameter.
  /// The card can be positioned to the right or to the left by the [align] parameter.
  /// The card may also contain a title and text referring to the context of the video to be played.
  DSVideoMessageBubble({
    super.key,
    required this.align,
    required this.url,
    required this.appBarText,
    this.appBarPhotoUri,
    this.text,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

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
    final foregroundColor = style.isLightBubbleBackground(align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    return DSMessageBubble(
      align: align,
      borderRadius: borderRadius,
      padding: EdgeInsets.zero,
      style: style,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 240.0,
            width: 240.0,
            color: DSColors.neutralDarkRooftop,
            child: Align(
              alignment: Alignment.center,
              child: DSRoundedPlayButton(
                align: align,
                onPressed: () async {
                  await showGeneralDialog(
                    context: context,
                    barrierDismissible: false,
                    transitionDuration: DSUtils.defaultAnimationDuration,
                    transitionBuilder: (_, animation, __, child) =>
                        _buildTransition(animation, child),
                    pageBuilder: (context, _, __) => DSVideoPlayer(
                      appBarText: appBarText,
                      appBarPhotoUri: appBarPhotoUri,
                      url: url,
                    ),
                  );
                },
              ),
            ),
          ),
          if (text?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: DSBodyText(
                text!,
                color: foregroundColor,
              ),
            ),
        ],
      ),
    );
  }
}
