import 'package:blip_ds/src/utils/ds_message_content_type.util.dart';
import 'package:blip_ds/src/widgets/chat/ds_message_bubble_detail.widget.dart';
import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_avatar_config.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_message_item.model.dart';
import '../chat/audio/ds_audio_message_bubble.widget.dart';
import '../chat/ds_file_message_bubble.widget.dart';
import '../chat/ds_image_message_bubble.widget.dart';
import '../chat/ds_text_message_bubble.widget.dart';
import '../chat/ds_unsupported_content_message_bubble.widget.dart';
import '../chat/typing/ds_typing_message_bubble.widget.dart';
import 'ds_user_avatar.widget.dart';

// Default compare message function
// ignore: prefer_function_declarations_over_variables
final _defaultCompareMessageFuntion = (DSMessageItemModel firstMsg, DSMessageItemModel secondMsg) {
  //TODO: Quickreply  não deve agrupar com demais widgets

  bool shouldGroupSelect = true;

  if (firstMsg.type == 'application/vnd.lime.select+json' || secondMsg.type == 'application/vnd.lime.select+json') {
    if (firstMsg.content is Map && firstMsg.content['scope'] == 'immediate' ||
        secondMsg.content is Map && secondMsg.content['scope'] == 'immediate') {
      shouldGroupSelect = false;
    }
  }

  return (DateTime.parse(firstMsg.date).difference(DateTime.parse(secondMsg.date)).inSeconds <= 60 &&
      firstMsg.status == secondMsg.status &&
      firstMsg.align == secondMsg.align &&
      shouldGroupSelect);
};

/// A Design System widget used to display a grouped [DSMessageBubble] list
class DSGroupCard extends StatelessWidget {
  /// Creates a new Design System's [DSGroupCard] widget
  DSGroupCard({
    Key? key,
    required this.documents,
    required this.isComposing,
    this.sortMessages = true,
    DSMessageBubbleStyle? style,
    this.avatarConfig = const DSMessageBubbleAvatarConfig(),
    bool Function(DSMessageItemModel, DSMessageItemModel)? compareMessages,
  })  : compareMessages = compareMessages ?? _defaultCompareMessageFuntion,
        style = style ?? DSMessageBubbleStyle(),
        super(key: key);

  final List<DSMessageItemModel> documents;
  final bool Function(DSMessageItemModel, DSMessageItemModel) compareMessages;
  final bool isComposing;
  final bool sortMessages;
  final List<Widget> _widgets = [];
  final DSMessageBubbleStyle style;
  final DSMessageBubbleAvatarConfig avatarConfig;

