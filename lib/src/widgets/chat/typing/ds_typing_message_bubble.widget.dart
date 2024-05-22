import 'package:flutter/material.dart';

import '../../../enums/ds_align.enum.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../ds_message_bubble.widget.dart';
import 'ds_typing_dot_animation.widget.dart';

class DSTypingAnimationMessageBubble extends StatelessWidget {
  final DSAlign align;
  final DSMessageBubbleStyle style;

  /// Creates an animation showing that someone is typing something by responding to an interaction
  ///
  /// Use [align] left or right to position typing on screen
  DSTypingAnimationMessageBubble({
    super.key,
    required this.align,
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      style: style,
      child: DSTypingDotAnimation(
        color: style.isLightBubbleBackground(align)
            ? DSColors.neutralDarkCity
            : DSColors.neutralLightSnow,
      ),
    );
  }
}
