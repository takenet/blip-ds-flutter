import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../enums/ds_align.enum.dart';
import '../../extensions/ds_localization.extension.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/texts/styles/ds_body_text_style.theme.dart';
import '../texts/ds_body_text.widget.dart';

class DSShowMoreText extends StatelessWidget {
  final String text;
  final double maxWidth;
  final DSAlign align;
  final DSMessageBubbleStyle style;

  DSShowMoreText({
    super.key,
    required this.text,
    required this.maxWidth,
    required this.align,
    DSMessageBubbleStyle? style,
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
              isSelectable: true,
            ),
            if (textPainter.didExceedMaxLines)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () => shouldShowFullText.value = true,
                  child: DSBodyText(
                    'message.show-more'.translate(),
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
