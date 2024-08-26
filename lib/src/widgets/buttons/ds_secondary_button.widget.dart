import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';
import 'ds_button.widget.dart';

/// A Design System's [ButtonStyleButton] primarily used by secondary actions.
///
/// Set [isEnabled] to activate/deactivate this button's [onPressed] and change his style.
/// Set [isLoading] to override content with a loading animation. It also deactivates [onPressed].
class DSSecondaryButton extends DSButton {
  /// Creates a Design System's [ButtonStyleButton] with secondary style.
  DSSecondaryButton({
    required super.onPressed,
    super.key,
    super.leadingIcon,
    super.label,
    super.trailingIcon,
    super.isEnabled,
    super.isLoading,
    super.autoSize,
    super.contentAlignment,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
  }) : super(
          backgroundColor: backgroundColor ?? DSColors.neutralLightSnow,
          foregroundColor: foregroundColor ??
              (isEnabled
                  ? DSColors.primaryNight
                  : DSColors.neutralMediumElephant),
          borderColor: borderColor ??
              (isEnabled
                  ? DSColors.primaryNight
                  : DSColors.neutralMediumElephant),
        );
}
