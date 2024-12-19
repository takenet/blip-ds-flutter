import 'package:flutter/material.dart';

import '../../../enums/ds_align.enum.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../chat/reply/ds_in_reply_content.widget.dart';
import '../../texts/ds_body_text.widget.dart';
import '../../texts/ds_caption_text.widget.dart';

class DSSelectReplyContent extends StatelessWidget {
  DSSelectReplyContent({
    super.key,
    required this.align,
    this.content,
    this.isPreview = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSAlign align;
  final String? content;
  final bool isPreview;
  final DSMessageBubbleStyle style;

  Color get _foregroundColor => style.isLightBubbleBackground(align)
      ? const Color.fromARGB(255, 39, 4, 4)
      : DSColors.surface1;

  @override
  Widget build(BuildContext context) {
    return DSInReplyContent(
      child: isPreview
          ? DSCaptionText(
              content ?? '',
              color: _foregroundColor,
            )
          : DSBodyText(
              content ?? '',
              color: _foregroundColor,
              overflow: TextOverflow.visible,
            ),
    );
  }
}
