import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';

class DSChip extends StatelessWidget {
  final DSText text;
  final Icon? icon;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color background;

  const DSChip({
    Key? key,
    required this.text,
    this.icon,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    required this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: borderRadius,
      ),
      child: Row(
        children: [
          icon ?? const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 3.0,
              horizontal: 8.0,
            ),
            child: text,
          ),
        ],
      ),
    );
  }
}
