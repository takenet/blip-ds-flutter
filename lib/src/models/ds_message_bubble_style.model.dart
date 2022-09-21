import 'dart:ui';

import '../enums/ds_align.enum.dart';
import '../themes/colors/ds_colors.theme.dart';

class DSMessageBubbleStyle {
  final Color sentBorderColor;
  final Color receivedBorderColor;
  final Color sentBackgroundColor;
  final Color receivedBackgroundColor;
  final Color pageBackgroundColor;

  final bool isSentBackgroundLight;
  final bool isReceivedBackgroundLight;
  final bool isPageBackgroundLight;

  DSMessageBubbleStyle({
    this.sentBorderColor = DSColors.neutralDarkCity,
    this.receivedBorderColor = DSColors.neutralMediumSilver,
    this.sentBackgroundColor = DSColors.neutralDarkCity,
    this.receivedBackgroundColor = DSColors.neutralLightSnow,
    this.pageBackgroundColor = DSColors.neutralLightBox,
  })  : isSentBackgroundLight = sentBackgroundColor.computeLuminance() > 0.5,
        isReceivedBackgroundLight =
            receivedBackgroundColor.computeLuminance() > 0.5,
        isPageBackgroundLight = pageBackgroundColor.computeLuminance() > 0.5;

  bool isLightBubbleBackground(DSAlign align) =>
      (align == DSAlign.right && isSentBackgroundLight) ||
      isReceivedBackgroundLight;

  bool isDefaultBubbleBackground(DSAlign align) =>
      [DSColors.neutralDarkCity, DSColors.neutralLightSnow].any((color) =>
          (align == DSAlign.right && sentBackgroundColor == color) ||
          receivedBackgroundColor == color);
}
