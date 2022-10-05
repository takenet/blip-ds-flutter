import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import '../../models/ds_document_select.model.dart';
import '../../utils/ds_message_content_type.util.dart';

/// A Design System widget used to display a select menu with image.
class DSDocumentSelect extends StatelessWidget {
  /// Message bubble align
  final DSAlign align;

  /// List of [DSDocumentSelectOption] to display the select menu options
  final List<DSDocumentSelectOption> options;

  /// Function to execute when the options type is [DSMessageContentType.textPlain]
  final Function? onSelected;

  /// Function to execute when the options type is [DSMessageContentType.webLink]
  final void Function(Map<String, dynamic> payload)? onOpenLink;

  /// Creates a new Design System's [DSDocumentSelect]
  const DSDocumentSelect({
    Key? key,
    required this.align,
    required this.options,
    this.onSelected,
    this.onOpenLink,
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
    final children = <Widget>[];

    int count = 0;

    for (var option in options) {
      count++;

      children.add(
        GestureDetector(
          onTap: () {
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
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DSHeadlineSmallText(
                  option.label.type == 'text/plain'
                      ? option.label.value
                      : option.label.value['text'],
                  color: align == DSAlign.left
                      ? DSColors.primaryNight
                      : DSColors.primaryLight,
                ),
              ],
            ),
          ),
        ),
      );

      if (count != options.length) {
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
