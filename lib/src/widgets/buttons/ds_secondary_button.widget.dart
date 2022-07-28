import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/buttons/ds_button.widget.dart';

class DSSecondaryButton extends DSButton {
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
