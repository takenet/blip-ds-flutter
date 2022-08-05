import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSTypingAnimationMessageBubble extends StatelessWidget {
  final DSAlign align;

  /// Creates an animation showing that someone is typing something by responding to an interaction
  ///
  /// Use [align] left or right to position typing on screen
  const DSTypingAnimationMessageBubble({
    Key? key,
    required this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      child: DSTypingDotAnimation(
        color: align == DSAlign.left
            ? DSColors.neutralDarkCity
            : DSColors.neutralLightSnow,
      ),
    );
  }
}
