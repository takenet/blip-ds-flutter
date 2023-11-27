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

  late final List<DSBorderRadius> _startBorderRadius;
  late final List<DSBorderRadius> _middleBorderRadius;
  late final List<DSBorderRadius> _endBorderRadius;

  late final bool _isLeftAligned;
  late final bool _isDefaultBubbleColors;
  late final bool _isLightBubbleBackground;
  late final bool _shouldShowStartBubble;
  late final bool _shouldShowMiddleBubble;
  late final bool _shouldShowEndBubble;
  late final bool _hasButtons;
  late final bool _hasHeaderText;
  late final bool _hasBodyText;
  late final bool _hasFooterText;
  late final bool _hasImageLink;
  late final bool _hasVideoLink;
  late final bool _hasDocumentLink;

  DSInteractiveButtonMessageBubble({
    super.key,
    required this.content,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    this.avatarConfig = const DSMessageBubbleAvatarConfig(),
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle() {
    _initProperties();
    _initBorderRadius();
  }

  void _initProperties() {
    _isLeftAligned = align == DSAlign.left;
    _isDefaultBubbleColors = style.isDefaultBubbleBackground(align);
    _isLightBubbleBackground = style.isLightBubbleBackground(align);

    _hasHeaderText = content.header?.text?.isNotEmpty ?? false;
    _hasImageLink = content.header?.image?.link?.isNotEmpty ?? false;
    _hasVideoLink = content.header?.video?.link?.isNotEmpty ?? false;
    _hasDocumentLink = content.header?.document?.link?.isNotEmpty ?? false;
    _hasButtons = content.action?.buttons?.isNotEmpty ?? false;
    _hasBodyText = content.body?.text?.isNotEmpty ?? false;
    _hasFooterText = content.footer?.text?.isNotEmpty ?? false;

    _shouldShowStartBubble =
        _hasHeaderText || _hasVideoLink || _hasImageLink || _hasDocumentLink;
    _shouldShowMiddleBubble = _hasBodyText || _hasFooterText;
    _shouldShowEndBubble = _hasButtons;
  }

  void _initBorderRadius() {
    final shouldStartBorder = borderRadius.any(
      (border) => [
        DSBorderRadius.all,
        _isLeftAligned ? DSBorderRadius.topLeft : DSBorderRadius.topRight,
      ].contains(border),
    );

    final shouldEndBorder = borderRadius.any(
      (border) => [
        DSBorderRadius.all,
        _isLeftAligned ? DSBorderRadius.bottomLeft : DSBorderRadius.bottomRight,
      ].contains(border),
    );

    _middleBorderRadius = _isLeftAligned
        ? [
            DSBorderRadius.topRight,
            DSBorderRadius.bottomRight,
          ]
        : [
            DSBorderRadius.topLeft,
            DSBorderRadius.bottomLeft,
          ];

    _startBorderRadius = [
      ..._middleBorderRadius,
      if (shouldStartBorder)
        _isLeftAligned ? DSBorderRadius.topLeft : DSBorderRadius.topRight,
    ];

    _endBorderRadius = [
      ..._middleBorderRadius,
      if (shouldEndBorder)
        _isLeftAligned ? DSBorderRadius.bottomLeft : DSBorderRadius.bottomRight,
    ];
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (_shouldShowStartBubble) ...[
            _buildStartBubble(),
            const SizedBox(
              height: 3.0,
            ),
          ],
          if (_shouldShowMiddleBubble) _buildMiddleBubble(),
          const SizedBox(
            height: 3.0,
          ),
          if (_shouldShowEndBubble) _buildEndBubble(),
        ],
      );

  Widget _buildStartBubble() => switch (content.header?.type) {
        DSInteractiveMessageHeaderType.text => _buildHeaderText(),
        DSInteractiveMessageHeaderType.image => _buildImage(),
        DSInteractiveMessageHeaderType.video => _buildVideo(),
        DSInteractiveMessageHeaderType.document => _buildDocument(),
        _ => _buildUnsupportedContent(),
      };

  Widget _buildHeaderText() => _hasHeaderText
      ? DSMessageBubble(
          align: align,
          borderRadius: _shouldShowMiddleBubble || _shouldShowEndBubble
              ? _startBorderRadius
              : borderRadius,
          style: style,
          child: DSHeadlineSmallText(
            content.header!.text!,
            overflow: TextOverflow.visible,
            color: _isLightBubbleBackground
                ? DSColors.neutralDarkCity
                : DSColors.neutralLightSnow,
          ),
        )
      : _buildUnsupportedContent();

  Widget _buildImage() => _hasImageLink
      ? DSImageMessageBubble(
          url: content.header!.image!.link!,
          appBarText: (_isLeftAligned
                  ? avatarConfig.receivedName
                  : avatarConfig.sentName) ??
              '',
          text: content.header?.text,
          align: align,
          borderRadius: _shouldShowMiddleBubble || _shouldShowEndBubble
              ? _startBorderRadius
              : borderRadius,
          style: style,
        )
      : _buildUnsupportedContent();

  Widget _buildVideo() => _hasVideoLink
      ? DSVideoMessageBubble(
          url: content.header!.video!.link!,
          appBarText: (_isLeftAligned
                  ? avatarConfig.receivedName
                  : avatarConfig.sentName) ??
              '',
          mediaSize: 0,
          text: content.header?.text,
          align: align,
          borderRadius: _shouldShowMiddleBubble || _shouldShowEndBubble
              ? _startBorderRadius
              : borderRadius,
          style: style,
        )
      : _buildUnsupportedContent();

  Widget _buildDocument() => _hasDocumentLink
      ? DSFileMessageBubble(
          url: content.header!.document!.link!,
          filename:
              content.header!.document!.filename ?? DSUtils.generateUniqueID(),
          size: 0,
          style: style,
          align: align,
          borderRadius: _shouldShowMiddleBubble || _shouldShowEndBubble
              ? _startBorderRadius
              : borderRadius,
        )
      : _buildUnsupportedContent();

  Widget _buildUnsupportedContent() => DSUnsupportedContentMessageBubble(
        align: align,
        borderRadius: _shouldShowMiddleBubble || _shouldShowEndBubble
            ? _startBorderRadius
            : borderRadius,
        style: style,
      );

  Widget _buildMiddleBubble() => DSMessageBubble(
        align: align,
        borderRadius: _shouldShowStartBubble && _shouldShowEndBubble
            ? _middleBorderRadius
            : _shouldShowStartBubble
                ? _endBorderRadius
                : _shouldShowEndBubble
                    ? _startBorderRadius
                    : borderRadius,
        style: style,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_hasBodyText)
              DSBodyText(
                content.body!.text!,
                overflow: TextOverflow.visible,
                color: _isLightBubbleBackground
                    ? DSColors.neutralDarkCity
                    : DSColors.neutralLightSnow,
              ),
            if (_hasFooterText)
              DSCaptionText(
                content.footer!.text!,
                fontStyle: FontStyle.italic,
                overflow: TextOverflow.visible,
                color: _isLightBubbleBackground
                    ? DSColors.neutralDarkCity
                    : DSColors.neutralLightSnow,
              ),
          ],
        ),
      );

  Widget _buildEndBubble() => DSMessageBubble(
        align: align,
        borderRadius: _shouldShowStartBubble || _shouldShowMiddleBubble
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

    if (_hasButtons) {
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
                    color: _isLightBubbleBackground
                        ? _isDefaultBubbleColors
                            ? DSColors.neutralMediumWave
                            : DSColors.neutralDarkCity
                        : _isDefaultBubbleColors
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
