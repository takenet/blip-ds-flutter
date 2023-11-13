import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import 'ds_message_bubble.widget.dart';

class DSLoadingBubbleWidget extends StatelessWidget {
  const DSLoadingBubbleWidget({
    super.key,
    required this.style,
    required this.align,
    required this.borderRadius,
  });

  final DSAlign align;
  final DSMessageBubbleStyle style;
  final List<DSBorderRadius> borderRadius;

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      borderRadius: borderRadius,
      padding: EdgeInsets.zero,
      style: style,
      child: const SizedBox(
        height: 240,
        width: 240,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
