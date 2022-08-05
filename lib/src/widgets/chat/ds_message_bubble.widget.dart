import 'package:blip_ds/src/enums/ds_border_radius.enum.dart';
import 'package:blip_ds/src/enums/ds_align.enum.dart';
import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:flutter/material.dart';

class DSMessageBubble extends StatelessWidget {
  final DSAlign align;
  final Widget child;
  final EdgeInsets contentPadding;
  final List<DSBorderRadius> borderRadius;

  const DSMessageBubble({
    Key? key,
    required this.align,
    required this.child,
    this.borderRadius = const [DSBorderRadius.all],
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    ),
  }) : super(key: key);

  BorderRadius getBorderRadius() {
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

  Widget emptyWidget() {
    return const Flexible(flex: 1, child: SizedBox());
  }

  Widget messageContainer() {
    return Flexible(
      flex: 5,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: getBorderRadius(),
          color: align == DSAlign.right
              ? DSColors.neutralDarkCity
              : DSColors.neutralMediumSilver,
        ),
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: getBorderRadius(),
          child: Container(
            padding: contentPadding,
            color: align == DSAlign.right
                ? DSColors.neutralDarkCity
                : DSColors.neutralLightSnow,
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (align == DSAlign.right) {
      children.insertAll(0, [emptyWidget(), messageContainer()]);
    } else {
      children.insertAll(0, [messageContainer(), emptyWidget()]);
    }

    return Row(
      mainAxisAlignment: align == DSAlign.right
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: children,
    );
  }
}
