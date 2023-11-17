import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/icons/ds_icons.dart';
import '../texts/ds_body_text.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSInteractiveListMessageBubble extends StatelessWidget {
  final Map<String, dynamic> content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  final dynamic body;
  final dynamic action;
  final dynamic footer;

  DSInteractiveListMessageBubble({
    super.key,
    required this.content,
    required this.align,
    required this.borderRadius,
    required this.style,
  })  : body = content['body'],
        action = content['action'],
        footer = content['footer'];

  @override
  Widget build(BuildContext context) => Column(
        children: [
          DSMessageBubble(
            align: align,
            borderRadius: borderRadius,
            style: style,
            child: Column(
              children: [
                DSBodyText(
                  body['text'],
                  overflow: TextOverflow.visible,
                ),
                DSBodyText(
                  footer['text'],
                  overflow: TextOverflow.visible,
                ),
                Row(
                  children: [
                    const Icon(DSIcons.list_outline),
                    DSBodyText(
                      action['button'],
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ],
            ),
          ),
          DSMessageBubble(
            align: align,
            borderRadius: borderRadius,
            style: style,
            child: Column(
              children: [
                DSBodyText(
                  action['button'],
                  overflow: TextOverflow.visible,
                ),
                for (var section in action['sections'])
                  for (var row in section['rows'])
                    DSBodyText(
                      row['title'],
                      overflow: TextOverflow.visible,
                    ),
              ],
            ),
          ),
        ],
      );
}
