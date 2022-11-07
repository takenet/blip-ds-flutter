import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSChip extends StatelessWidget {
  final DSText text;
  final Icon? icon;
  final EdgeInsetsGeometry? padding;
  final Color background;

  const DSChip({
    Key? key,
    required this.text,
    this.icon,
    this.padding,
    required this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
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
