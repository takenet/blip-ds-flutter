import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/chat/ds_message_bubble_detail.widget.dart';
import 'package:blip_ds/src/widgets/utils/ds_card.widget.dart';

/// A Design System widget used to display a grouped [DSCard] list
class DSGroupCard extends StatefulWidget {
  final List<DSMessageItemModel> documents;
  final Function compareMessages;
  final bool isComposing;
  final bool sortMessages;
  final Function? onSelected;
  final bool hideOptions;
  final Function? onOpenLink;

  /// Creates a new Design System's [DSGroupCard] widget
  const DSGroupCard({
    Key? key,
    required this.documents,
    required this.compareMessages,
    required this.isComposing,
    this.sortMessages = true,
    this.onSelected,
    this.hideOptions = false,
    this.onOpenLink,
  }) : super(key: key);

  @override
  State<DSGroupCard> createState() => _DSGroupCardState();
}

class _DSGroupCardState extends State<DSGroupCard> {
  List<Widget> _widgets = [];

  @override
  Widget build(BuildContext context) {
    _buildWidgetsList(_getGroupCards());

    return Column(
      children: _widgets,
    );
  }

  void _buildWidgetsList(final List<Map<String, dynamic>> groups) {
    _widgets = [];

    for (var group in groups) {
      int msgCount = 1;

      group['msgs'].forEach(
        (DSMessageItemModel message) {
          final int length = group['msgs'].length;

          List<DSBorderRadius> borderRadius =
              _getBorderRadius(length, msgCount, group['align']);

          _widgets.add(
            DSCard(
              type: message.type,
              content: message.content,
              align: message.align,
              borderRadius: borderRadius,
              hideOptions: widget.hideOptions,
              onSelected: widget.onSelected,
              customerName: message.customerName,
              onOpenLink: widget.onOpenLink,
            ),
          );

          if (msgCount == length) {
            _widgets.add(
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: DSMessageBubbleDetail(
                  align: group['align'],
                  deliveryStatus: group['status'],
                  date: group['displayDate'],
                ),
              ),
            );
          }

          msgCount++;
        },
      );
    }

    if (widget.isComposing) {
      _widgets.add(
        const DSTypingAnimationMessageBubble(
          align: DSAlign.left,
        ),
      );
    }
  }

  List<Map<String, dynamic>> _getGroupCards() {
    List<Map<String, dynamic>> groups = [];

    if (widget.documents.isEmpty) {
      return [];
    }

    if (widget.sortMessages) {
      widget.documents.sort(
        ((a, b) {
          return a.date.compareTo(b.date);
        }),
      );
    }

    Map<String, dynamic> group = {
      "msgs": [widget.documents[0]],
      "align": widget.documents[0].align,
      "date": widget.documents[0].date,
      "displayDate": widget.documents[0].displayDate,
      "status": widget.documents[0].status,
    };

    for (int i = 1; i < widget.documents.length; i++) {
      DSMessageItemModel message = widget.documents[i];

      List<DSMessageItemModel> groupMsgs = group['msgs'];

      if (widget.compareMessages(message, groupMsgs.last)) {
        group['msgs'].add(message);
        group['date'] = message.date;
        group['status'] = message.status;
        group['displayDate'] = message.displayDate;
      } else {
        groups.add(group);

        group = {
          'msgs': [message],
          'align': message.align,
          'date': message.date,
          'status': message.status,
          'displayDate': message.displayDate,
        };
      }
    }
    groups.add(group);
    return groups;
  }

  List<DSBorderRadius> _getBorderRadius(
    final int length,
    final int msgCount,
    final DSAlign align,
  ) {
    List<DSBorderRadius> borderRadius = [];
    final bool isFirstMessage = msgCount == 1;
    final bool isLastMessage = msgCount == length;

    if (length == 1) {
      borderRadius = [DSBorderRadius.all];
    } else if (isFirstMessage) {
      (align == DSAlign.right)
          ? borderRadius = [
              DSBorderRadius.topRight,
              DSBorderRadius.topLeft,
              DSBorderRadius.bottomLeft
            ]
          : borderRadius = [
              DSBorderRadius.topRight,
              DSBorderRadius.topLeft,
              DSBorderRadius.bottomRight
            ];
    } else if (isLastMessage) {
      (align == DSAlign.right)
          ? borderRadius = [
              DSBorderRadius.topLeft,
              DSBorderRadius.bottomRight,
              DSBorderRadius.bottomLeft
            ]
          : borderRadius = [
              DSBorderRadius.topRight,
              DSBorderRadius.bottomRight,
              DSBorderRadius.bottomLeft
            ];
    } else {
      (align == DSAlign.right)
          ? borderRadius = [
              DSBorderRadius.topLeft,
              DSBorderRadius.bottomLeft,
            ]
          : borderRadius = [
              DSBorderRadius.topRight,
              DSBorderRadius.bottomRight,
            ];
    }

    return borderRadius;
  }
}
