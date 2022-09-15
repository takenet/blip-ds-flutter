import 'dart:convert';

import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSQuickReply extends StatelessWidget {
  final DSAlign align;
  final Map<String, dynamic> content;
  final Function? onSelected;
  final bool hideOptions;

  const DSQuickReply({
    Key? key,
    required this.align,
    required this.content,
    this.onSelected,
    this.hideOptions = false,
  }) : super(key: key);

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

    content['options'].forEach(
      (dynamic option) {
        children.add(
          GestureDetector(
            onTap: () {
              if (onSelected != null) {
                Map<String, dynamic> payload = {};

                if (option.containsKey('value')) {
                  String type = option['type'];
                  payload = {
                    "type": type,
                    "content": type.contains('json')
                        ? jsonDecode(option['value'])
                        : option['value']
                  };
                } else {
                  payload = {
                    "type": 'text/plain',
                    "content": option.containsKey('order')
                        ? option['order'].toString()
                        : option['text']
                  };
                }

                onSelected!(option['text'], payload);
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
                      text: option['text'],
                      fontWeight: DSFontWeights.semiBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

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
