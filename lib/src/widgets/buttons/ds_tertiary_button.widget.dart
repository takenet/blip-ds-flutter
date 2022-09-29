import 'package:blip_ds/src/widgets/buttons/ds_button.widget.dart';
import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';

/// A Design System's [ButtonStyleButton] primarily used by tertiary actions.
///
/// Set [isEnabled] to activate/deactivate this button's [onPressed] and change his style.
/// Set [isLoading] to override content with a loading animation. It also deactivates [onPressed].
class DSTertiaryButton extends DSButton {
  /// Creates a Design System's [ButtonStyleButton] with tertiary style.
  DSTertiaryButton({
    required super.onPressed,
    super.key,
    super.leadingIcon,
    super.label,
    super.trailingIcon,
    super.isEnabled,
    super.isLoading,
  }) : super(
          backgroundColor: Colors.transparent,
          foregroundColor: isEnabled
              ? DSColors.neutralDarkCity
              : DSColors.neutralMediumElephant,
        );
}
