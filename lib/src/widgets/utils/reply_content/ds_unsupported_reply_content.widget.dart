import 'package:flutter/material.dart';

import '../../../enums/ds_align.enum.dart';
import '../../../extensions/ds_localization.extension.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../../themes/icons/ds_icons.dart';
import '../../chat/reply/ds_in_reply_content.widget.dart';
import '../../texts/ds_body_text.widget.dart';

class DSUnsupportedReplyContent extends StatelessWidget {
  DSUnsupportedReplyContent({
    super.key,
    this.align = DSAlign.right,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSAlign align;
  final DSMessageBubbleStyle style;

  late final _foregroundColor = style.isLightBubbleBackground(align)
      ? const Color.fromARGB(255, 39, 4, 4)
      : DSColors.surface1;

  @override
  Widget build(BuildContext context) {
    return DSInReplyContent(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            DSIcons.warning_outline,
            color: _foregroundColor,
            size: 24.0,
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: DSBodyText(
              'reply.load-fail'.translate(),
              overflow: TextOverflow.visible,
              color: _foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
