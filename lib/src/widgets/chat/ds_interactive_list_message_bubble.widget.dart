import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/utils/ds_font_weights.theme.dart';
import '../buttons/ds_menu_item.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';
import '../utils/ds_divider.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSInteractiveListMessageBubble extends StatelessWidget {
  final Map<String, dynamic> content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  final dynamic body;
  final dynamic action;
  final dynamic footer;
  final bool isDefaultBubbleColors;
  final bool isLightBubbleBackground;

  DSInteractiveListMessageBubble({
    super.key,
    required this.content,
    required this.align,
    required this.borderRadius,
    required this.style,
  })  : body = content['body'],
        action = content['action'],
        footer = content['footer'],
        isDefaultBubbleColors = style.isDefaultBubbleBackground(align),
        isLightBubbleBackground = style.isLightBubbleBackground(align);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          DSMessageBubble(
            align: align,
            borderRadius: borderRadius,
            style: style,
            child: _buildHeader(),
          ),
          const SizedBox(
            height: 3.0,
          ),
          DSMessageBubble(
            align: align,
            borderRadius: borderRadius,
            style: style,
            child: _buildList(),
          ),
        ],
      );

  Widget _buildHeader() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DSBodyText(
            body['text'],
            overflow: TextOverflow.visible,
            color: isLightBubbleBackground
                ? isDefaultBubbleColors
                    ? DSColors.primaryNight
                    : DSColors.neutralDarkCity
                : isDefaultBubbleColors
                    ? DSColors.primaryLight
                    : DSColors.neutralLightSnow,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: DSCaptionText(
              footer['text'],
              fontStyle: FontStyle.italic,
              overflow: TextOverflow.visible,
              color: isLightBubbleBackground
                  ? isDefaultBubbleColors
                      ? DSColors.primaryNight
                      : DSColors.neutralDarkCity
                  : isDefaultBubbleColors
                      ? DSColors.primaryLight
                      : DSColors.neutralLightSnow,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 4.0,
                ),
                child: Icon(
                  DSIcons.list_outline,
                  size: 20.0,
                  color: isLightBubbleBackground
                      ? isDefaultBubbleColors
                          ? DSColors.primaryNight
                          : DSColors.neutralDarkCity
                      : isDefaultBubbleColors
                          ? DSColors.primaryLight
                          : DSColors.neutralLightSnow,
                ),
              ),
              DSCaptionText(
                action['button'],
                fontWeight: DSFontWeights.bold,
                overflow: TextOverflow.visible,
                color: isLightBubbleBackground
                    ? isDefaultBubbleColors
                        ? DSColors.primaryNight
                        : DSColors.neutralDarkCity
                    : isDefaultBubbleColors
                        ? DSColors.primaryLight
                        : DSColors.neutralLightSnow,
              ),
            ],
          ),
        ],
      );

  Widget _buildList() {
    final widgets = <Widget>[];

    for (final section in action['sections']) {
      final rows = section['rows'] as List<dynamic>;
      var count = 1;

      for (final row in rows) {
        widgets.add(
          DSMenuItem(
            text: row['title'],
            align: align,
            style: style,
            showBorder: count != rows.length,
          ),
        );

        ++count;
      }
    }

    return Column(
      children: widgets,
    );
  }
}
