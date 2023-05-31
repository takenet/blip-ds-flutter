import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSSurveyCard extends StatelessWidget {
  const DSSurveyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: DSAlign.center,
      style: DSMessageBubbleStyle(),
      child: Container(
        height: 20.0,
        width: 20.0,
        decoration: const BoxDecoration(
          color: DSColors.illustrationBlueJeans,
        ),
      ),
    );
  }
}
