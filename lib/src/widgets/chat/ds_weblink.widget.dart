import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

/// A Design System widget used to display weblinks.

class DSWeblink extends StatelessWidget {
  /// Show the [title] on the card
  final String title;

  /// Show the [text] on the card
  final String text;

  /// URL that will be played when clicking on the card
  final String url;

  /// Sets the card's alignment on the screen.
  final DSAlign align;

  /// Card borders for design when used grouped
  final List<DSBorderRadius> borderRadius;

  /// Card styling to adjust custom colors
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
