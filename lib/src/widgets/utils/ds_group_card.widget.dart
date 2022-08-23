import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/models/ds_message_item.model.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class DSGroupCard extends StatefulWidget {
  final RxList<DSMessageItemModel> documents;
  final Function compareMessages;

  const DSGroupCard({
    Key? key,
    required this.documents,
    required this.compareMessages,
  }) : super(key: key);

  @override
  State<DSGroupCard> createState() => _DSGroupCardState();
}

class _DSGroupCardState extends State<DSGroupCard> {
  List<Map<String, dynamic>> _groups = [];
  List<Widget> _widgets = [];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        _groupCards();
        _resolverWidgets();

        return Column(
          children: _widgets,
        );
      },
    );
  }

  void _resolverWidgets() {
    _widgets = [];

    for (var element in _groups) {
      int msgCount = 1;
      element['msgs'].forEach((DSMessageItemModel msg) {
        int length = element['msgs'].length;
        List<DSBorderRadius> borderRadius = [];

        if (length == 1) {
          borderRadius = [DSBorderRadius.all];
        } else if (msgCount == 1) {
          (element['align'] == DSAlign.right)
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
        } else if (msgCount == length) {
          (element['align'] == DSAlign.right)
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
          (element['align'] == DSAlign.right)
              ? borderRadius = [
                  DSBorderRadius.topLeft,
                  DSBorderRadius.bottomLeft,
                ]
              : borderRadius = [
                  DSBorderRadius.topRight,
                  DSBorderRadius.bottomRight,
                ];
        }

        switch (msg.type) {
          case 'text/plain':
            _widgets.add(
              DSTextMessageBubble(
                groupWithPreviousMessage: true,
                text: msg.content,
                align: msg.align,
                borderRadius: borderRadius,
              ),
            );
            break;
          case 'application/vnd.lime.media-link+json':
            String contentType = msg.content['type'];
            if (contentType.contains('audio')) {
              _widgets.add(
                DSAudioMessageBubble(
                  uri: msg.content['uri'],
                  align: msg.align,
                  borderRadius: borderRadius,
                ),
              );
            }
            if (contentType.contains('image')) {
              _widgets.add(
                DSImageMessageBubble(
                  url: msg.content['uri'],
                  align: msg.align,
                  appBarText: '',
                  imageText: msg.content['text'],
                  imageTitle: msg.content['title'],
                  borderRadius: borderRadius,
                ),
              );
            }

            break;
          default:
        }

        msgCount++;
      });
    }
  }

  dynamic _groupCards() {
    _groups = [];

    Map<String, dynamic> group = {
      "msgs": [widget.documents[0]],
      "align": widget.documents[0].align,
      "date": widget.documents[0].date,
      "status": widget.documents[0].status,
    };

    for (int i = 1; i < widget.documents.length; i++) {
      DSMessageItemModel message = widget.documents[i];

      final int position = group['msgs'].length - 1;
      List<DSMessageItemModel> groupMsgs = group['msgs'];

      if (widget.compareMessages(message, groupMsgs[position])) {
        group['msgs'].add(message);
        group['date'] = message.date;
        group['status'] = message.status;
      } else {
        _groups.add(group);

        group = {
          'msgs': [message],
          'align': message.align,
          'date': message.date,
          'status': message.status,
        };
      }
    }
    _groups.add(group);
    return _groups;
  }
}
