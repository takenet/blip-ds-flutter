import 'dart:ui';

import '../../themes/colors/ds_colors.theme.dart';
import 'ds_button.widget.dart';

/// A Design System's [ButtonStyleButton] primarily used by main actions.
///
/// Set [isEnabled] to activate/deactivate this button's [onPressed] and change his style.
/// Set [isLoading] to override content with a loading animation. It also deactivates [onPressed].
class DSPrimaryButton extends DSButton {
  /// Creates a Design System's [ButtonStyleButton] with primary style.
  DSPrimaryButton({
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
  }) : super(
          backgroundColor: isEnabled
              ? backgroundColor ?? DSColors.primaryNight
              : DSColors.disabledBg,
          foregroundColor: isEnabled
              ? foregroundColor ?? DSColors.neutralLightSnow
              : DSColors.neutralMediumElephant,
        );
}
