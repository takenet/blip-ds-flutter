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

  get _foregroundColor => style.isLightBubbleBackground(align)
      ? DSColors.contentDefault
      : DSColors.surface1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildTitle(),
          _buildReplyContainer(),
        ],
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
      );

  Widget _buildReplyContainer() => DecoratedBox(
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
                  padding: const EdgeInsets.all(8.0),
                  child: _buildReply(),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildReply() => switch (replyContent['type']) {
        DSMessageContentType.textPlain => _buildTextPlain(),
        _ => _buildDefault(),
      };

  Widget _buildTextPlain() => DSBodyText(
        replyContent['value'] is String ? replyContent['value'] : '**********',
        color: _foregroundColor,
        overflow: TextOverflow.visible,
      );

  Widget _buildDefault() => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            DSIcons.warning_outline,
            color: _foregroundColor,
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: DSBodyText(
              'Failed to load message',
              overflow: TextOverflow.visible,
              color: _foregroundColor,
            ),
          ),
        ],
      );
}
