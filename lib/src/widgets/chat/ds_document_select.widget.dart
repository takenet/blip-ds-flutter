import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../models/ds_document_select.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../utils/ds_message_content_type.util.dart';
import '../buttons/ds_menu_item.widget.dart';

/// A Design System widget used to display a select menu with image.
class DSDocumentSelect extends StatelessWidget {
  /// Message bubble align
  final DSAlign align;

  /// List of [DSDocumentSelectOption] to display the select menu options
  final List<DSDocumentSelectOption> options;

  /// Function to execute when the options type is [DSMessageContentType.textPlain]
  final void Function(String, Map<String, dynamic>)? onSelected;

  /// Function to execute when the options type is [DSMessageContentType.webLink]
  final void Function(Map<String, dynamic> payload)? onOpenLink;

  final DSMessageBubbleStyle style;

  /// Creates a new Design System's [DSDocumentSelect]
  DSDocumentSelect({
    super.key,
    required this.align,
    required this.options,
    this.onSelected,
    this.onOpenLink,
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        children: _buildSelectMenu(),
      ),
    );
  }

  List<Widget> _buildSelectMenu() {
    final children = <Widget>[];

    int count = 0;

    for (var option in options) {
      count++;

      children.add(
        DSMenuItem(
          text: option.label.type == 'text/plain'
              ? option.label.value
              : option.label.value['text'],
          align: align,
          showDivider: count != options.length,
          onPressed: () {
            if (option.label.type == DSMessageContentType.webLink) {
              if (onOpenLink != null) {
                onOpenLink?.call(
                  {
                    "uri": option.label.value['uri'],
                    "target": option.label.value['target'],
                    "title": option.label.value['title'] ??
                        option.label.value['text'],
                  },
                );
              }
            } else if (onSelected != null) {
              var payload = <String, dynamic>{};

              if (option.value != null) {
                payload = {
                  "type": option.value!.type,
                  "content": option.value!.value
                };
              } else {
                payload = {"type": 'text/plain', "content": option.label.value};
              }

              onSelected?.call(option.label.value, payload);
            }
          },
          style: style,
        ),
      );
    }

    return children;
  }
}
