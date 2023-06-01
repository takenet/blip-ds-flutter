import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../blip_ds.dart';

class DSDashedBorder extends StatelessWidget {
  const DSDashedBorder({
    super.key,
    required this.child,
    this.borderColor = DSColors.neutralMediumWave,
    this.strokeWidth = 1.0,
  });

  final Color borderColor;
  final double strokeWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: DottedBorder(
        color: borderColor,
        strokeWidth: strokeWidth,
        radius: const Radius.circular(8),
        borderType: BorderType.RRect,
        dashPattern: const [3, 3],
        padding: EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
