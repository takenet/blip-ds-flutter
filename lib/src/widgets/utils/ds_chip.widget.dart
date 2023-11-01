import 'package:flutter/material.dart';

import '../texts/ds_text.widget.dart';

class DSChip extends StatelessWidget {
  final DSText? text;
  final Widget? leadingIcon;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color background;
  final Border? border;
  final VoidCallback? onTap;
  final Widget? trailingIcon;
  final EdgeInsetsGeometry? textPadding;
  final double? size;

  const DSChip({
    super.key,
    this.text,
    required this.background,
    this.leadingIcon,
    this.trailingIcon,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.border,
    this.onTap,
    this.textPadding,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        padding: padding,
        decoration: text == null
            ? BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              )
            : BoxDecoration(
                color: background,
                borderRadius: borderRadius,
                border: border,
              ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            leadingIcon ?? const SizedBox.shrink(),
            Flexible(
              child: Padding(
                padding: textPadding ??
                    const EdgeInsets.symmetric(
                      vertical: 2.0,
                      horizontal: 8.0,
                    ),
                child: text ?? const SizedBox.shrink(),
              ),
            ),
            Flexible(
              child: trailingIcon ?? const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
