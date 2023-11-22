import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../enums/ds_interactive_message_header_type.enum.dart';
import '../../models/ds_message_bubble_avatar_config.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/interactive_message/ds_interactive_message.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../utils/ds_utils.util.dart';
import '../buttons/ds_menu_item.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';
import '../texts/ds_headline_small_text.widget.dart';
import '../utils/ds_divider.widget.dart';
import 'ds_file_message_bubble.widget.dart';
import 'ds_image_message_bubble.widget.dart';
import 'ds_message_bubble.widget.dart';
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

  final bool hasButtons;
  final bool hasHeaderText;
  final bool hasBodyText;
  final bool hasFooterText;
  final bool hasImageLink;
  final bool hasVideoLink;
  final bool hasDocumentLink;

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
        hasButtons = content.action?.buttons?.isNotEmpty ?? false,
        hasBodyText = content.body?.text?.isNotEmpty ?? false,
        hasFooterText = content.footer?.text?.isNotEmpty ?? false {
    isDefaultBubbleColors = this.style.isDefaultBubbleBackground(align);
    isLightBubbleBackground = this.style.isLightBubbleBackground(align);
  }

  List<DSBorderRadius> get _startBorderRadius => [
        DSBorderRadius.topLeft,
        align == DSAlign.left
            ? DSBorderRadius.bottomRight
            : DSBorderRadius.bottomLeft,
        if (borderRadius.any((border) => [
              DSBorderRadius.all,
              DSBorderRadius.topRight,
            ].contains(border)))
          DSBorderRadius.topRight,
      ];

  List<DSBorderRadius> get _midBorderRadius => align == DSAlign.left
      ? [
          DSBorderRadius.topRight,
          DSBorderRadius.bottomRight,
        ]
      : [
          DSBorderRadius.topLeft,
          DSBorderRadius.bottomLeft,
        ];

  List<DSBorderRadius> get _endBorderRadius => [
        DSBorderRadius.bottomLeft,
        align == DSAlign.left
            ? DSBorderRadius.topRight
            : DSBorderRadius.topLeft,
        if (borderRadius.any((border) => [
              DSBorderRadius.all,
              DSBorderRadius.bottomRight,
            ].contains(border)))
          DSBorderRadius.bottomRight,
      ];

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (hasHeaderText) ...[
            _buildHeaderBubble(),
            const SizedBox(
              height: 3.0,
            ),
          ],
          if (hasBodyText || hasFooterText) _buildBodyBubble(),
          const SizedBox(
            height: 3.0,
          ),
          if (hasButtons) _buildButtonsBubble(),
        ],
      );

  Widget _buildHeaderBubble() => switch (content.header?.type) {
        DSInteractiveMessageHeaderType.text => _buildHeaderText(),
        DSInteractiveMessageHeaderType.image => _buildImage(),
        DSInteractiveMessageHeaderType.video => _buildVideo(),
        DSInteractiveMessageHeaderType.document => _buildDocument(),
        _ => _buildUnsupportedContent(),
      };

  Widget _buildHeaderText() => hasHeaderText
      ? DSMessageBubble(
          align: align,
          borderRadius: hasBodyText || hasFooterText || hasButtons
              ? _startBorderRadius
              : borderRadius,
          style: style,
          child: DSHeadlineSmallText(
            content.header!.text!,
            overflow: TextOverflow.visible,
            color: isLightBubbleBackground
                ? DSColors.neutralDarkCity
                : DSColors.neutralLightSnow,
          ),
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
          borderRadius: _startBorderRadius,
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
          borderRadius: _startBorderRadius,
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
          borderRadius: _startBorderRadius,
        )
      : _buildUnsupportedContent();

  Widget _buildUnsupportedContent() => DSUnsupportedContentMessageBubble(
        align: align,
        borderRadius: _startBorderRadius,
        style: style,
      );

  Widget _buildBodyBubble() => DSMessageBubble(
        align: align,
        borderRadius: hasHeaderText && hasButtons
            ? _midBorderRadius
            : hasHeaderText
                ? _endBorderRadius
                : hasButtons
                    ? _startBorderRadius
                    : borderRadius,
        style: style,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasBodyText)
              DSBodyText(
                content.body!.text!,
                overflow: TextOverflow.visible,
                color: isLightBubbleBackground
                    ? DSColors.neutralDarkCity
                    : DSColors.neutralLightSnow,
              ),
            if (hasFooterText)
              DSCaptionText(
                content.footer!.text!,
                fontStyle: FontStyle.italic,
                overflow: TextOverflow.visible,
                color: isLightBubbleBackground
                    ? DSColors.neutralDarkCity
                    : DSColors.neutralLightSnow,
              ),
          ],
        ),
      );

  Widget _buildButtonsBubble() => DSMessageBubble(
        align: align,
        borderRadius: hasHeaderText || hasBodyText || hasFooterText
            ? _endBorderRadius
            : borderRadius,
        style: style,
        shouldUseDefaultSize: true,
        child: Column(
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
          widgets.addAll(
            [
              DSMenuItem(
                text: button.title!,
                align: align,
                style: style,
                showDivider: false,
              ),
              if (count != content.action!.buttons!.length)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 1.0,
                  ),
                  child: DSDivider(
                    color: isLightBubbleBackground
                        ? isDefaultBubbleColors
                            ? DSColors.neutralMediumWave
                            : DSColors.neutralDarkCity
                        : isDefaultBubbleColors
                            ? DSColors.neutralDarkRooftop
                            : DSColors.neutralLightSnow,
                  ),
                ),
            ],
          );
        }

        ++count;
      }
    }

    return widgets;
  }
}
