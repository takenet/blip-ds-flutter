import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/buttons/ds_play_button_rounded.widget.dart';

class DSVideoMessageBubble extends StatelessWidget {
  /// Aligns the card to the right or left according to the value assigned to [align] which can be [DSAlign.right] or [DSAlign.left].
  ///
  final DSAlign align;

  /// URL of the video that will be played when clicking on the card
  final String url;

  final List<DSBorderRadius> borderRadius;

  /// Text associated with the video context to be shown below thumbnail.
  final String? text;

  /// AppBar title above the video screen that also serves to close, returning to the previous screen.
  final String appBarText;

  /// Card for the purpose of triggering a video to play.
  ///
  /// This widget is intended to display a video card from a url passed in the [url] parameter.
  /// The card can be positioned to the right or to the left by the [align] parameter.
  /// The card may also contain a title and text referring to the context of the video to be played.
  const DSVideoMessageBubble({
    super.key,
    required this.align,
    required this.url,
    required this.appBarText,
    this.text,
    this.borderRadius = const [DSBorderRadius.all],
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
            height: 240.0,
            width: 240.0,
            color: DSColors.neutralDarkRooftop,
            child: Align(
              alignment: Alignment.center,
              child: DSPlayButtonRounded(
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
                      url: url,
                    ),
                  );

                  //
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
                text: text!,
                color: align == DSAlign.right
                    ? DSColors.neutralLightSnow
                    : DSColors.neutralDarkCity,
              ),
            ),
        ],
      ),
    );
  }
}
