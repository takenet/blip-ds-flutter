import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';

class DSRequestReceptiveCall extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final List<DSBorderRadius> borderRadius;
  final EdgeInsets bodyPadding;
  final DSAlign align;
  final DSMessageBubbleStyle style;

  DSRequestReceptiveCall(
      {required this.backgroundColor,
      required this.foregroundColor,
      super.key,
      this.borderRadius = const [DSBorderRadius.all],
      this.bodyPadding = const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      required this.align,
      DSMessageBubbleStyle? style})
      : style = style ?? DSMessageBubbleStyle();

  @override
  State<DSRequestReceptiveCall> createState() => _DSRequestReceptiveCallState();
}

class _DSRequestReceptiveCallState extends State<DSRequestReceptiveCall> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
