import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_reply_content.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_headline_small_text.widget.dart';
import 'ds_message_bubble.widget.dart';

/// A Design System widget used to display weblinks.

class DSWeblinkMessageBubble extends StatelessWidget {
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

  /// replyContent
  final DSReplyContent? replyContent;

  DSWeblinkMessageBubble({
    Key? key,
    required this.title,
    required this.text,
    required this.align,
    required this.url,
    this.replyContent,
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
      replyContent: replyContent,
      borderRadius: borderRadius,
      style: style,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DSHeadlineSmallText(
            title,
            color: color,
            isSelectable: true,
          ),
          DSBodyText(
            text,
            color: color,
            overflow: TextOverflow.visible,
            isSelectable: true,
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
