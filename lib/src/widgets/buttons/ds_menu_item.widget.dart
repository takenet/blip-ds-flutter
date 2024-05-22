import 'package:flutter/material.dart';

import '../../../blip_ds.dart';

class DSMenuItem extends StatelessWidget {
  DSMenuItem({
    super.key,
    required this.text,
    required this.align,
    this.showDivider = false,
    this.onPressed,
    this.fontWeight = DSFontWeights.bold,
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle() {
    isDefaultBubbleColors = this.style.isDefaultBubbleBackground(align);
    isLightBubbleBackground = this.style.isLightBubbleBackground(align);
  }

  final String text;
  final DSAlign align;
  final bool showDivider;
  final void Function()? onPressed;
  final DSMessageBubbleStyle style;
  final FontWeight fontWeight;

  late final bool isDefaultBubbleColors;
  late final bool isLightBubbleBackground;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            Container(
              height: 57.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DSBodyText(
                text,
                fontWeight: fontWeight,
                maxLines: 2,
                color: isLightBubbleBackground
                    ? isDefaultBubbleColors
                        ? DSColors.primaryNight
                        : DSColors.neutralDarkCity
                    : isDefaultBubbleColors
                        ? DSColors.primaryLight
                        : DSColors.neutralLightSnow,
              ),
            ),
            if (showDivider)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 1.0,
                ),
                child: DSDivider(
                  color: isLightBubbleBackground
                      ? isDefaultBubbleColors
                          ? DSColors.neutralMediumWave
                          : DSColors.neutralDarkCity
                      : isDefaultBubbleColors
                          ? DSColors.neutralDarkRooftop
                          : DSColors.neutralLightSnow,
                ),
              )
          ],
        ),
      );
}
