import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/buttons/ds_button.widget.dart';

/// A Design System's [ButtonStyleButton] primarily used by secondary actions.
///
/// Set [disable] to deactivate this button's [onPressed] and change his style.
/// Set [loading] to override content with a loading animation. It also deactivates [onPressed].
class DSSecondaryButton extends DSButton {
  /// Creates a Design System's [ButtonStyleButton] with secondary style.
  DSSecondaryButton({
    required super.onPressed,
    super.key,
    super.leadingIcon,
    super.label,
    super.trailingIcon,
    super.disable,
    super.loading,
  }) : super(
          backgroundColor: DSColors.neutralLightSnow,
          foregroundColor:
              !disable ? DSColors.primaryNight : DSColors.neutralMediumElephant,
          borderColor:
              !disable ? DSColors.primaryNight : DSColors.neutralMediumElephant,
        );
}
