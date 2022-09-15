import 'dart:convert';

import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSSelectMenu extends StatelessWidget {
  final DSAlign align;
  final Map<String, dynamic> content;
  final Function? onSelected;

  const DSSelectMenu({
    Key? key,
    required this.align,
    required this.content,
    this.onSelected,
  }) : super(key: key);

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
    final List<Widget> children = [];

    int count = 0;

    content['options'].forEach(
      (dynamic option) {
        count++;

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
              color: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DSHeadlineSmallText(
                    text: option['text'],
                    color: align == DSAlign.left
                        ? DSColors.primaryNight
                        : DSColors.primaryLight,
                  ),
                ],
              ),
            ),
          ),
        );

        if (count != content['options'].length) {
          children.add(
            Divider(
              height: 30.0,
              thickness: 1.0,
              color: align == DSAlign.left
                  ? DSColors.neutralMediumWave
                  : DSColors.neutralDarkRooftop,
            ),
          );
        } else {
          children.add(
            const SizedBox(
              height: 12.0,
            ),
          );
        }
      },
    );

    return children;
  }
}
