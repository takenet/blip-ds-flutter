import 'dart:convert';

import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSQuickReply extends StatelessWidget {
  final DSAlign align;
  final dynamic content;
  final Function? onSelected;

  const DSQuickReply({
    Key? key,
    required this.align,
    this.content,
    this.onSelected,
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
          borderRadius: align == DSAlign.left
              ? [
                  DSBorderRadius.topLeft,
                  DSBorderRadius.topRight,
                  DSBorderRadius.bottomRight,
                ]
              : [
                  DSBorderRadius.topLeft,
                  DSBorderRadius.topRight,
                  DSBorderRadius.bottomLeft,
                ],
        ),
        // Row(
        //   mainAxisAlignment: align == DSAlign.right
        //       ? MainAxisAlignment.end
        //       : MainAxisAlignment.start,
        //   children: align == DSAlign.right
        //       ? [const Spacer(), _buildQuickReply()]
        //       : [_buildQuickReply(), const Spacer()],
        // )
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _buildQuickReply(),
        )
      ],
    );
  }

  Widget _buildQuickReply() {
    List<DSBorderRadius> borderRadius = [];
    List<Widget> children = [];

    borderRadius = [];

    content['options'].forEach(
      (dynamic option) {
        children.add(
          GestureDetector(
            onTap: () {
              if (onSelected != null) {
                var object = {};

                if (option.containsKey('value')) {
                  String type = option['type'];
                  object = {
                    "type": type,
                    "content": type.contains('json')
                        ? jsonDecode(option['value'])
                        : option['value']
                  };
                } else {
                  object = {
                    "type": 'text/plain',
                    "content": option.containsKey('order')
                        ? option['order'].toString()
                        : option['text']
                  };
                }

                onSelected!(option['text'], object);
              }
            },
            child: Chip(
              backgroundColor: DSColors.primaryLight,
              label: DSBodyText(
                text: option['text'],
                fontWeight: DSFontWeights.semiBold,
              ),
              autofocus: false,
              clipBehavior: Clip.none,
            ),
            // child: Container(
            //   margin: const EdgeInsets.all(5.0),
            //   height: 40.0,
            //   decoration: BoxDecoration(
            //     color: DSColors.primaryLight,
            //     borderRadius: borderRadius.getCircularBorderRadius(
            //       maxRadius: 22.0,
            //       minRadius: 2.0,
            //     ),
            //   ),
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            //     child: DSBodyText(
            //       text: option['text'],
            //       fontWeight: DSFontWeights.semiBold,
            //     ),
            //   ),
            // ),
          ),
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Wrap(
        spacing: 10.0,
        alignment:
            align == DSAlign.left ? WrapAlignment.start : WrapAlignment.end,
        children: children,
      ),
    );
  }
}
