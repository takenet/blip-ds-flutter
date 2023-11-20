import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/interactive_list_message/ds_interactive_list_message.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/utils/ds_font_weights.theme.dart';
import '../buttons/ds_menu_item.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';
import '../utils/ds_divider.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSInteractiveListMessageBubble extends StatelessWidget {
  final DSInteractiveListMessage content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  final bool isDefaultBubbleColors;
  final bool isLightBubbleBackground;

  final bool hasBodyText;
  final bool hasFooterText;
  final bool hasButtonText;
  final bool hasSections;

  DSInteractiveListMessageBubble({
    super.key,
    required this.content,
    required this.align,
    required this.borderRadius,
    required this.style,
  })  : isDefaultBubbleColors = style.isDefaultBubbleBackground(align),
        isLightBubbleBackground = style.isLightBubbleBackground(align),
        hasBodyText = content.body?.text?.isNotEmpty ?? false,
        hasFooterText = content.footer?.text?.isNotEmpty ?? false,
        hasButtonText = content.action?.button?.isNotEmpty ?? false,
        hasSections = content.action?.sections?.isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          DSMessageBubble(
            align: align,
            borderRadius: [
              ...(borderRadius.contains(DSBorderRadius.all)
                  ? [
                      DSBorderRadius.topLeft,
                      DSBorderRadius.topRight,
                    ]
                  : borderRadius),
              align == DSAlign.left
                  ? DSBorderRadius.bottomRight
                  : DSBorderRadius.bottomLeft,
            ],
            style: style,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._buildHeaderText(),
                _buildHeaderButton(),
              ],
            ),
          ),
          const SizedBox(
            height: 3.0,
          ),
          DSMessageBubble(
            align: align,
            borderRadius: [
              ...(borderRadius.contains(DSBorderRadius.all)
                  ? [
                      DSBorderRadius.bottomLeft,
                      DSBorderRadius.bottomRight,
                    ]
                  : borderRadius),
              align == DSAlign.left
                  ? DSBorderRadius.topRight
                  : DSBorderRadius.topLeft,
            ],
            style: style,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildList(),
            ),
          ),
        ],
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
          child: DSBodyText(content.body!.text,
              overflow: TextOverflow.visible,
              color: isLightBubbleBackground
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow),
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
        var count = 1;

        if (section.title?.isNotEmpty ?? false) {
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
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

        if (section.rows?.isNotEmpty ?? false) {
          for (final row in section.rows!) {
            if (row.title?.isNotEmpty ?? false) {
              widgets.add(
                DSMenuItem(
                  text: row.title!,
                  align: align,
                  style: style,
                  showBorder: count != section.rows!.length,
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
