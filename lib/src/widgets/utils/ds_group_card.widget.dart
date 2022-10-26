import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/enums/ds_button_shape.enum.dart';
import 'package:blip_ds/src/widgets/chat/ds_quick_reply.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../utils/ds_message_content_type.util.dart';
import '../chat/ds_message_bubble_detail.widget.dart';
import 'ds_card.widget.dart';

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
class DSGroupCard extends StatefulWidget {
  /// Creates a new Design System's [DSGroupCard] widget
  DSGroupCard({
    super.key,
    required this.documents,
    required this.isComposing,
    this.sortMessages = true,
    this.onSelected,
    this.onOpenLink,
    this.hideOptions = false,
    this.showMessageStatus = true,
    this.avatarConfig = const DSMessageBubbleAvatarConfig(),
    this.onInfinitScroll,
    this.shrinkWrap = false,
    DSMessageBubbleStyle? style,
    bool Function(DSMessageItemModel, DSMessageItemModel)? compareMessages,
  })  : compareMessages = compareMessages ?? _defaultCompareMessageFuntion,
        style = style ?? DSMessageBubbleStyle();

  final List<DSMessageItemModel> documents;
  final bool Function(DSMessageItemModel, DSMessageItemModel) compareMessages;
  final bool isComposing;
  final bool sortMessages;
  final void Function(String, Map<String, dynamic>)? onSelected;
  final void Function(Map<String, dynamic>)? onOpenLink;
  final bool hideOptions;
  final bool showMessageStatus;
  final DSMessageBubbleStyle style;
  final DSMessageBubbleAvatarConfig avatarConfig;
  final void Function()? onInfinitScroll;
  final bool shrinkWrap;

  @override
  State<StatefulWidget> createState() => _DSGroupCardState();
}

class _DSGroupCardState extends State<DSGroupCard> {
  final scrollController = ScrollController();
  final List<Widget> widgets = [];
  final showScrollBottomButton = false.obs;

  @override
  void initState() {
    scrollController.addListener(() {
      final nextPageTrigger = 0.90 * scrollController.position.maxScrollExtent;

      if (scrollController.position.pixels > nextPageTrigger) {
        if (widget.onInfinitScroll != null) {
          widget.onInfinitScroll!();
        }
      }

      showScrollBottomButton.value = scrollController.position.pixels > 600;
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildWidgetsList(_getGroupCards());

    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          controller: scrollController,
          reverse: true,
          shrinkWrap: widget.shrinkWrap,
          itemCount: widgets.length,
          itemBuilder: (_, int index) {
            return widgets[index];
          },
          findChildIndexCallback: (Key key) {
            final valueKey = key as ValueKey<String>;
            final index = widgets.indexWhere((widget) =>
                (widget.key as ValueKey<String>).value == valueKey.value);
            if (index == -1) return null;
            return index;
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Obx(
            () => AnimatedOpacity(
              opacity: showScrollBottomButton.value ? 1 : 0,
              duration: DSUtils.defaultAnimationDuration,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: DSButton(
                  shape: DSButtonShape.rounded,
                  onPressed: () {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                    );
                  },
                  leadingIcon: const Icon(
                    DSIcons.arrow_down_outline,
                    size: 20,
                  ),
                  backgroundColor: DSColors.neutralLightSnow,
                  foregroundColor: DSColors.neutralDarkCity,
                  borderColor: DSColors.neutralMediumSilver,
                ),
              ),
            ),
          ),
        ),
      ],
    );
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

  void _buildWidgetsList(final List<Map<String, dynamic>> groups) {
    final items = <Widget>[];

    const flexColumn = FlexColumnWidth();
    const fixedColumn = FixedColumnWidth(32);

    final sentColumns = [flexColumn, fixedColumn];
    final receivedColumns = [fixedColumn, flexColumn];

    if (!widget.avatarConfig.showUserAvatar) {
      sentColumns.remove(fixedColumn);
    }

    if (!widget.avatarConfig.showOwnerAvatar) {
      receivedColumns.remove(fixedColumn);
    }

    final sentColumnWidths = sentColumns.asMap();
    final receivedColumnWidths = receivedColumns.asMap();

    for (final group in groups) {
      int msgCount = 1;

      final sentMessage = group['align'] == DSAlign.right;
      DSMessageItemModel? lastMessageQuickReply;

      group['msgs'].forEach(
        (DSMessageItemModel message) {
          final rows = <TableRow>[];
          final int length = group['msgs'].length;
          List<DSBorderRadius> borderRadius =
              _getBorderRadius(length, msgCount, group['align']);

          final bubble = DSCard(
            type: message.type,
            content: message.content,
            align: message.align,
            borderRadius: borderRadius,
            onSelected: widget.onSelected,
            customerName: message.customerName,
            style: widget.style,
            onOpenLink: widget.onOpenLink,
          );

          final isLastMsg = msgCount == length;

          final columns = <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(bottom: isLastMsg || length == 1 ? 0 : 3),
              child: bubble,
            ),
          ];

          if ((sentMessage && widget.avatarConfig.showUserAvatar) ||
              (!sentMessage && widget.avatarConfig.showOwnerAvatar)) {
            columns.add(
              isLastMsg
                  ? Align(
                      alignment: sentMessage
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      child: DSUserAvatar(
                        radius: 12,
                        uri: sentMessage
                            ? widget.avatarConfig.userAvatar
                            : widget.avatarConfig.ownerAvatar,
                        text: sentMessage
                            ? widget.avatarConfig.userName
                            : widget.avatarConfig.ownerName,
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
                  showMessageStatus: widget.showMessageStatus,
                  style: widget.style,
                ),
              ),
            ];

            if ((sentMessage && widget.avatarConfig.showUserAvatar) ||
                (!sentMessage && widget.avatarConfig.showOwnerAvatar)) {
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

          items.insert(
            0,
            Padding(
              key: ValueKey<String>(message.id ?? DateTime.now().toIso8601String()),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Table(
                columnWidths:
                    sentMessage ? sentColumnWidths : receivedColumnWidths,
                defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                children: rows,
              ),
            ),
          );

          final hideOptions = widget.documents.last != message;
          if (!hideOptions &&
              message.type == DSMessageContentType.select &&
              message.content['scope'] == 'immediate') {
            lastMessageQuickReply = message;
          }

          msgCount++;
        },
      );

      if (lastMessageQuickReply != null) {
        items.insert(
          0,
          DSQuickReply(
            key: const ValueKey('ds-quick-reply'),
            align: lastMessageQuickReply!.align,
            content: lastMessageQuickReply!.content,
            onSelected: widget.onSelected,
          ),
        );
      }
    }

    if (widget.isComposing) {
      final columns = <Widget>[
        DSTypingAnimationMessageBubble(
          align: DSAlign.left,
          style: widget.style,
        ),
      ];

      if (widget.avatarConfig.showOwnerAvatar) {
        columns.insert(
          0,
          const SizedBox(),
        );
      }

      final table = Padding(
        key: const ValueKey('ds-typing'),
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

      items.insert(0, table);
    }

    widgets.assignAll([...items]);
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
