import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

import '../texts/ds_text.widget.dart';

class DSChip extends StatelessWidget {
  final DSText text;
  final Icon? icon;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color background;
  final Border? border;
  final VoidCallback? onTap;
  final Widget? deleteIcon;
  final EdgeInsetsGeometry? textPadding;

  const DSChip({
    Key? key,
    required this.text,
    this.icon,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    required this.background,
    this.border,
    this.onTap,
    this.deleteIcon,
    this.textPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: background,
          borderRadius: borderRadius,
          border: border,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ?? const SizedBox.shrink(),
            Padding(
              padding: textPadding ??
                  const EdgeInsets.symmetric(
                    vertical: 2.0,
                    horizontal: 8.0,
                  ),
              child: text,
            ),
            deleteIcon ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