  @override
  Widget build(BuildContext context) {
    _buildWidgetsList(_getGroupCards());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: _widgets,
      ),
    );
  }

  void _buildWidgetsList(final List<Map<String, dynamic>> groups) {
    _widgets.clear();

    const flexColumn = FlexColumnWidth();
    const fixedColumn = FixedColumnWidth(32);

    final sentColumns = [flexColumn, fixedColumn];
    final receivedColumns = [fixedColumn, flexColumn];

    if (!avatarConfig.showUserAvatar) {
      sentColumns.remove(fixedColumn);
    }

    if (!avatarConfig.showOwnerAvatar) {
      receivedColumns.remove(fixedColumn);
    }

    final sentColumnWidths = sentColumns.asMap();
    final receivedColumnWidths = receivedColumns.asMap();

    for (var group in groups) {
      int msgCount = 1;

      final rows = <TableRow>[];
      final sentMessage = group['align'] == DSAlign.right;

      group['msgs'].forEach(
        (DSMessageItemModel message) {
          final int length = group['msgs'].length;
          Widget bubble;
          List<DSBorderRadius> borderRadius = _getBorderRadius(length, msgCount, group['align']);

          switch (message.type) {
            case DSMessageContentType.textPlain:
              bubble = DSTextMessageBubble(
                text: message.content,
                align: message.align,
                borderRadius: borderRadius,
                style: style,
              );
              break;
            case DSMessageContentType.mediaLink:
              bubble = _buildMediaLink(message, borderRadius);
              break;
            default:
              bubble = DSUnsupportedContentMessageBubble(
                align: message.align,
                borderRadius: borderRadius,
                style: style,
              );
          }

          final lastMsg = msgCount == length;

          final columns = <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: lastMsg || length == 1 ? 0 : 3),
              child: bubble,
            ),
          ];

          if ((sentMessage && avatarConfig.showUserAvatar) || (!sentMessage && avatarConfig.showOwnerAvatar)) {
            columns.add(
              lastMsg
                  ? Align(
                      alignment: sentMessage ? Alignment.bottomRight : Alignment.bottomLeft,
                      child: DSUserAvatar(
                        radius: 12,
                        uri: sentMessage ? avatarConfig.userAvatar : avatarConfig.ownerAvatar,
                        text: sentMessage ? avatarConfig.userName : avatarConfig.ownerName,
                      ),
                    )
                  : const SizedBox(),
            );
          }
          rows.add(
            TableRow(
              children: sentMessage ? columns : columns.reversed.toList(),
            ),
          );

          if (lastMsg) {
            final columns = <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: DSMessageBubbleDetail(
                  align: group['align'],
                  deliveryStatus: group['status'],
                  date: group['displayDate'],
                  style: style,
                ),
              ),
            ];

            if ((sentMessage && avatarConfig.showUserAvatar) || (!sentMessage && avatarConfig.showOwnerAvatar)) {
              columns.add(
                const SizedBox(),
              );
            }

            rows.add(
              TableRow(
                children: sentMessage ? columns : columns.reversed.toList(),
              ),
            );
          }

          msgCount++;
        },
      );

      final table = Table(
        columnWidths: sentMessage ? sentColumnWidths : receivedColumnWidths,
        defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
        children: rows,
      );

      _widgets.add(table);
    }

    if (isComposing) {
      final columns = <Widget>[
        DSTypingAnimationMessageBubble(
          align: DSAlign.left,
          style: style,
        ),
      ];

      if (avatarConfig.showOwnerAvatar) {
        columns.insert(
          0,
          const SizedBox(),
        );
      }

      final table = Table(
        columnWidths: receivedColumnWidths,
        defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
        children: [
          TableRow(
            children: columns,
          )
        ],
      );

      _widgets.add(table);
    }
  }

  List<Map<String, dynamic>> _getGroupCards() {
    List<Map<String, dynamic>> groups = [];

    if (documents.isEmpty) {
      return [];
    }

    if (sortMessages) {
      documents.sort(
        ((a, b) {
          return a.date.compareTo(b.date);
        }),
      );
    }

    Map<String, dynamic> group = {
      "msgs": [documents[0]],
      "align": documents[0].align,
      "date": documents[0].date,
      "displayDate": documents[0].displayDate,
      "status": documents[0].status,
    };

    for (int i = 1; i < documents.length; i++) {
      DSMessageItemModel message = documents[i];

      List<DSMessageItemModel> groupMsgs = group['msgs'];

      if (compareMessages(message, groupMsgs.last)) {
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

  Widget _buildMediaLink(
    final DSMessageItemModel message,
    final List<DSBorderRadius> borderRadius,
  ) {
    final String contentType = message.content['type'];

    if (contentType.contains('audio')) {
      return DSAudioMessageBubble(
        uri: message.content['uri'],
        align: message.align,
        borderRadius: borderRadius,
        style: style,
      );
    } else if (contentType.contains('image')) {
      return DSImageMessageBubble(
        url: message.content['uri'],
        align: message.align,
        appBarText: message.customerName ?? '',
        appBarPhotoUri: message.customerAvatar,
        imageText: message.content['text'],
        imageTitle: message.content['title'],
        borderRadius: borderRadius,
        style: style,
      );
    } else {
      return DSFileMessageBubble(
        align: message.align,
        url: message.content['uri'],
        size: message.content['size'],
        filename: message.content['title'],
        borderRadius: borderRadius,
        style: style,
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
          ? borderRadius = [DSBorderRadius.topRight, DSBorderRadius.topLeft, DSBorderRadius.bottomLeft]
          : borderRadius = [DSBorderRadius.topRight, DSBorderRadius.topLeft, DSBorderRadius.bottomRight];
    } else if (isLastMessage) {
      (align == DSAlign.right)
          ? borderRadius = [DSBorderRadius.topLeft, DSBorderRadius.bottomRight, DSBorderRadius.bottomLeft]
          : borderRadius = [DSBorderRadius.topRight, DSBorderRadius.bottomRight, DSBorderRadius.bottomLeft];
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
