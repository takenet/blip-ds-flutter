import 'package:flutter/material.dart';

import '../enums/ds_align.enum.dart';

abstract class DSBubbleUtils {
  static List<Widget> addSpacer({
    required final DSAlign align,
    required final Widget child,
    final bool hasSpacer = true,
  }) {
    final hasRightAlign = align == DSAlign.right;

    final widgets = [
      Visibility(
        visible: hasSpacer,
        child: const Spacer(),
      ),
      Flexible(
        flex: 5,
        child: child,
      ),
    ];

    return hasRightAlign ? widgets : widgets.reversed.toList();
  }
}
