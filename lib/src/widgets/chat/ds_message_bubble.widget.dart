import 'package:blip_ds/src/widgets/chat/ds_reply_container.widget.dart';
import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../utils/ds_bubble.util.dart';
import '../../utils/ds_utils.util.dart';
import '../animations/ds_animated_size.widget.dart';

class DSMessageBubble extends StatelessWidget {
  final DSAlign align;
  final Widget child;
  final String? replyId;
  final List<DSBorderRadius> borderRadius;
  final EdgeInsets padding;
  final bool shouldUseDefaultSize;
  final double defaultMaxSize;
  final double defaultMinSize;
  final DSMessageBubbleStyle style;
  final bool hasSpacer;

  const DSMessageBubble({
    Key? key,
    required this.align,
    required this.child,
    this.replyId,
    this.borderRadius = const [DSBorderRadius.all],
    this.padding = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    ),
    this.shouldUseDefaultSize = false,
    this.defaultMaxSize = DSUtils.bubbleMaxSize,
    this.defaultMinSize = DSUtils.bubbleMinSize,
    required this.style,
    this.hasSpacer = true,
  }) : super(key: key);

  BorderRadius _getBorderRadius() {
    return borderRadius.getCircularBorderRadius(
      maxRadius: 22.0,
      minRadius: 2.0,
    );
  }

  Widget _messageContainer() {
    return DSAnimatedSize(
      child: Container(
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          borderRadius: _getBorderRadius(),
          color: style.bubbleBorderColor(align),
        ),
        child: ClipRRect(
          borderRadius: _getBorderRadius(),
          child: Container(
            constraints: shouldUseDefaultSize
                ? BoxConstraints(
                    maxWidth: defaultMaxSize,
                    minWidth: defaultMinSize,
                  )
                : null,
            padding: padding,
            color: style.bubbleBackgroundColor(align),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (replyId != null)
                  DSReplyContainer(
                    replyId: replyId!,
                    style: style,
                    align: align,
                  ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: align == DSAlign.right
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: DSBubbleUtils.addSpacer(
              align: align,
              hasSpacer: hasSpacer,
              child: _messageContainer(),
            ),
          ),
        ],
      );
}
