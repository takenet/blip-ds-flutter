import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/utils/ds_message_content_type.util.dart';
import 'package:blip_ds/src/widgets/chat/ds_message_bubble_detail.widget.dart';
import 'package:flutter/material.dart';

/// A Design System widget used to display a grouped [DSMessageBubble] list
class DSGroupCard extends StatefulWidget {
  final List<DSMessageItemModel> documents;
  final Function compareMessages;
  final bool isComposing;

  /// Creates a new Design System's [DSGroupCard] widget
  const DSGroupCard({
    Key? key,
    required this.documents,
    required this.compareMessages,
    required this.isComposing,
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

          switch (message.type) {
            case DSMessageContentType.textPlain:
              _widgets.add(
                DSTextMessageBubble(
                  text: message.content,
                  align: message.align,
                  borderRadius: borderRadius,
                ),
              );
              break;
            case DSMessageContentType.mediaLink:
              _buildMediaLink(message, borderRadius);
              break;
            default:
              _widgets.add(
                DSUnsupportedContentMessageBubble(
                  align: message.align,
                  borderRadius: borderRadius,
                ),
              );
          }

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

  void _buildMediaLink(
    final DSMessageItemModel message,
    final List<DSBorderRadius> borderRadius,
  ) {
    final String contentType = message.content['type'];

    if (contentType.contains('audio')) {
      _widgets.add(
        DSAudioMessageBubble(
          uri: message.content['uri'],
          align: message.align,
          borderRadius: borderRadius,
        ),
      );
    } else if (contentType.contains('image')) {
      _widgets.add(
        DSImageMessageBubble(
          url: message.content['uri'],
          align: message.align,
          appBarText: message.customerName ?? '',
          imageText: message.content['text'],
          imageTitle: message.content['title'],
          borderRadius: borderRadius,
        ),
      );
    } else {
      _widgets.add(
        DSFileMessageBubble(
          align: message.align,
          url: message.content['uri'],
          size: message.content['size'],
          filename: message.content['title'],
          borderRadius: borderRadius,
        ),
      );
    }
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
