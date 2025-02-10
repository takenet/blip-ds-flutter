import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../controllers/chat/ds_highlight.controller.dart';
import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../enums/ds_button_shape.enum.dart';
import '../../models/ds_message_bubble_avatar_config.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_message_item.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_caption_small_text_style.theme.dart';
import '../../utils/ds_message_content_type.util.dart';
import '../../utils/ds_utils.util.dart';
import '../animations/ds_reply_swipe.widget.dart';
import '../buttons/ds_button.widget.dart';
import '../chat/ds_highlight.dart';
import '../chat/ds_message_bubble_detail.widget.dart';
import '../chat/ds_quick_reply.widget.dart';
import '../chat/typing/ds_typing_message_bubble.widget.dart';
import 'ds_card.widget.dart';
import 'ds_user_avatar.widget.dart';

// Default compare message function
// ignore: prefer_function_declarations_over_variables
final _defaultCompareMessageFuntion =
    (DSMessageItem firstMsg, DSMessageItem secondMsg) {
  bool shouldGroupSelect = true;

  if (firstMsg.type == DSMessageContentType.select ||
      secondMsg.type == DSMessageContentType.select) {
    if (firstMsg.content is Map && firstMsg.content['scope'] == 'immediate' ||
        secondMsg.content is Map && secondMsg.content['scope'] == 'immediate') {
      shouldGroupSelect = false;
    }
  }

  final dateDifference = DateTime.parse(firstMsg.date)
      .difference(DateTime.parse(secondMsg.date))
      .inSeconds;

  final hasSameStatus = firstMsg.status == secondMsg.status;
  final hasSameAlign = firstMsg.align == secondMsg.align;

  return dateDifference <= 60 &&
      hasSameStatus &&
      hasSameAlign &&
      shouldGroupSelect;
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
    this.simpleStyle = false,
    this.avatarConfig = const DSMessageBubbleAvatarConfig(),
    this.onInfinitScroll,
    this.shrinkWrap = false,
    this.scrollController,
    this.onAsyncFetchSession,
    this.onReply,
    DSMessageBubbleStyle? style,
    bool Function(DSMessageItem, DSMessageItem)? compareMessages,
  })  : compareMessages = compareMessages ?? _defaultCompareMessageFuntion,
        style = style ?? DSMessageBubbleStyle();

  final List<DSMessageItem> documents;
  final bool Function(DSMessageItem, DSMessageItem) compareMessages;
  final bool isComposing;
  final bool sortMessages;
  final void Function(String, Map<String, dynamic>)? onSelected;
  final void Function(Map<String, dynamic>)? onOpenLink;
  final bool hideOptions;
  final bool showMessageStatus;
  final bool simpleStyle;
  final DSMessageBubbleStyle style;
  final DSMessageBubbleAvatarConfig avatarConfig;
  final void Function()? onInfinitScroll;
  final bool shrinkWrap;
  final ScrollController? scrollController;
  final Future<String?> Function(String)? onAsyncFetchSession;
  final void Function(DSMessageItem)? onReply;

  @override
  State<StatefulWidget> createState() => _DSGroupCardState();
}

class _DSGroupCardState extends State<DSGroupCard> {
  final List<Widget> widgets = [];
  final showScrollBottomButton = false.obs;
  final highlightController = DSHighlightController();

  String? previousReplyId;

  late ListObserverController observerController;
  late ScrollController controller;

