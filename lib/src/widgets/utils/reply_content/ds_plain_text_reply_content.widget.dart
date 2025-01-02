import 'package:flutter/material.dart';

import '../../../enums/ds_align.enum.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../chat/reply/ds_in_reply_content.widget.dart';
import '../../texts/ds_body_text.widget.dart';
import '../../texts/ds_caption_text.widget.dart';
import 'ds_unsupported_reply_content.widget.dart';

class DSPlainTextReplyContent extends StatelessWidget {
  DSPlainTextReplyContent({
    super.key,
    required this.align,
    required this.content,
    this.isPreview = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final dynamic content;
  final DSAlign align;
  final bool isPreview;
  final DSMessageBubbleStyle style;

  late final _foregroundColor = style.isLightBubbleBackground(align)
      ? const Color.fromARGB(255, 39, 4, 4)
      : DSColors.surface1;

  @override
  Widget build(BuildContext context) {
    return content is String
        ? DSInReplyContent(
            child: isPreview
                ? DSCaptionText(
                    content.replaceAll('\n', ' '),
                    color: _foregroundColor,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                : DSBodyText(
                    content,
                    color: _foregroundColor,
                    overflow: TextOverflow.visible,
                  ),
          )
        : DSUnsupportedReplyContent(
            align: align,
            style: style,
          );
  }
}
