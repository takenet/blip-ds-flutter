import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../extensions/ds_localization.extension.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_reply_content.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../texts/ds_caption_text.widget.dart';
import '../utils/reply_content/ds_reply_preview.widget.dart';

class DSReplyContainer extends StatelessWidget {
  DSReplyContainer({
    super.key,
    required this.replyContent,
    required this.align,
    this.simpleStyle = false,
    DSMessageBubbleStyle? style,
    this.onTap,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSAlign align;
  final DSReplyContent replyContent;
  final bool simpleStyle;
  final DSMessageBubbleStyle style;
  final void Function(String)? onTap;

  late final isLightBubbleBackground = style.isLightBubbleBackground(align);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(replyContent.inReplyTo.id),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildTitle(),
            _buildReplyContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() => Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              DSIcons.undo_outline,
              color: isLightBubbleBackground
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow,
              size: 24.0,
            ),
            const SizedBox(width: 8.0),
            DSCaptionText(
              'reply.text'.translate(),
              fontStyle: FontStyle.italic,
              color: isLightBubbleBackground
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow,
            ),
          ],
        ),
      );

  Widget _buildReplyContainer() => Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: isLightBubbleBackground
              ? DSColors.surface2
              : DSColors.contentDefault,
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                color: isLightBubbleBackground
                    ? DSColors.primary
                    : DSColors.contentGhost,
                width: 4.0,
              ),
              _buildReply(),
            ],
          ),
        ),
      );

  Widget _buildReply() => DSReplyPreview(
        type: replyContent.inReplyTo.type,
        content: replyContent.inReplyTo.value,
        align: align,
        simpleStyle: simpleStyle,
        style: style,
      );
}
