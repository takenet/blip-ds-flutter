import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

/// Creates an animation showing that someone is typing something by responding to an interaction
///
/// Use [align] left or right to position typing on screen
class DSTypingAnimationMessageBubble extends StatelessWidget {
  final DSAlign align;
  const DSTypingAnimationMessageBubble({
    Key? key,
    required this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      child: Container(
        transform: Matrix4.translationValues(0.0, 3.0, 0.0),
        child: DSDotAnimation(
          numberDots: 3,
          animationTime: const Duration(
            milliseconds: 300,
          ),
          color: align == DSAlign.left
              ? DSColors.neutralDarkCity
              : DSColors.neutralLightSnow,
        ),
      ),
    );
  }
}
