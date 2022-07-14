import 'package:blip_ds/src/enums/ds_border_radius.enum.dart';
import 'package:blip_ds/src/enums/ds_align.enum.dart';
import 'package:blip_ds/src/theme/systems_colors.dart';
import 'package:flutter/material.dart';

class DSMessageBubble extends StatefulWidget {
  final DSAlign align;
  final Widget child;
  final EdgeInsets contentPadding;
  final List<DSBorderRadius> borderRadius;

  const DSMessageBubble({
    Key? key,
    required this.align,
    required this.child,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 14.0,
    ),
    this.borderRadius = const [],
  }) : super(key: key);

  @override
  State<DSMessageBubble> createState() => _DSMessageBubbleState();
}

class _DSMessageBubbleState extends State<DSMessageBubble> {
  BorderRadius getBorderRadius() {
    return widget.borderRadius.contains(DSBorderRadius.all)
        ? const BorderRadius.all(
            Radius.circular(
              18.0,
            ),
          )
        : BorderRadius.only(
            topLeft: widget.borderRadius.contains(DSBorderRadius.topLeft)
                ? const Radius.circular(18.0)
                : const Radius.circular(2.0),
            topRight: widget.borderRadius.contains(DSBorderRadius.topRight)
                ? const Radius.circular(18.0)
                : const Radius.circular(2.0),
            bottomLeft: widget.borderRadius.contains(DSBorderRadius.bottomLeft)
                ? const Radius.circular(18.0)
                : const Radius.circular(2.0),
            bottomRight:
                widget.borderRadius.contains(DSBorderRadius.bottomRight)
                    ? const Radius.circular(18.0)
                    : const Radius.circular(2.0),
          );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * (1 / 6);

    final EdgeInsets mainMargin = EdgeInsets.fromLTRB(
      widget.align == DSAlign.right ? width : 16.0,
      15.0,
      widget.align == DSAlign.right ? 16.0 : width,
      5.0,
    );

    return Align(
      alignment: widget.align == DSAlign.right
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: mainMargin,
        decoration: BoxDecoration(
          borderRadius: getBorderRadius(),
          color: widget.align == DSAlign.right
              ? SystemColors.neutralDarkCity
              : SystemColors.neutralMediumSilver,
        ),
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: getBorderRadius(),
          child: Container(
            padding: widget.contentPadding,
            color: widget.align == DSAlign.right
                ? SystemColors.neutralDarkCity
                : SystemColors.neutralLightSnow,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
