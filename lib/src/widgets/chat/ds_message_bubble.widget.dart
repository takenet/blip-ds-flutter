import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../animations/ds_animated_size.widget.dart';

class DSMessageBubble extends StatelessWidget {
  final DSAlign align;
  final Widget child;
  final List<DSBorderRadius> borderRadius;
  final EdgeInsets padding;
  final DSMessageBubbleStyle style;

  const DSMessageBubble({
    Key? key,
    required this.align,
    required this.child,
    this.borderRadius = const [DSBorderRadius.all],
    this.padding = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    ),
    required this.style,
  }) : super(key: key);

  BorderRadius _getBorderRadius() {
    return borderRadius.getCircularBorderRadius(
      maxRadius: 22.0,
      minRadius: 2.0,
    );
  }

  Widget _messageContainer() {
    return Flexible(
      flex: 5,
      child: DSAnimatedSize(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: _getBorderRadius(),
            color: align == DSAlign.right
                ? style.sentBorderColor
                : style.receivedBorderColor,
          ),
          padding: const EdgeInsets.all(1.0),
          child: ClipRRect(
            borderRadius: _getBorderRadius(),
            child: Container(
              padding: padding,
              color: align == DSAlign.right
                  ? style.sentBackgroundColor
                  : style.receivedBackgroundColor,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rightAlign = align == DSAlign.right;
    List<Widget> children = [const Spacer(), _messageContainer()];

    return Column(
      children: [
        Row(
          mainAxisAlignment: rightAlign
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: rightAlign ? children : children.reversed.toList(),
        ),
      ],
    );
  }
}
