import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

/// Creates an animation showing that someone is typing something by responding to an interaction
///
/// Use [align] left or right to position typing on screen
class DSTypingMessageBubble extends StatelessWidget {
  final DSAlign align;
  const DSTypingMessageBubble({
    Key? key,
    required this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (align == DSAlign.right) const Spacer(),
        SizedBox(
          width: 150,
          height: 65,
          child: DSMessageBubble(
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
                    : DSColors.neutralMediumSilver,
              ),
            ),
          ),
        ),
        if (align == DSAlign.left) const Spacer(),
      ],
    );
  }
}
