import 'dart:ui';

import '../enums/ds_align.enum.dart';
import '../themes/colors/ds_colors.theme.dart';

class DSMessageBubbleStyle {
  final Color sentBackgroundColor;
  final Color receivedBackgroundColor;
  final Color pageBackgroundColor;

  final bool isSentBackgroundLight;
  final bool isReceivedBackgroundLight;
  final bool isPageBackgroundLight;

  DSMessageBubbleStyle({
    this.sentBackgroundColor = DSColors.neutralDarkCity,
    this.receivedBackgroundColor = DSColors.neutralLightSnow,
    this.pageBackgroundColor = DSColors.neutralLightBox,
  })  : isSentBackgroundLight = sentBackgroundColor.computeLuminance() > 0.5,
        isReceivedBackgroundLight =
            receivedBackgroundColor.computeLuminance() > 0.5,
        isPageBackgroundLight = pageBackgroundColor.computeLuminance() > 0.5;

  bool isLightBubbleBackground(DSAlign align) =>
      (align == DSAlign.right && isSentBackgroundLight) ||
      (align == DSAlign.left && isReceivedBackgroundLight);

  bool isDefaultBubbleBackground(DSAlign align) =>
      [DSColors.neutralDarkCity, DSColors.neutralLightSnow].any((color) =>
          (align == DSAlign.right && sentBackgroundColor == color) ||
          (align == DSAlign.left && receivedBackgroundColor == color));

  Color bubbleBackgroundColor(DSAlign align) =>
      align == DSAlign.right ? sentBackgroundColor : receivedBackgroundColor;

  Color bubbleBorderColor(DSAlign align) =>
      [DSColors.neutralLightSnow].any((color) =>
              (align == DSAlign.right && sentBackgroundColor == color) ||
              (align == DSAlign.left && receivedBackgroundColor == color))
          ? DSColors.neutralMediumSilver
          : bubbleBackgroundColor(align);
}
