import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/buttons/ds_button.widget.dart';

class DSPrimaryButton extends DSButton {
  DSPrimaryButton({
    required super.onPressed,
    super.key,
    super.leadingIcon,
    super.label,
    super.trailingIcon,
    super.disable,
    super.loading,
  }) : super(
          backgroundColor:
              !disable ? DSColors.primaryNight : DSColors.disabledBg,
          foregroundColor: !disable
              ? DSColors.neutralLightSnow
              : DSColors.neutralMediumElephant,
        );
}
