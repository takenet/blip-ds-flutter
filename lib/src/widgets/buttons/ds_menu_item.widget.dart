import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/texts/utils/ds_font_weights.theme.dart';
import '../texts/ds_body_text.widget.dart';

class DSMenuItem extends StatelessWidget {
  DSMenuItem({
    Key? key,
    required this.text,
    required this.align,
    this.showBorder = false,
    this.onPressed,
    this.fontWeight = DSFontWeights.bold,
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        super(key: key) {
    isDefaultBubbleColors = this.style.isDefaultBubbleBackground(align);
    isLightBubbleBackground = this.style.isLightBubbleBackground(align);
  }

  final String text;
  final DSAlign align;
  final bool showBorder;
  final void Function()? onPressed;
  final DSMessageBubbleStyle style;
  final FontWeight fontWeight;

  late final bool isDefaultBubbleColors;
  late final bool isLightBubbleBackground;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 57.0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: showBorder
              ? Border(
                  bottom: BorderSide(
                    color: isLightBubbleBackground
                        ? isDefaultBubbleColors
                            ? DSColors.neutralMediumWave
                            : DSColors.neutralDarkCity
                        : isDefaultBubbleColors
                            ? DSColors.neutralDarkRooftop
                            : DSColors.neutralLightSnow,
                  ),
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: DSBodyText(
                text,
                fontWeight: fontWeight,
                textAlign: TextAlign.center,
                color: isLightBubbleBackground
                    ? isDefaultBubbleColors
                        ? DSColors.primaryNight
                        : DSColors.neutralDarkCity
                    : isDefaultBubbleColors
                        ? DSColors.primaryLight
                        : DSColors.neutralLightSnow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
