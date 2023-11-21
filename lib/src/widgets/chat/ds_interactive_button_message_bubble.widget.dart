import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../enums/ds_interactive_message_header_type.enum.dart';
import '../../models/ds_message_bubble_avatar_config.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/interactive_message/ds_interactive_message.model.dart';
import '../../utils/ds_utils.util.dart';
import '../buttons/ds_menu_item.widget.dart';
import 'ds_file_message_bubble.widget.dart';
import 'ds_image_message_bubble.widget.dart';
import 'ds_message_bubble.widget.dart';
import 'ds_text_message_bubble.widget.dart';
import 'ds_unsupported_content_message_bubble.widget.dart';
import 'video/ds_video_message_bubble.widget.dart';

class DSInteractiveButtonMessageBubble extends StatelessWidget {
  final DSInteractiveMessage content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleAvatarConfig avatarConfig;
  final DSMessageBubbleStyle style;

  late final bool isDefaultBubbleColors;
  late final bool isLightBubbleBackground;

  final bool hasHeaderText;
  final bool hasImageLink;
  final bool hasVideoLink;
  final bool hasDocumentLink;
  final bool hasButtons;

  DSInteractiveButtonMessageBubble({
    super.key,
    required this.content,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    this.avatarConfig = const DSMessageBubbleAvatarConfig(),
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        hasHeaderText = content.header?.text?.isNotEmpty ?? false,
        hasImageLink = content.header?.image?.link?.isNotEmpty ?? false,
        hasVideoLink = content.header?.video?.link?.isNotEmpty ?? false,
        hasDocumentLink = content.header?.document?.link?.isNotEmpty ?? false,
        hasButtons = content.action?.buttons?.isNotEmpty ?? false {
    isDefaultBubbleColors = this.style.isDefaultBubbleBackground(align);
    isLightBubbleBackground = this.style.isLightBubbleBackground(align);
  }

  List<DSBorderRadius> get _headerBorderRadius => [
        ...(borderRadius.contains(DSBorderRadius.all)
            ? [
                DSBorderRadius.topLeft,
                DSBorderRadius.topRight,
              ]
            : borderRadius),
        align == DSAlign.left
            ? DSBorderRadius.bottomRight
            : DSBorderRadius.bottomLeft,
      ];

  List<DSBorderRadius> get _buttonsBorderRadius => [
        ...(borderRadius.contains(DSBorderRadius.all)
            ? [
                DSBorderRadius.bottomLeft,
                DSBorderRadius.bottomRight,
              ]
            : borderRadius),
        align == DSAlign.left
            ? DSBorderRadius.topRight
            : DSBorderRadius.topLeft,
      ];

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _buildHeaderBubble(),
          const SizedBox(
            height: 3.0,
          ),
          _buildButtonsBubble(),
        ],
      );

  Widget _buildHeaderBubble() => switch (content.header?.type) {
        DSInteractiveMessageHeaderType.text => _buildText(),
        DSInteractiveMessageHeaderType.image => _buildImage(),
        DSInteractiveMessageHeaderType.video => _buildVideo(),
        DSInteractiveMessageHeaderType.document => _buildDocument(),
        _ => _buildUnsupportedContent(),
      };

  Widget _buildText() => hasHeaderText
      ? DSTextMessageBubble(
          text: content.header!.text!,
          align: align,
          borderRadius: _headerBorderRadius,
          style: style,
        )
      : _buildUnsupportedContent();

  Widget _buildImage() => hasImageLink
      ? DSImageMessageBubble(
          url: content.header!.image!.link!,
          appBarText: (align == DSAlign.left
                  ? avatarConfig.receivedName
                  : avatarConfig.sentName) ??
              '',
          text: content.header?.text,
          align: align,
          borderRadius: _headerBorderRadius,
          style: style,
        )
      : _buildUnsupportedContent();

  Widget _buildVideo() => hasVideoLink
      ? DSVideoMessageBubble(
          url: content.header!.video!.link!,
          appBarText: (align == DSAlign.left
                  ? avatarConfig.receivedName
                  : avatarConfig.sentName) ??
              '',
          mediaSize: 0,
          text: content.header?.text,
          align: align,
          borderRadius: _headerBorderRadius,
          style: style,
        )
      : _buildUnsupportedContent();

  Widget _buildDocument() => hasDocumentLink
      ? DSFileMessageBubble(
          url: content.header!.document!.link!,
          filename:
              content.header!.document!.filename ?? DSUtils.generateUniqueID(),
          size: 0,
          style: style,
          align: align,
          borderRadius: _headerBorderRadius,
        )
      : _buildUnsupportedContent();

  Widget _buildUnsupportedContent() => DSUnsupportedContentMessageBubble(
        align: align,
        borderRadius: _headerBorderRadius,
        style: style,
      );

  Widget _buildButtonsBubble() => DSMessageBubble(
        align: align,
        borderRadius: _buttonsBorderRadius,
        style: style,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildButtons(),
        ),
      );

  List<Widget> _buildButtons() {
    final widgets = <Widget>[];

    if (hasButtons) {
      var count = 1;

      for (final button in content.action!.buttons!) {
        final hasTitle = button.title?.isNotEmpty ?? false;

        if (hasTitle) {
          widgets.add(
            DSMenuItem(
              text: button.title!,
              align: align,
              style: style,
              showBorder: count != content.action!.buttons!.length,
            ),
          );
        }

        ++count;
      }
    }

    return widgets;
  }
}
