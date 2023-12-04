import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_select_option.model.dart';
import '../../utils/ds_message_content_type.util.dart';
import '../buttons/ds_menu_item.widget.dart';

class DSSelectMenu extends StatelessWidget {
  final DSAlign align;
  final Map<String, dynamic> content;
  final void Function(String, Map<String, dynamic>)? onSelected;
  final DSMessageBubbleStyle style;

  DSSelectMenu({
    super.key,
    required this.align,
    required this.content,
    this.onSelected,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    final options = _getOptions();

    return Visibility(
      visible: options.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Column(
          children: options,
        ),
      ),
    );
  }

  List<Widget> _getOptions() {
    final List<Widget> children = [];

    int count = 0;

    final options = (content['options'] as List?)
        ?.map(
          (doc) => DSSelectOption.fromJson(doc),
        )
        .toList();

    if (options != null) {
      for (final option in options) {
        count++;

        children.add(
          DSMenuItem(
            text: option.text,
            align: align,
            showDivider: count != content['options'].length,
            onPressed: () {
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
            style: style,
          ),
        );
      }
    }

    return children;
  }
}
