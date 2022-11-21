import 'package:blip_ds/src/widgets/buttons/ds_button.widget.dart';

import '../../themes/colors/ds_colors.theme.dart';

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
  }) : super(
          backgroundColor: DSColors.neutralLightSnow,
          foregroundColor: isEnabled
              ? DSColors.primaryNight
              : DSColors.neutralMediumElephant,
          borderColor: isEnabled
              ? DSColors.primaryNight
              : DSColors.neutralMediumElephant,
        );
}
