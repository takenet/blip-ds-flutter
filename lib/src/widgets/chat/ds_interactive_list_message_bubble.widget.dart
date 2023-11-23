import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/interactive_message/ds_interactive_message.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/utils/ds_font_weights.theme.dart';
import '../buttons/ds_menu_item.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';
import '../utils/ds_divider.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSInteractiveListMessageBubble extends StatelessWidget {
  final DSInteractiveMessage content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  late final List<DSBorderRadius> _startBorderRadius;
  late final List<DSBorderRadius> _endBorderRadius;

  late final bool _isLeftAligned;
  late final bool _isDefaultBubbleColors;
  late final bool _isLightBubbleBackground;
  late final bool _shouldShowStartBubble;
  late final bool _shouldShowEndBubble;
  late final bool _hasBodyText;
  late final bool _hasFooterText;
  late final bool _hasButtonText;
  late final bool _hasSections;

  DSInteractiveListMessageBubble({
    super.key,
    required this.content,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle() {
    _initProperties();
    _initBorderRadius();
  }

  void _initProperties() {
    _isLeftAligned = align == DSAlign.left;
    _isDefaultBubbleColors = style.isDefaultBubbleBackground(align);
    _isLightBubbleBackground = style.isLightBubbleBackground(align);

    _hasBodyText = content.body?.text?.isNotEmpty ?? false;
    _hasFooterText = content.footer?.text?.isNotEmpty ?? false;
    _hasButtonText = content.action?.button?.isNotEmpty ?? false;
    _hasSections = content.action?.sections?.isNotEmpty ?? false;

    _shouldShowStartBubble = _hasBodyText || _hasFooterText || _hasButtonText;
    _shouldShowEndBubble = _hasSections;
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

    final defaultBorderRadius = _isLeftAligned
        ? [
            DSBorderRadius.topRight,
            DSBorderRadius.bottomRight,
          ]
        : [
            DSBorderRadius.topLeft,
            DSBorderRadius.bottomLeft,
          ];

    _startBorderRadius = [
      ...defaultBorderRadius,
      if (shouldStartBorder)
        _isLeftAligned ? DSBorderRadius.topLeft : DSBorderRadius.topRight,
    ];

    _endBorderRadius = [
      ...defaultBorderRadius,
      if (shouldEndBorder)
        _isLeftAligned ? DSBorderRadius.bottomLeft : DSBorderRadius.bottomRight,
    ];
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (_shouldShowStartBubble) _buildStartBubble(),
          const SizedBox(
            height: 3.0,
          ),
          if (_shouldShowEndBubble) _buildEndBubble(),
        ],
      );

  Widget _buildStartBubble() => DSMessageBubble(
        align: align,
        borderRadius: _shouldShowEndBubble ? _startBorderRadius : borderRadius,
        style: style,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildHeaderText(),
            _buildHeaderButton(),
          ],
        ),
      );

  Widget _buildEndBubble() => DSMessageBubble(
        align: align,
        borderRadius: _shouldShowStartBubble ? _endBorderRadius : borderRadius,
        style: style,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildList(),
        ),
      );

  List<Widget> _buildHeaderText() {
    const bottomPadding = 8.0;
    final widgets = <Widget>[];

    if (_hasBodyText) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(
            bottom: bottomPadding,
          ),
          child: DSBodyText(
            content.body!.text,
            overflow: TextOverflow.visible,
            color: _isLightBubbleBackground
                ? DSColors.neutralDarkCity
                : DSColors.neutralLightSnow,
          ),
        ),
      );
    }

    if (_hasFooterText) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(
            bottom: bottomPadding,
          ),
          child: DSCaptionText(
            content.footer!.text,
            fontStyle: FontStyle.italic,
            overflow: TextOverflow.visible,
            color: _isLightBubbleBackground
                ? DSColors.neutralDarkCity
                : DSColors.neutralLightSnow,
          ),
        ),
      );
    }

    if (widgets.isNotEmpty) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(
            bottom: bottomPadding,
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
      );
    }

    return widgets;
  }

  Widget _buildHeaderButton() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: _hasButtonText ? 4.0 : 0.0,
            ),
            child: Icon(
              DSIcons.list_outline,
              size: 20.0,
              color: _isLightBubbleBackground
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow,
            ),
          ),
          if (_hasButtonText)
            DSCaptionText(
              content.action!.button,
              fontWeight: DSFontWeights.bold,
              overflow: TextOverflow.visible,
              color: _isLightBubbleBackground
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow,
            ),
        ],
      );

  List<Widget> _buildList() {
    final widgets = <Widget>[];

    if (_hasSections) {
      for (final section in content.action!.sections!) {
        final hasRows = section.rows?.isNotEmpty ?? false;
        final hasSectionTitle = section.title?.isNotEmpty ?? false;

        if (hasSectionTitle) {
          widgets.add(
            Padding(
              padding: EdgeInsets.only(
                bottom: hasRows ? 8.0 : 0.0,
              ),
              child: DSBodyText(
                section.title!,
                overflow: TextOverflow.visible,
                color: _isLightBubbleBackground
                    ? DSColors.neutralDarkCity
                    : DSColors.neutralLightSnow,
              ),
            ),
          );
        }

        if (hasRows) {
          var count = 1;

          for (final row in section.rows!) {
            final hasRowTitle = row.title?.isNotEmpty ?? false;

            if (hasRowTitle) {
              widgets.add(
                DSMenuItem(
                  text: row.title!,
                  align: align,
                  style: style,
                  showDivider: count != section.rows!.length,
                ),
              );
            }

            ++count;
          }
        }
      }
    }

    return widgets;
  }
}
