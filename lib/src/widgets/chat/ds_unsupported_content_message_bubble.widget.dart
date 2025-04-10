import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../extensions/ds_localization.extension.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_reply_content.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../texts/ds_body_text.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSUnsupportedContentMessageBubble extends StatelessWidget {
  final DSAlign align;
  final Widget? leftWidget;
  final DSReplyContent? replyContent;
  final String? text;
  final TextOverflow overflow;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final bool simpleStyle;

  DSUnsupportedContentMessageBubble({
    super.key,
    required this.align,
    this.leftWidget,
    this.text,
    this.replyContent,
    this.overflow = TextOverflow.ellipsis,
    this.borderRadius = const [DSBorderRadius.all],
    this.simpleStyle = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    final color = style.isLightBubbleBackground(align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    return DSMessageBubble(
      borderRadius: borderRadius,
      align: align,
      style: style,
      replyContent: replyContent,
      simpleStyle: simpleStyle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leftWidget ??
              Icon(
                DSIcons.false_outline,
                color: style.isLightBubbleBackground(align)
                    ? DSColors.neutralDarkCity
                    : DSColors.neutralLightSnow,
                size: 20.0,
              ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: DSBodyText(
                text ?? 'unsupported-content.text'.translate(),
                color: color,
                overflow: overflow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
