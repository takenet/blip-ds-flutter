import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

/// Use [align] feft or right to position typing on screen
class DsTypingWidget extends StatelessWidget {
  final DSAlign align;
  const DsTypingWidget({
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
              transform: Matrix4.translationValues(0.0, 5.0, 0.0),
              child: DsDotAnimationWidget(
                numberOfDots: 3,
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
