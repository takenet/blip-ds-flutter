import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

import '../../enums/ds_button_shape.enum.dart';

class DSLocationButton extends DSButton {
  DSLocationButton({
    super.key,
    super.onPressed,
    super.isEnabled = true,
    super.label,
    super.autoSize,
    Color backgroundColor = DSColors.primaryLight,
    Color foregroundColor = DSColors.neutralDarkCity,
  }) : super(
          shape: DSButtonShape.rounded,
          leadingIcon: const Icon(
            DSIcons.localization_outline,
          ),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        );
}
