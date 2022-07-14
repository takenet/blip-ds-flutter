import 'package:blip_ds/src/theme/systems_colors.dart';
import 'package:flutter/material.dart';

class DSMessageBubble extends StatelessWidget {
  final bool alignRight;
  final Widget child;
  final EdgeInsets contentPadding;
  final Map<String, bool> borderRadius;

  const DSMessageBubble({
    Key? key,
    required this.alignRight,
    required this.child,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 14.0,
    ),
    this.borderRadius = const {
      'topLeft': false,
      'topRight': false,
      'bottomLeft': false,
      'bottomRight': false
    },
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color containerColor = alignRight
        ? SystemColors.neutralDarkCity
        : SystemColors.neutralLightSnow;

    final Color borderColor = alignRight
        ? SystemColors.neutralDarkCity
        : SystemColors.neutralMediumSilver;

    final double width = MediaQuery.of(context).size.width * (1 / 6);

    final EdgeInsets mainMargin = EdgeInsets.fromLTRB(
        alignRight ? width : 16.0, 15.0, alignRight ? 16.0 : width, 5.0);

    BorderRadius decorationBorderRadius = BorderRadius.only(
      topLeft: borderRadius['topLeft']!
          ? const Radius.circular(18.0)
          : const Radius.circular(2.0),
      topRight: borderRadius['topRight']!
          ? const Radius.circular(18.0)
          : const Radius.circular(2.0),
      bottomLeft: borderRadius['bottomLeft']!
          ? const Radius.circular(18.0)
          : const Radius.circular(2.0),
      bottomRight: borderRadius['bottomRight']!
          ? const Radius.circular(18.0)
          : const Radius.circular(2.0),
    );

    return Align(
      alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: mainMargin,
        decoration: BoxDecoration(
          borderRadius: decorationBorderRadius,
          color: borderColor,
        ),
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: decorationBorderRadius,
          child: Container(
            padding: contentPadding,
            color: containerColor,
            child: child,
          ),
        ),
      ),
    );
  }
}
