import 'package:blip_ds/src/widgets/chat/ds_quick_reply.widget.dart';
import 'package:flutter/widgets.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_avatar_config.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_message_item.model.dart';
import '../../utils/ds_message_content_type.util.dart';
import '../chat/ds_message_bubble_detail.widget.dart';
import '../chat/typing/ds_typing_message_bubble.widget.dart';
import 'ds_card.widget.dart';
import 'ds_user_avatar.widget.dart';

// Default compare message function
// ignore: prefer_function_declarations_over_variables
final _defaultCompareMessageFuntion =
    (DSMessageItemModel firstMsg, DSMessageItemModel secondMsg) {
  bool shouldGroupSelect = true;

  if (firstMsg.type == DSMessageContentType.select ||
      secondMsg.type == DSMessageContentType.select) {
    if (firstMsg.content is Map && firstMsg.content['scope'] == 'immediate' ||
        secondMsg.content is Map && secondMsg.content['scope'] == 'immediate') {
      shouldGroupSelect = false;
    }
  }

  return (DateTime.parse(firstMsg.date)
              .difference(DateTime.parse(secondMsg.date))
              .inSeconds <=
          60 &&
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
    this.onSelected,
    this.onOpenLink,
    this.hideOptions = false,
    this.showMessageStatus = true,
    this.avatarConfig = const DSMessageBubbleAvatarConfig(),
    DSMessageBubbleStyle? style,
    bool Function(DSMessageItemModel, DSMessageItemModel)? compareMessages,
  })  : compareMessages = compareMessages ?? _defaultCompareMessageFuntion,
        style = style ?? DSMessageBubbleStyle(),
        super(key: key);

  final List<DSMessageItemModel> documents;
  final bool Function(DSMessageItemModel, DSMessageItemModel) compareMessages;
  final bool isComposing;
  final bool sortMessages;
  final void Function(String, Map<String, dynamic>)? onSelected;
  final void Function(Map<String, dynamic>)? onOpenLink;
  final bool hideOptions;
  final bool showMessageStatus;
  final List<Widget> _widgets = [];
  final DSMessageBubbleStyle style;
  final DSMessageBubbleAvatarConfig avatarConfig;

  @override
  Widget build(BuildContext context) {
    _buildWidgetsList(_getGroupCards());

    return Column(
      children: _widgets,
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
      DSMessageItemModel? lastMessageQuickReply;

      group['msgs'].forEach(
        (DSMessageItemModel message) {
          final int length = group['msgs'].length;
          List<DSBorderRadius> borderRadius =
              _getBorderRadius(length, msgCount, group['align']);

          final bubble = DSCard(
            type: message.type,
            content: message.content,
            align: message.align,
            borderRadius: borderRadius,
            onSelected: onSelected,
            customerName: message.customerName,
            style: style,
            onOpenLink: onOpenLink,
          );

          final isLastMsg = msgCount == length;

          final columns = <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(bottom: isLastMsg || length == 1 ? 0 : 3),
              child: bubble,
            ),
          ];

          if ((sentMessage && avatarConfig.showUserAvatar) ||
              (!sentMessage && avatarConfig.showOwnerAvatar)) {
            columns.add(
              isLastMsg
                  ? Align(
                      alignment: sentMessage
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      child: DSUserAvatar(
                        radius: 12,
                        uri: sentMessage
                            ? avatarConfig.userAvatar
                            : avatarConfig.ownerAvatar,
                        text: sentMessage
                            ? avatarConfig.userName
                            : avatarConfig.ownerName,
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

          if (isLastMsg) {
            final columns = <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: DSMessageBubbleDetail(
                  align: group['align'],
                  deliveryStatus: group['status'],
                  date: group['displayDate'],
                  showMessageStatus: showMessageStatus,
                  style: style,
                ),
              ),
            ];

            if ((sentMessage && avatarConfig.showUserAvatar) ||
                (!sentMessage && avatarConfig.showOwnerAvatar)) {
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

          final hideOptions = documents.last != message;
          if (!hideOptions &&
              message.type == DSMessageContentType.select &&
              message.content['scope'] == 'immediate') {
            lastMessageQuickReply = message;
          }

          msgCount++;
        },
      );

      final table = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Table(
          columnWidths: sentMessage ? sentColumnWidths : receivedColumnWidths,
          defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
          children: rows,
        ),
      );

      _widgets.add(table);

      if (lastMessageQuickReply != null) {
        _widgets.add(
          DSQuickReply(
            align: lastMessageQuickReply!.align,
            content: lastMessageQuickReply!.content,
            onSelected: onSelected,
          ),
        );
      }
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

      final table = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Table(
          columnWidths: receivedColumnWidths,
          defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
          children: [
            TableRow(
              children: columns,
            )
          ],
        ),
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
