import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../enums/ds_interactive_message_header_type.enum.dart';
import '../../models/ds_message_bubble_avatar_config.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/interactive_message/ds_interactive_message.model.dart';
import '../../utils/ds_utils.util.dart';
import 'ds_file_message_bubble.widget.dart';
import 'ds_image_message_bubble.widget.dart';
import 'ds_text_message_bubble.widget.dart';
import 'ds_unsupported_content_message_bubble.widget.dart';
import 'video/ds_video_message_bubble.widget.dart';

class DSInteractiveButtonMessageBubble extends StatelessWidget {
  final DSInteractiveMessage content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final DSMessageBubbleAvatarConfig avatarConfig;

  final bool isDefaultBubbleColors;
  final bool isLightBubbleBackground;

  DSInteractiveButtonMessageBubble({
    super.key,
    required this.content,
    required this.align,
    required this.borderRadius,
    required this.style,
    this.avatarConfig = const DSMessageBubbleAvatarConfig(),
  })  : isDefaultBubbleColors = style.isDefaultBubbleBackground(align),
        isLightBubbleBackground = style.isLightBubbleBackground(align);

  @override
  Widget build(BuildContext context) => switch (content.header?.type) {
        DSInteractiveMessageHeaderType.text => _buildText(),
        DSInteractiveMessageHeaderType.image => _buildImage(),
        DSInteractiveMessageHeaderType.document => _buildDocument(),
        DSInteractiveMessageHeaderType.video => _buildVideo(),
        _ => _buildUnsupportedContent(),
      };

  Widget _buildText() => content.header?.text?.isNotEmpty ?? false
      ? DSTextMessageBubble(
          text: content.header!.text!,
          align: align,
          borderRadius: borderRadius,
          style: style,
        )
      : _buildUnsupportedContent();

  Widget _buildImage() => content.header?.image?.link?.isNotEmpty ?? false
      ? DSImageMessageBubble(
          url: content.header!.image!.link!,
          appBarText: (align == DSAlign.left
                  ? avatarConfig.receivedName
                  : avatarConfig.sentName) ??
              '',
          text: content.header?.text,
          align: align,
          borderRadius: borderRadius,
          style: style,
        )
      : _buildUnsupportedContent();

  Widget _buildDocument() => content.header?.document?.link?.isNotEmpty ?? false
      ? DSFileMessageBubble(
          url: content.header!.document!.link!,
          filename:
              content.header!.document!.filename ?? DSUtils.generateUniqueID(),
          size: 0,
          style: style,
          align: align,
          borderRadius: borderRadius,
        )
      : _buildUnsupportedContent();

  Widget _buildVideo() => content.header?.video?.link?.isNotEmpty ?? false
      ? DSVideoMessageBubble(
          url: content.header!.video!.link!,
          appBarText: (align == DSAlign.left
                  ? avatarConfig.receivedName
                  : avatarConfig.sentName) ??
              '',
          mediaSize: 0,
          text: content.header?.text,
          align: align,
          borderRadius: borderRadius,
          style: style,
        )
      : _buildUnsupportedContent();

  Widget _buildUnsupportedContent() => DSUnsupportedContentMessageBubble(
        align: align,
        borderRadius: borderRadius,
        style: style,
      );
}
