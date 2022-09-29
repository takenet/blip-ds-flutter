import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class DSShowMoreText extends StatelessWidget {
  final DSAlign align;
  final String text;
  final double maxWidth;
  final TextSpan textSpan;

  DSShowMoreText({
    super.key,
    required this.align,
    required this.text,
    required this.maxWidth,
  }) : textSpan = TextSpan(
          text: text,
          style: DSBodyTextStyle(
            color: align == DSAlign.right
                ? DSColors.neutralLightSnow
                : DSColors.neutralDarkCity,
          ),
        );

  final shouldShowFullText = RxBool(false);

  @override
  Widget build(BuildContext context) {
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
              textSpan: textSpan,
              linkColor: align == DSAlign.right
                  ? DSColors.primaryLight
                  : DSColors.primaryNight,
              overflow:
                  !shouldShowFullText.value ? TextOverflow.ellipsis : null,
              maxLines: textPainter.maxLines,
            ),
            if (textPainter.didExceedMaxLines) _buildShowMore(),
          ],
        );
      },
    );
  }

  Widget _buildShowMore() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () => shouldShowFullText.value = true,
        child: DSBodyText(
          // TODO: Need localized translate.
          text: 'Mostrar mais',
          color: align == DSAlign.right
              ? DSColors.primaryLight
              : DSColors.primaryNight,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
