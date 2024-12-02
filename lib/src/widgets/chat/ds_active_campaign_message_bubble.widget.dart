import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../extensions/ds_localization.extension.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_reply_content.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_headline_small_text.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSActiveCampaignMessageBubble extends StatelessWidget {
  DSActiveCampaignMessageBubble({
    super.key,
    required this.align,
    this.name,
    this.text,
    this.replyContent,
    this.overflow = TextOverflow.visible,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSAlign align;
  final DSReplyContent? replyContent;
  final String? name;
  final String? text;
  final TextOverflow overflow;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (name?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
              ),
              child: Row(
                children: [
                  Icon(
                    DSIcons.megaphone_outline,
                    color: style.isLightBubbleBackground(align)
                        ? DSColors.neutralDarkCity
                        : DSColors.neutralLightSnow,
                  ),
                  const SizedBox(width: 8.0),
                  Flexible(
                    child: DSHeadlineSmallText(
                      name!,
                      color: color,
                      overflow: overflow,
                    ),
                  ),
                ],
              ),
            ),
          Flexible(
            child: DSBodyText(
              text?.replaceAll(r"\n", '\n').trim() ??
                  'unsupported-content.text'.translate(),
              color: color,
              overflow: overflow,
            ),
          ),
        ],
      ),
    );
  }
}
