import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSWeblink extends StatelessWidget {
  final String title;
  final String text;
  final String url;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  DSWeblink({
    Key? key,
    required this.title,
    required this.text,
    required this.align,
    required this.url,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDefaultBubbleColors = style.isDefaultBubbleBackground(align);
    final isLightBubbleBackground = style.isLightBubbleBackground(align);
    final color = isLightBubbleBackground
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;
    return DSMessageBubble(
      align: align,
      borderRadius: borderRadius,
      style: style,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DSHeadlineSmallText(
            title,
            color: color,
          ),
          DSBodyText(
            text,
            color: color,
            overflow: TextOverflow.visible,
          ),
          const SizedBox(
            height: 20.0,
          ),
          DSBodyText(
            url,
            linkColor: isLightBubbleBackground
                ? isDefaultBubbleColors
                    ? DSColors.primaryNight
                    : DSColors.neutralDarkCity
                : isDefaultBubbleColors
                    ? DSColors.primaryLight
                    : DSColors.neutralLightSnow,
          ),
        ],
      ),
    );
  }
}
