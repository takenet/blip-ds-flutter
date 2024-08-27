import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../extensions/ds_localization.extension.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_reply_content.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../utils/ds_message_content_type.util.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';

class DSReplyContainer extends StatelessWidget {
  DSReplyContainer({
    super.key,
    required this.replyContent,
    required this.align,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSAlign align;
  final DSReplyContent replyContent;
  final DSMessageBubbleStyle style;

  Color get _foregroundColor => style.isLightBubbleBackground(align)
      ? const Color.fromARGB(255, 39, 4, 4)
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
              size: 24.0,
            ),
            const SizedBox(width: 8.0),
            DSCaptionText(
              'reply.text'.translate(),
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

  Widget _buildReply() => switch (replyContent.inReplyTo.type) {
        DSMessageContentType.textPlain => _buildTextPlain(),
        DSMessageContentType.applicationJson => _buildApplicationJson(),
        DSMessageContentType.select => _buidSelect(),
        _ => _buildDefault(),
      };

  Widget _buidSelect() => DSBodyText(
        replyContent.inReplyTo.value['text'],
        color: _foregroundColor,
        overflow: TextOverflow.visible,
      );

  Widget _buildApplicationJson() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (replyContent.inReplyTo.value['interactive']['body']?['text'] !=
              null)
            DSBodyText(
              replyContent.inReplyTo.value['interactive']['body']?['text'],
              color: _foregroundColor,
              overflow: TextOverflow.visible,
            ),
          if (replyContent.inReplyTo.value['interactive']['footer']?['text'] !=
              null)
            DSCaptionText(
              replyContent.inReplyTo.value['interactive']['footer']?['text'],
              fontStyle: FontStyle.italic,
              overflow: TextOverflow.visible,
              color: _foregroundColor,
            ),
        ],
      );

  Widget _buildTextPlain() => replyContent.inReplyTo.value is String
      ? DSBodyText(
          replyContent.inReplyTo.value,
          color: _foregroundColor,
          overflow: TextOverflow.visible,
        )
      : _buildDefault();

  Widget _buildDefault() => Row(
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
      );
}
