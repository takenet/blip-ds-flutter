import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../utils/ds_message_content_type.util.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';

class DSReplyContainer extends StatelessWidget {
  const DSReplyContainer({
    super.key,
    required this.replyContent,
    required this.style,
    required this.align,
  });

  final DSAlign align;
  final dynamic replyContent;
  final DSMessageBubbleStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                DSIcons.undo_outline,
                color: style.isLightBubbleBackground(align)
                    ? DSColors.neutralDarkCity
                    : DSColors.neutralLightSnow,
              ),
              const SizedBox(width: 8.0),
              DSCaptionText(
                'Reply',
                fontStyle: FontStyle.italic,
                color: style.isLightBubbleBackground(align)
                    ? DSColors.neutralDarkCity
                    : DSColors.neutralLightSnow,
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: style.isLightBubbleBackground(align)
                    ? DSColors.contentGhost
                    : DSColors.contentDisable,
              ),
              color: style.isLightBubbleBackground(align)
                  ? DSColors.surface3
                  : DSColors.contentDefault,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                      ),
                      color: DSColors.primary,
                    ),
                    width: 4.0,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 8.0,
                        bottom: 8.0,
                      ),
                      child: _replyWidget(replyContent, style, align),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _replyWidget(
  dynamic replyContent,
  DSMessageBubbleStyle style,
  DSAlign align,
) {
  switch (replyContent['type']) {
    case DSMessageContentType.textPlain:
      return DSBodyText(
        replyContent['value'] is String ? replyContent['value'] : '**********',
        color: _color(align, style),
        overflow: TextOverflow.visible,
      );
    default:
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            DSIcons.warning_outline,
            color: _color(align, style),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: DSBodyText(
              'Failed to load message',
              overflow: TextOverflow.visible,
              color: _color(align, style),
            ),
          ),
        ],
      );
  }
}

Color _color(DSAlign align, DSMessageBubbleStyle style) {
  return style.isLightBubbleBackground(align)
      ? DSColors.contentDefault
      : DSColors.surface1;
}
