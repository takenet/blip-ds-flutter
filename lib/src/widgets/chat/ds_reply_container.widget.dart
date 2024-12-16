import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../extensions/ds_localization.extension.dart';
import '../../models/ds_active_message.model.dart';
import '../../models/ds_location.model.dart';
import '../../models/ds_media_link.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_reply_content.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../utils/ds_message_content_type.util.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';
import '../utils/ds_active_message_reply_content.widget.dart';
import '../utils/ds_location_reply_content.widget.dart';
import '../utils/ds_media_reply_content.widget.dart';
import 'reply/ds_in_reply_content.widget.dart';

class DSReplyContainer extends StatelessWidget {
  DSReplyContainer({
    super.key,
    required this.replyContent,
    required this.align,
    this.simpleStyle = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSAlign align;
  final DSReplyContent replyContent;
  final bool simpleStyle;
  final DSMessageBubbleStyle style;

  Color get _foregroundColor => style.isLightBubbleBackground(align)
      ? const Color.fromARGB(255, 39, 4, 4)
      : DSColors.surface1;

  bool get isActiveMessageReply =>
      replyContent.inReplyTo.type == DSMessageContentType.applicationJson &&
      replyContent.inReplyTo.value['type'] == 'template';

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

  Widget _buildReplyContainer() => Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: style.isLightBubbleBackground(align)
              ? DSColors.surface2
              : DSColors.contentDefault,
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                color: DSColors.primary,
                width: 4.0,
              ),
              _buildReply(),
            ],
          ),
        ),
      );

  Widget _buildReply() => switch (replyContent.inReplyTo.type) {
        DSMessageContentType.textPlain => _buildTextPlain(),
        DSMessageContentType.select => _buidSelect(),
        DSMessageContentType.mediaLink => _buildMediaLink(),
        DSMessageContentType.applicationJson => _buildApplicationJson(),
        DSMessageContentType.location => _buidLocation(),
        _ => _buildDefault(),
      };

  Widget _buidSelect() => DSInReplyContent(
        child: DSBodyText(
          replyContent.inReplyTo.value['text'],
          color: _foregroundColor,
          overflow: TextOverflow.visible,
        ),
      );

  Widget _buildApplicationJson() {
    late Widget child;

    if (isActiveMessageReply) {
      child = _buildActiveMessageReply();
    } else {
      child = DSInReplyContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (replyContent.inReplyTo.value['interactive']['body']?['text'] !=
                null)
              DSBodyText(
                replyContent.inReplyTo.value['interactive']['body']?['text'],
                color: _foregroundColor,
                overflow: TextOverflow.visible,
              ),
            if (replyContent.inReplyTo.value['interactive']['footer']
                    ?['text'] !=
                null)
              DSCaptionText(
                replyContent.inReplyTo.value['interactive']['footer']?['text'],
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

  Widget _buildTextPlain() => replyContent.inReplyTo.value is String
      ? DSInReplyContent(
          child: DSBodyText(
            replyContent.inReplyTo.value,
            color: _foregroundColor,
            overflow: TextOverflow.visible,
          ),
        )
      : _buildDefault();

  Widget _buildMediaLink() => DSMediaReplyContent(
        media: DSMediaLink.fromJson(replyContent.inReplyTo.value),
        align: align,
        foreground: _foregroundColor,
        style: style,
        shouldAuthenticate: false,
      );

  Widget _buildActiveMessageReply() => DSActiveMessageContentReply(
        activeMessage: DSActiveMessage.fromJson(replyContent.inReplyTo.value),
        align: align,
        foreground: _foregroundColor,
        simpleStyle: simpleStyle,
        style: style,
      );

  Widget _buidLocation() => DSLocationReplyContent(
        location: DSLocation.fromJson(replyContent.inReplyTo.value),
        align: align,
        foreground: _foregroundColor,
        simpleStyle: simpleStyle,
        style: style,
      );

  Widget _buildDefault() => DSInReplyContent(
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
