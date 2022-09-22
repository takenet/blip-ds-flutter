import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/models/ds_select_option.model.dart';
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

    List options = content['options']
        .map((doc) => DSSelectOptionModel.fromJson(doc))
        .toList();

    for (var option in options) {
      count++;

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
                  "type": 'text/plain',
                  "content": option.order != null
                      ? option.order.toString()
                      : option.text
                };
              }

              onSelected!(option.text, payload);
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DSHeadlineSmallText(
                  text: option.text,
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
    }

    return children;
  }
}
