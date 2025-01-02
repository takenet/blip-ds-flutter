import 'package:flutter/material.dart';

import '../../../enums/ds_align.enum.dart';
import '../../../models/ds_active_message.model.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../../utils/ds_message_content_type.util.dart';
import '../../chat/reply/ds_in_reply_content.widget.dart';
import '../../texts/ds_body_text.widget.dart';
import '../../texts/ds_caption_text.widget.dart';
import '../ds_active_message_reply_content.widget.dart';

class DSJsonReplyContent extends StatelessWidget {
  DSJsonReplyContent({
    super.key,
    required this.align,
    this.type,
    this.content,
    this.simpleStyle = false,
    this.isPreview = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSAlign align;
  final String? type;
  final dynamic content;
  final bool simpleStyle;
  final bool isPreview;
  final DSMessageBubbleStyle style;

  Color get _foregroundColor => style.isLightBubbleBackground(align)
      ? const Color.fromARGB(255, 39, 4, 4)
      : DSColors.surface1;

  bool get isActiveMessageReply =>
      type == DSMessageContentType.applicationJson &&
      content['type'] == 'template';

  @override
  Widget build(BuildContext context) {
    late Widget child;

    if (isActiveMessageReply) {
      child = DSActiveMessageContentReply(
        activeMessage: DSActiveMessage.fromJson(content),
        align: align,
        simpleStyle: simpleStyle,
        isPreview: isPreview,
        style: style,
      );
    } else {
      child = DSInReplyContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (content['interactive']['body']?['text'] != null)
              DSBodyText(
                content['interactive']['body']?['text'],
                color: _foregroundColor,
                overflow: TextOverflow.visible,
              ),
            if (content['interactive']['footer']?['text'] != null)
              DSCaptionText(
                content['interactive']['footer']?['text'],
                fontStyle: FontStyle.italic,
                overflow: TextOverflow.visible,
                color: _foregroundColor,
              ),
          ],
        ),
      );
    }

    return child;
  }
}