  @override
  void initState() {
    controller = widget.scrollController ?? ScrollController();

    observerController = ListObserverController(controller: controller);

    controller.addListener(() {
      final nextPageTrigger = 0.90 * controller.position.maxScrollExtent;

      if (controller.position.pixels > nextPageTrigger) {
        widget.onInfinitScroll?.call();
      }

      showScrollBottomButton.value = controller.position.pixels > 600;
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    highlightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildWidgetsList(_getGroupCards());

    return Stack(
      children: [
        ListViewObserver(
          controller: observerController,
          child: ListView.builder(
            controller: controller,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            reverse: true,
            shrinkWrap: widget.shrinkWrap,
            itemCount: widgets.length,
            itemBuilder: (_, int index) => DSHighlight(
              key: widgets[index].key,
              controller: highlightController,
              child: widgets[index],
            ),
            findChildIndexCallback: (Key key) {
              final valueKey = key as ValueKey<String>;
              final index = widgets.indexWhere((widget) =>
                  (widget.key as ValueKey<String>).value == valueKey.value);

              if (index == -1) return null;

              return index;
            },
          ),
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
                  onPressed: () => _onScrollPrevious(),
                  leadingIcon: const Icon(
                    DSIcons.arrow_down_outline,
                    size: 20,
                    color: DSColors.neutralDarkCity,
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
        (a, b) => a.date.compareTo(b.date),
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
      DSMessageItem message = widget.documents[i];

      List<DSMessageItem> groupMsgs = group['msgs'];

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

    if (!widget.avatarConfig.showSentAvatar) {
      sentColumns.remove(fixedColumn);
    }

    if (!widget.avatarConfig.showReceivedAvatar) {
      receivedColumns.remove(fixedColumn);
    }

    final sentColumnWidths = sentColumns.asMap();
    final receivedColumnWidths = receivedColumns.asMap();

    for (final group in groups) {
      int msgCount = 1;

      final sentMessage = group['align'] == DSAlign.right;
      DSMessageItem? lastMessageQuickReply;

      group['msgs'].forEach(
        (DSMessageItem message) {
          final rows = <TableRow>[];
          final int length = group['msgs'].length;
          List<DSBorderRadius> borderRadius =
              _getBorderRadius(length, msgCount, group['align']);

          final messageId =
              '${message.id ?? DSUtils.generateUniqueID()}-${message.metadata?['#uniqueId']}-${message.isUploading}';

          final bubble = DSCard(
            key: ValueKey<String>(messageId),
            type: message.type,
            content: message.content,
            align: message.align,
            borderRadius: borderRadius,
            status: message.status,
            onSelected: widget.onSelected,
            avatarConfig: widget.avatarConfig,
            style: widget.style,
            onOpenLink: widget.onOpenLink,
            messageId: messageId,
            customer: message.customer,
            isUploading: message.isUploading,
            simpleStyle: widget.simpleStyle,
            onAsyncFetchSession: widget.onAsyncFetchSession,
            onTapReply: (final inReplyToId) =>
                _onTapReply(inReplyToId, messageId),
          );

          final isLastMsg = msgCount == length;

          final columns = <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(bottom: isLastMsg || length == 1 ? 0 : 3),
              child: bubble,
            ),
          ];

          if (!widget.simpleStyle &&
              ((sentMessage && widget.avatarConfig.showSentAvatar) ||
                  (!sentMessage && widget.avatarConfig.showReceivedAvatar))) {
            columns.add(
              isLastMsg
                  ? Align(
                      alignment: sentMessage
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      child: DSUserAvatar(
                        radius: 12,
                        textStyle: const DSCaptionSmallTextStyle(),
                        uri: sentMessage
                            ? widget.avatarConfig.sentAvatar
                            : widget.avatarConfig.receivedAvatar,
                        text: sentMessage
                            ? widget.avatarConfig.sentName
                            : widget.avatarConfig.receivedName,
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          }

          rows.add(
            TableRow(
              children: sentMessage ? columns : columns.reversed.toList(),
            ),
          );

          items.insert(
            0,
            DSReplySwipe(
              key: ValueKey<String>(messageId),
              message: message,
              onReply: widget.onReply,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Table(
                  columnWidths:
                      sentMessage ? sentColumnWidths : receivedColumnWidths,
                  defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                  children: rows,
                ),
              ),
            ),
          );

          if (isLastMsg &&
              ((message.hideMessageDetail ?? false) ? false : true)) {
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

            if (!widget.simpleStyle &&
                ((sentMessage && widget.avatarConfig.showSentAvatar) ||
                    (!sentMessage && widget.avatarConfig.showReceivedAvatar))) {
              columns.add(
                const SizedBox.shrink(),
              );
            }

            items.insert(
              0,
              Padding(
                key: ValueKey<String>(
                  DSUtils.generateUniqueID(),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Table(
                  columnWidths:
                      sentMessage ? sentColumnWidths : receivedColumnWidths,
                  defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                  children: [
                    TableRow(
                      children:
                          sentMessage ? columns : columns.reversed.toList(),
                    ),
                  ],
                ),
              ),
            );
          }

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

      if (widget.avatarConfig.showReceivedAvatar) {
        columns.insert(
          0,
          const SizedBox.shrink(),
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

  void _onScrollPrevious() {
    int index = 0;

    if (previousReplyId == null) {
      return _scrollToIndex(index);
    }

    index = widgets.indexWhere(
      (element) => element.key.toString().contains(previousReplyId!),
    );

    if (index == -1) {
      index = 0;
    }

    _scrollToIndex(index);

    highlightController.highlight(previousReplyId!);
    previousReplyId = null;
  }

  void _onTapReply(
    final String inReplyToId,
    final String repliedId,
  ) async {
    if (inReplyToId.isEmpty) return;

    previousReplyId = repliedId;

    final index = widgets.indexWhere(
      (element) => element.key.toString().contains(inReplyToId),
    );

    if (index == -1) {
      return;
    }

    _scrollToIndex(index);

    highlightController.highlight(inReplyToId);
  }

  void _scrollToIndex(final int index) {
    observerController.animateTo(
      index: index,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
  }
}
