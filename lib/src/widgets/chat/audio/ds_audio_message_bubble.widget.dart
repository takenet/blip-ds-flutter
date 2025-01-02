import 'package:flutter/material.dart';

import '../../../enums/ds_align.enum.dart';
import '../../../enums/ds_border_radius.enum.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../models/ds_reply_content.model.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../ds_message_bubble.widget.dart';
import 'ds_audio_player.widget.dart';

class DSAudioMessageBubble extends StatelessWidget {
  final Uri uri;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final String? uniqueId;
  final bool shouldAuthenticate;
  final DSReplyContent? replyContent;
  final bool simpleStyle;
  final void Function(String)? onTapReply;

  DSAudioMessageBubble({
    super.key,
    required this.uri,
    required this.align,
    this.uniqueId,
    this.replyContent,
    this.borderRadius = const [DSBorderRadius.all],
    this.shouldAuthenticate = false,
    this.simpleStyle = false,
    final DSMessageBubbleStyle? style,
    this.onTapReply,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    final isDefaultBubbleColors = style.isDefaultBubbleBackground(align);
    final isLightBubbleBackground = style.isLightBubbleBackground(align);

    return DSMessageBubble(
      onTapReply: onTapReply,
      borderRadius: borderRadius,
      align: align,
      replyContent: replyContent,
      style: style,
      padding: EdgeInsets.zero,
      simpleStyle: simpleStyle,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 8.0, 8.0, 8.0),
        child: DSAudioPlayer(
          uri: uri,
          shouldAuthenticate: shouldAuthenticate,
          controlForegroundColor: isLightBubbleBackground
              ? DSColors.neutralDarkRooftop
              : DSColors.neutralLightSnow,
          labelColor: isLightBubbleBackground
              ? DSColors.neutralDarkCity
              : DSColors.neutralLightSnow,
          bufferActiveTrackColor: isLightBubbleBackground
              ? DSColors.neutralMediumWave
              : DSColors.neutralMediumElephant,
          bufferInactiveTrackColor: isLightBubbleBackground
              ? DSColors.neutralDarkRooftop
              : DSColors.neutralLightBox,
          sliderActiveTrackColor: isLightBubbleBackground
              ? DSColors.primaryNight
              : DSColors.primaryLight,
          sliderThumbColor: isLightBubbleBackground
              ? DSColors.neutralDarkRooftop
              : DSColors.neutralLightSnow,
          speedForegroundColor: isLightBubbleBackground
              ? DSColors.neutralDarkCity
              : DSColors.neutralLightSnow,
          speedBorderColor: isLightBubbleBackground
              ? isDefaultBubbleColors
                  ? DSColors.neutralMediumSilver
                  : DSColors.neutralDarkCity
              : isDefaultBubbleColors
                  ? DSColors.disabledText
                  : DSColors.neutralLightSnow,
        ),
      ),
    );
  }
}
