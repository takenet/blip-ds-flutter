import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/interactive_message/ds_interactive_message.model.dart';

class DSInteractiveVoiceCallMessageBubble extends StatefulWidget {
  final DSInteractiveMessage content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  DSInteractiveVoiceCallMessageBubble({
    super.key,
    required this.content,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  State<DSInteractiveVoiceCallMessageBubble> createState() =>
      _DSInteractiveVoiceCallMessageBubbleState();
}

class _DSInteractiveVoiceCallMessageBubbleState
    extends State<DSInteractiveVoiceCallMessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
