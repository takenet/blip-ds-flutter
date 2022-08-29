import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSMessageBubble extends StatelessWidget {
  final DSAlign align;
  final Widget child;
  final List<DSBorderRadius> borderRadius;
  final EdgeInsets padding;

  const DSMessageBubble({
    Key? key,
    required this.align,
    required this.child,
    this.borderRadius = const [DSBorderRadius.all],
    this.padding = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    ),
  }) : super(key: key);

  BorderRadius _getBorderRadius() {
    return borderRadius.contains(DSBorderRadius.all) || borderRadius.isEmpty
        ? const BorderRadius.all(
            Radius.circular(18.0),
          )
        : BorderRadius.only(
            topLeft: borderRadius.contains(DSBorderRadius.topLeft)
                ? const Radius.circular(18.0)
                : const Radius.circular(2.0),
            topRight: borderRadius.contains(DSBorderRadius.topRight)
                ? const Radius.circular(18.0)
                : const Radius.circular(2.0),
            bottomLeft: borderRadius.contains(DSBorderRadius.bottomLeft)
                ? const Radius.circular(18.0)
                : const Radius.circular(2.0),
            bottomRight: borderRadius.contains(DSBorderRadius.bottomRight)
                ? const Radius.circular(18.0)
                : const Radius.circular(2.0),
          );
  }

  Widget _messageContainer() {
    return Flexible(
      flex: 5,
      child: DSAnimatedSize(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 2.0, 16, 2.0),
          decoration: BoxDecoration(
            borderRadius: _getBorderRadius(),
            color: align == DSAlign.right
                ? DSColors.neutralDarkCity
                : DSColors.neutralMediumSilver,
          ),
          padding: const EdgeInsets.all(1.0),
          child: ClipRRect(
            borderRadius: _getBorderRadius(),
            child: Container(
              padding: padding,
              color: align == DSAlign.right
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (align == DSAlign.right) {
      children.insertAll(0, [const Spacer(), _messageContainer()]);
    } else {
      children.insertAll(0, [_messageContainer(), const Spacer()]);
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: align == DSAlign.right
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: children,
        ),
      ],
    );
  }
}
