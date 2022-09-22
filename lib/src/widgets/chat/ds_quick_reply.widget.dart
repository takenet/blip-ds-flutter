import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_select_option.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/texts/utils/ds_font_weights.theme.dart';
import '../../utils/ds_message_content_type.util.dart';
import '../texts/ds_body_text.widget.dart';
import 'ds_text_message_bubble.widget.dart';

class DSQuickReply extends StatelessWidget {
  final DSAlign align;
  final Map<String, dynamic> content;
  final Function? onSelected;
  final bool hideOptions;
  final DSMessageBubbleStyle style;

  DSQuickReply({
    Key? key,
    required this.align,
    required this.content,
    this.onSelected,
    this.hideOptions = false,
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align == DSAlign.left
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        DSTextMessageBubble(
          text: content['text'],
          align: align,
          style: style,
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: _buildQuickReply(),
        )
      ],
    );
  }

  Widget _buildQuickReply() {
    return hideOptions ? const SizedBox() : _buildItems();
  }

  Widget _buildItems() {
    List<DSBorderRadius> borderRadius = [];
    List<Widget> children = [];

    borderRadius = [];

    List options = content['options']
        .map((doc) => DSSelectOptionModel.fromJson(doc))
        .toList();

    for (var option in options) {
      children.add(
        GestureDetector(
          onTap: () {
            if (onSelected != null) {
              Map<String, dynamic> payload = {};

              if (option.value != null) {
                String type = option.type!;
                payload = {"type": type, "content": option.value};
              } else {
                payload = {
                  "type": DSMessageContentType.textPlain,
                  "content": option.order != null
                      ? option.order.toString()
                      : option.text
                };
              }

              onSelected!(option.text, payload);
            }
          },
          child: Container(
            constraints: const BoxConstraints(minWidth: 44.0),
            margin: const EdgeInsets.all(2.0),
            height: 44.0,
            decoration: BoxDecoration(
              color: DSColors.primaryLight,
              borderRadius: borderRadius.getCircularBorderRadius(
                maxRadius: 22.0,
                minRadius: 2.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: DSBodyText(
                    option.text,
                    fontWeight: DSFontWeights.semiBold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 8.0,
          alignment: WrapAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
