import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/buttons/ds_button.widget.dart';
import 'package:flutter/material.dart';

class DSTertiaryButton extends DSButton {
  DSTertiaryButton({
    required super.onPressed,
    super.key,
    super.leadingIcon,
    super.label,
    super.trailingIcon,
    super.disable,
    super.loading,
  }) : super(
          backgroundColor: Colors.transparent,
          foregroundColor: !disable
              ? DSColors.neutralDarkCity
              : DSColors.neutralMediumElephant,
        );
}
