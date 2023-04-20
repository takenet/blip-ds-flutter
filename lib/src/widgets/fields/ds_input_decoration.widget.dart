import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../utils/ds_utils.util.dart';

class DSInputDecoration extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final bool isEnabled;
  final bool? hasFocus;

  const DSInputDecoration({
    super.key,
    this.child,
    this.padding,
    this.hasFocus,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: DSUtils.defaultAnimationDuration,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(22.0),
            ),
            border: Border.all(
              width: 1.0,
              color: hasFocus ?? false
                  ? DSColors.primaryMain
                  : isEnabled
                      ? DSColors.neutralMediumSilver
                      : DSColors.neutralLightBox,
            ),
            color: isEnabled
                ? DSColors.neutralLightSnow
                : DSColors.neutralLightWhisper,
          ),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 44.0,
            ),
            padding: padding,
            child: child,
          ),
        ),
      );
}
