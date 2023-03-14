import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../utils/ds_utils.util.dart';

class DSInputDecoration extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final bool isEnabled;

  final hasFocus = RxBool(false);

  DSInputDecoration({
    super.key,
    this.child,
    this.padding,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) => Focus(
        onFocusChange: hasFocus,
        child: Obx(
          () => AnimatedContainer(
            constraints: const BoxConstraints(
              minHeight: 44.0,
            ),
            duration: DSUtils.defaultAnimationDuration,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              border: Border.all(
                width: 1,
                color: hasFocus.value
                    ? DSColors.primaryMain
                    : isEnabled
                        ? DSColors.neutralMediumSilver
                        : DSColors.neutralLightBox,
              ),
              color: isEnabled
                  ? DSColors.neutralLightSnow
                  : DSColors.neutralLightWhisper,
            ),
            child: child,
          ),
        ),
      );
}
