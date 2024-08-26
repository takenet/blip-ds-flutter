import 'package:flutter/material.dart';

import '../../../themes/colors/ds_colors.theme.dart';

class DSEndCallsRecordingContainer extends StatelessWidget {
  final bool isLighBubbleBackground;
  final Widget child;

  const DSEndCallsRecordingContainer({
    super.key,
    required this.isLighBubbleBackground,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: isLighBubbleBackground
              ? DSColors.neutralLightWhisper
              : DSColors.neutralDarkDesk,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      );
}
