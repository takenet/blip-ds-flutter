import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class DSShowMoreText extends StatelessWidget {
  final String text;
  final double maxWidth;
  final DSAlign align;

  final DSMessageBubbleStyle style;

  DSShowMoreText({
    super.key,
    required this.text,
    required this.maxWidth,
    DSMessageBubbleStyle? style,
    required this.align,
  }) : style = style ?? DSMessageBubbleStyle();

  final shouldShowFullText = RxBool(false);

  @override
  Widget build(BuildContext context) {
    final isDefaultBubbleColors = style.isDefaultBubbleBackground(align);
    final isLightBubbleBackground = style.isLightBubbleBackground(align);

    final TextSpan textSpan = TextSpan(
      text: text,
      style: DSBodyTextStyle(
        color: isLightBubbleBackground
            ? DSColors.neutralDarkCity
            : DSColors.neutralLightSnow,
      ),
    );

    return Obx(
      () {
        TextPainter textPainter = TextPainter(
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          maxLines: !shouldShowFullText.value ? 12 : null,
          text: textSpan,
        );

        textPainter.layout(maxWidth: maxWidth);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSBodyText.rich(
              textSpan,
              linkColor: isLightBubbleBackground
                  ? isDefaultBubbleColors
                      ? DSColors.primaryNight
                      : DSColors.neutralDarkCity
                  : isDefaultBubbleColors
                      ? DSColors.primaryLight
                      : DSColors.neutralLightSnow,
              overflow:
                  !shouldShowFullText.value ? TextOverflow.ellipsis : null,
              maxLines: textPainter.maxLines,
            ),
            if (textPainter.didExceedMaxLines)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () => shouldShowFullText.value = true,
                  child: DSBodyText(
                    // TODO: Need localized translate.
                    'Mostrar mais',
                    color: isLightBubbleBackground
                        ? isDefaultBubbleColors
                            ? DSColors.primaryNight
                            : DSColors.neutralDarkCity
                        : isDefaultBubbleColors
                            ? DSColors.primaryLight
                            : DSColors.neutralLightSnow,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
