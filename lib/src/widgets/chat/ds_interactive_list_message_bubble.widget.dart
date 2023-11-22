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

  late final bool isDefaultBubbleColors;
  late final bool isLightBubbleBackground;

  final bool hasBodyText;
  final bool hasFooterText;
  final bool hasButtonText;
  final bool hasSections;

  DSInteractiveListMessageBubble({
    super.key,
    required this.content,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        hasBodyText = content.body?.text?.isNotEmpty ?? false,
        hasFooterText = content.footer?.text?.isNotEmpty ?? false,
        hasButtonText = content.action?.button?.isNotEmpty ?? false,
        hasSections = content.action?.sections?.isNotEmpty ?? false {
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
          if (hasBodyText || hasFooterText || hasButtonText)
            _buildHeaderBubble(),
          const SizedBox(
            height: 3.0,
          ),
          if (hasSections) _buildListBubble(),
        ],
      );

  Widget _buildHeaderBubble() => DSMessageBubble(
        align: align,
        borderRadius: hasSections ? _startBorderRadius : borderRadius,
        style: style,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildHeaderText(),
            _buildHeaderButton(),
          ],
        ),
      );

  Widget _buildListBubble() => DSMessageBubble(
        align: align,
        borderRadius: hasBodyText || hasFooterText || hasButtonText
            ? _endBorderRadius
            : borderRadius,
        style: style,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildList(),
        ),
      );

  List<Widget> _buildHeaderText() {
    const bottomPadding = 8.0;
    final widgets = <Widget>[];

    if (hasBodyText) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(
            bottom: bottomPadding,
          ),
          child: DSBodyText(
            content.body!.text,
            overflow: TextOverflow.visible,
            color: isLightBubbleBackground
                ? DSColors.neutralDarkCity
                : DSColors.neutralLightSnow,
          ),
        ),
      );
    }

    if (hasFooterText) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(
            bottom: bottomPadding,
          ),
          child: DSCaptionText(
            content.footer!.text,
            fontStyle: FontStyle.italic,
            overflow: TextOverflow.visible,
            color: isLightBubbleBackground
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
            color: isLightBubbleBackground
                ? isDefaultBubbleColors
                    ? DSColors.neutralMediumWave
                    : DSColors.neutralDarkCity
                : isDefaultBubbleColors
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
              right: hasButtonText ? 4.0 : 0.0,
            ),
            child: Icon(
              DSIcons.list_outline,
              size: 20.0,
              color: isLightBubbleBackground
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow,
            ),
          ),
          if (hasButtonText)
            DSCaptionText(
              content.action!.button,
              fontWeight: DSFontWeights.bold,
              overflow: TextOverflow.visible,
              color: isLightBubbleBackground
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow,
            ),
        ],
      );

  List<Widget> _buildList() {
    final widgets = <Widget>[];

    if (hasSections) {
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
                color: isLightBubbleBackground
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
