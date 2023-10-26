import 'package:flutter/material.dart';

import '../../../enums/ds_align.enum.dart';
import '../../../enums/ds_border_radius.enum.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../ds_message_bubble.widget.dart';
import 'ds_audio_player.widget.dart';

class DSAudioMessageBubble extends StatelessWidget {
  final Uri uri;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final String? uniqueId;
  final String audioType;
  final bool shouldAuthenticate;
  final dynamic replyContent;

  DSAudioMessageBubble({
    super.key,
    required this.uri,
    required this.align,
    required this.audioType,
    this.uniqueId,
    this.replyContent,
    this.borderRadius = const [DSBorderRadius.all],
    this.shouldAuthenticate = false,
    final DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    final isDefaultBubbleColors = style.isDefaultBubbleBackground(align);
    final isLightBubbleBackground = style.isLightBubbleBackground(align);

    return DSMessageBubble(
      borderRadius: borderRadius,
      align: align,
      replyContent: replyContent,
      style: style,
      padding: const EdgeInsets.only(
        left: 4.0,
        right: 8.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: DSAudioPlayer(
        uri: uri,
        uniqueId: uniqueId,
        audioType: audioType,
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
    );
  }
}
